Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWABJPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWABJPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 04:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWABJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 04:15:52 -0500
Received: from mail.gmx.net ([213.165.64.21]:32141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932338AbWABJPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 04:15:51 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 02 Jan 2006 10:15:43 +0100
To: Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20060101123902.27a10798@localhost>
References: <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0550-0, 12/10/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:39 PM 1/1/2006 +0100, Paolo Ornati wrote:
>On Sat, 31 Dec 2005 17:37:11 +0100
>Mike Galbraith <efault@gmx.de> wrote:
>
> > Strange.  Using the exact same arguments, I do see some odd bouncing up to
> > high priorities, but they spend the vast majority of their time down at 25.
>
>Mmmm... to make it more easly reproducible I've enlarged the sleep time
>(1 microsecond is likely to be rounded too much and give different
>results on different hardware/kernel/config...).
>
>Compile this _without_ optimizations and try again:

<snip>

>Try different values: 1000, 2000, 3000 ... are you able to reproduce it
>now?

Yeah.  One instance running has to sustain roughly _95%_ cpu before it's 
classified as a cpu piggy.  Not good.

>If yes, try to start 2 of them with something like this:
>
>"./a.out 3000 & ./a.out 3161"
>
>so they are NOT syncronized and they use almost all the CPU time:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5582 paolo     16   0  2396  320  252 S 45.7  0.1   0:05.52 a.out
>  5583 paolo     15   0  2392  320  252 S 45.7  0.1   0:05.49 a.out
>
>This is the bad situation I hate: some cpu-eaters that eat all the CPU
>time BUT have a really good priority only because they sleeps a bit.

Yup, your proggy fools the interactivity estimator quite well.  This 
problem was addressed a long time ago, and thought to be more or less 
cured.  Guess not.

         -Mike 

