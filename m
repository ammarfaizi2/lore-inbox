Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWJUKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWJUKQt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWJUKQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:16:49 -0400
Received: from 1wt.eu ([62.212.114.60]:2564 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1161197AbWJUKQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:16:49 -0400
Date: Sat, 21 Oct 2006 12:16:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bastian Blank <bastian@waldi.eu.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.18 - check for chroot, broken root and cwd values in procfs
Message-ID: <20061021101623.GB1709@1wt.eu>
References: <20061012140224.GA7632@wavehammer.waldi.eu.org> <20061013230617.GA15489@wavehammer.waldi.eu.org> <m1pscvfvl1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pscvfvl1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 09:02:50PM -0600, Eric W. Biederman wrote:
> Bastian Blank <bastian@waldi.eu.org> writes:
> 
> > On Thu, Oct 12, 2006 at 04:02:24PM +0200, Bastian Blank wrote:
> >> The commit 778c1144771f0064b6f51bee865cceb0d996f2f9 replaced the old
> >> root-based security checks in procfs with processed based ones.
> >
> > The new behaviour even allows a user to escape from the chroot by using
> > chdir to /proc/$pid/cwd or /proc/$pid/root of a process he owns and
> > lives outside of the chroot.
> 
> Yep.  It makes it obvious that you can do that.
> 
> If you were in a chroot you could always ptrace a process you own
> that was outside of the chroot, and cause it to do things, such as
> open a unix domain socket and pass you it's current root directory.

yes, but it's a bit trickier than remotely telling a script to basically
do chdir("/proc/1/cwd").

> chroot by itself has never been much of a jail.

OK, but that's not a reason for breaking trivial protection against
trivial escape methods.

Also, people sometimes compose build environments using chroot, which
at least protect them from accidental escape and corruption of the root
FS. It is a bit scary to know that a poorly designed install script
could break out of the chroot by abusing /proc or simply doing dirty
things such as "find / -follow" for any valid purpose under such an
environment.

Chroot is a useful tool for build and test environments, it's dangerous
to break it that way.

I'd clearly prefer that tasks outside the chroot show broken links
for cwd, root and exe under /proc.

Regards,
willy

