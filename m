Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136640AbREAQEw>; Tue, 1 May 2001 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136638AbREAQEg>; Tue, 1 May 2001 12:04:36 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:37380 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S136645AbREAQES>;
	Tue, 1 May 2001 12:04:18 -0400
Message-ID: <20010501180222.A18016@bug.ucw.cz>
Date: Tue, 1 May 2001 18:02:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: chet@po.cwru.edu, adam@yggdrasil.com
Cc: bug-bash@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): bash-2.05/jobs.c loses interrupts
In-Reply-To: <010430164417.AA94167.SM@nike.ins.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <010430164417.AA94167.SM@nike.ins.cwru.edu>; from Chet Ramey on Mon, Apr 30, 2001 at 12:44:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	Linux-2.4.4 has a change, for which I must accept blame,
> > where fork() runs the child first, reducing unnecessary copy-on-write
> > page duplications, because the child will usually promptly do an
> > exec().  I understand this is pretty standard in most unixes.
> > 
> > 	Peter Osterlund noticed an annoying side effect of this,
> > which I think is a bash bug.  He wrote:
> > 
> > > Another thing is that the bash loop "while true ; do /bin/true ; done" is
> > > not possible to interrupt with ctrl-c.
> > 
> > 	I have reproduced this problem on a single CPU system.
> > I also modified my kernel to sometimes run the fork child first
> > and sometimes not.  In that case, that loop would sometimes
> > abort on a control-C and sometimes ignore it, but ignoring it
> > would not make the loop less likely to abort on another control-C.
> > I'm pretty sure the control-C was being delivered only to the child
> > due to a race condition in bash, which may be mandated by posix.
> 
> Did you reconfigure and rebuild bash on your machine running the 2.4
> kernel, or just use a bash binary built on a previous kernel
> version?

This is nasty race condition. I do not believe you can test for it in
configure. 

This might happen on 2.4.3 (occasionally) too. Kernel is permitted to
do any kind of scheduling!

								Pavel

> Bash has an autoconf test that will, if it detects the need to do so,
> force the job control code to synchronize between parent and child
> when setting up the process group for a new pipeline.  It may be the
> case that you have to reconfigure and rebuild bash to enable that code.
> 
> Look for PGRP_PIPE in config.h.


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
