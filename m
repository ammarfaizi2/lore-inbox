Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUHaE7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUHaE7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUHaE7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:59:11 -0400
Received: from nevyn.them.org ([66.93.172.17]:9152 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266582AbUHaE7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:59:09 -0400
Date: Tue, 31 Aug 2004 00:59:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040831045908.GA11845@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040831042206.GA10577@nevyn.them.org> <200408310455.i7V4tUPk001916@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408310455.i7V4tUPk001916@magilla.sf.frob.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:55:30PM -0700, Roland McGrath wrote:
> > Unless it's been changed since I last pulled, you should also fix up
> > has_stopped_jobs.  I think it's broken by the introduction of
> > TASK_TRACED.
> 
> Actually, I don't think it was broken at all.  It has an old kludge to
> avoid considering trace-stopped threads as stopped for purposes of deciding
> to generate signals for an orphaned process group.  I think that the useful
> thing is for it not to consider any TASK_TRACED thread as stopped here either.
> That's what it will already do, and the old kludge can go now:

[The kludge isn't all that old.  I added it about a year and a half
ago.]

You're right.  I misread the loop.  It's still only an approximation,
in that we don't know what the debugger's intention towards resuming
the program is, but I think we err on the correct side now.

-- 
Daniel Jacobowitz
