Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVLaQha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVLaQha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLaQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:37:29 -0500
Received: from mail.gmx.net ([213.165.64.21]:61929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965011AbVLaQh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:37:27 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 31 Dec 2005 17:37:11 +0100
To: Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20051231161134.4236c37a@localhost>
References: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0550-0, 12/10/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:11 PM 12/31/2005 +0100, Paolo Ornati wrote:
>On Sat, 31 Dec 2005 09:13:24 +0100
>Mike Galbraith <efault@gmx.de> wrote:
>
> > Ingo seems to have done something in 2.6.15-rc7-rt1 which defeats your
> > little proggy.  Taking a quick peek at the rt scheduler changes, nothing
> > poked me in the eye, but by golly, I can't get this kernel to act up,
> > whereas 2.6.14-virgin does.
>
>Ok, I've sucessfully booted 2.6.15-rc7-rt1 (I think that I was
>having troubles with Thread Softirqs and/or Thread Hardirqs).
>
>First thing: I've preemption disabled, but it shouldn't matter too much
>since we are talking about priority calculation...

Mine is fully preemptible.

>1) My program isn't defeated at all. If I start it with the same args
>of the previous examples it "seems" defeated, but it isn't.
>
>Lowering the "cpu burn argument" I can reproduce the problem again:
>
>"./a.out 200 & ./a.out 333"
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5607 paolo     15   0  2396  320  252 R 56.1  0.1   0:06.79 a.out
>  5606 paolo     15   0  2396  324  252 R 38.7  0.1   0:04.55 a.out
>     1 root      16   0  2556  552  468 S  0.0  0.1   0:00.28 init

Strange.  Using the exact same arguments, I do see some odd bouncing up to 
high priorities, but they spend the vast majority of their time down at 25.

         -Mike 

