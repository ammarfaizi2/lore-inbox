Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbTJKDs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 23:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTJKDsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 23:48:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263248AbTJKDsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 23:48:22 -0400
Date: Sat, 11 Oct 2003 04:48:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Robert White <rwhite@casabyte.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Here is a case that proves my previous position wrong regurading CLONE_THREAD and CLONE_FILES
Message-ID: <20031011034818.GH7665@parcelfarce.linux.theplanet.co.uk>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAl4UIR+3nFUmBp1aNINMhFgEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAl4UIR+3nFUmBp1aNINMhFgEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:02:49PM -0700, Robert White wrote:
> For those who care:
> 
> Earlier I was phrasing arguments for requiring that the CLONE_THREAD
> argument to clone() require implication of CLONE_FILES.  I officially recant
> those arguments.  In those prior posts I asked for a specific demonstrable
> case against this requirement.  Having found one myself, I provide it here
> so that if the question comes up again from other quarters it can be
> answered (or killed 8-) more easily.
> 
> [This post is significantly aimed at persons searching the mailing list so
> please forgive some of the more elementary observations.  Near the end I do
> a compare and contrast of the kernel provided clone() feature to the pthread
> and java task paradigms for those who got here via the words "thread" or
> "task".]

[snip]

One note: non-shared descriptor table with shared VM (or vice versa) is
not unique to Linux.  *BSD have a syscall very similar in spirit to clone(2)
- rfork(2).  So does Plan 9, where that beast had originated.

IOW, that model is actually *absent* only in SysV - arguably, the least
Unix-like of Unix clones...

{Free,Open,Net}BSD rfork() differs from clone() only in arguments.  Plan 9
one always gives task-private stack - even if VM is otherwise shared.

BTW, there's a bunch of syscalls that require careful userland code if
descriptors _are_ shared - select() is a good example, since we get the
answer in terms of descriptor table at the moment of call.  Having one
thread put descriptor 42 into set, call select and return after another
thread does close(42); or dup2(fd, 42)...
