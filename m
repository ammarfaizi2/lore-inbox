Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136523AbRD3WF6>; Mon, 30 Apr 2001 18:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136524AbRD3WFt>; Mon, 30 Apr 2001 18:05:49 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:36766 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S136523AbRD3WFd>; Mon, 30 Apr 2001 18:05:33 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Apr 2001 15:05:30 -0700
Message-Id: <200104302205.PAA04835@adam.yggdrasil.com>
To: chet@nike.ins.cwru.edu
Subject: Re: Patch(?): bash-2.05/jobs.c loses interrupts
Cc: bug-bash@gnu.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Linux-2.4.4 has a change, for which I must accept blame,
>> where fork() runs the child first, reducing unnecessary copy-on-write
>> page duplications, because the child will usually promptly do an
>> exec().  I understand this is pretty standard in most unixes.
>> 
>> 	Peter Osterlund noticed an annoying side effect of this,
>> which I think is a bash bug.  He wrote:
>> 
>> > Another thing is that the bash loop "while true ; do /bin/true ; done" is
>> > not possible to interrupt with ctrl-c.
>> 
>> 	I have reproduced this problem on a single CPU system.
>> I also modified my kernel to sometimes run the fork child first
>> and sometimes not.  In that case, that loop would sometimes
>> abort on a control-C and sometimes ignore it, but ignoring it
>> would not make the loop less likely to abort on another control-C.
>> I'm pretty sure the control-C was being delivered only to the child
>> due to a race condition in bash, which may be mandated by posix.

>Did you reconfigure and rebuild bash on your machine running the 2.4
>kernel, or just use a bash binary built on a previous kernel version?

>Bash has an autoconf test that will, if it detects the need to do so,
>force the job control code to synchronize between parent and child
>when setting up the process group for a new pipeline.  It may be the
>case that you have to reconfigure and rebuild bash to enable that code.

>Look for PGRP_PIPE in config.h.

	Rebuilding bash from pristine 2.05 sources under such a kernel
does *not* solve the problem.  PGRP_PIPE is undef'ed in the resulting
config.h.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

