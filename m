Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135774AbRD3QrB>; Mon, 30 Apr 2001 12:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRD3Qqv>; Mon, 30 Apr 2001 12:46:51 -0400
Received: from garnet.INS.CWRU.Edu ([129.22.8.233]:47307 "EHLO
	garnet.INS.cwru.edu") by vger.kernel.org with ESMTP
	id <S135774AbRD3Qqe>; Mon, 30 Apr 2001 12:46:34 -0400
Date: Mon, 30 Apr 2001 12:44:17 -0400
From: Chet Ramey <chet@nike.ins.cwru.edu>
To: adam@yggdrasil.com
Subject: Re: Patch(?): bash-2.05/jobs.c loses interrupts
Cc: bug-bash@gnu.org, linux-kernel@vger.kernel.org, chet@po.cwru.edu
Reply-To: chet@po.cwru.edu
Message-ID: <010430164417.AA94167.SM@nike.ins.cwru.edu>
Read-Receipt-To: chet@po.CWRU.Edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-In-Reply-To: Message from adam@yggdrasil.com of Sun, 29 Apr 2001 00:14:31 -0700 (id <20010429001431.A3729@adam.yggdrasil.com>)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Linux-2.4.4 has a change, for which I must accept blame,
> where fork() runs the child first, reducing unnecessary copy-on-write
> page duplications, because the child will usually promptly do an
> exec().  I understand this is pretty standard in most unixes.
> 
> 	Peter Osterlund noticed an annoying side effect of this,
> which I think is a bash bug.  He wrote:
> 
> > Another thing is that the bash loop "while true ; do /bin/true ; done" is
> > not possible to interrupt with ctrl-c.
> 
> 	I have reproduced this problem on a single CPU system.
> I also modified my kernel to sometimes run the fork child first
> and sometimes not.  In that case, that loop would sometimes
> abort on a control-C and sometimes ignore it, but ignoring it
> would not make the loop less likely to abort on another control-C.
> I'm pretty sure the control-C was being delivered only to the child
> due to a race condition in bash, which may be mandated by posix.

Did you reconfigure and rebuild bash on your machine running the 2.4
kernel, or just use a bash binary built on a previous kernel version?

Bash has an autoconf test that will, if it detects the need to do so,
force the job control code to synchronize between parent and child
when setting up the process group for a new pipeline.  It may be the
case that you have to reconfigure and rebuild bash to enable that code.

Look for PGRP_PIPE in config.h.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
( ``Discere est Dolere'' -- chet)

Chet Ramey, CWRU    chet@po.CWRU.Edu    http://cnswww.cns.cwru.edu/~chet/
