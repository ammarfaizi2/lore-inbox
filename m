Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269950AbUJNDdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbUJNDdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269951AbUJNDdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:33:14 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31930 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S269950AbUJNDdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:33:10 -0400
Date: Wed, 13 Oct 2004 21:28:26 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: select, jiffies, and SIGALRM
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <005d01c4b19d$de6e2a00$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.g84jc6u.73qi0a@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see calls to getitimer, so I'm assuming it's also using setitimer. SIGALRM 
is what you get when those timers go off - if it's not handling that, that's 
a bug, but presumably the timer is in there for a reason..


----- Original Message ----- 
From: "Vx Glenn" <VxGlenn@gmail.com>
Newsgroups: fa.linux.kernel
To: <linux-net@vger.kernel.org>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 13, 2004 10:13 AM
Subject: select, jiffies, and SIGALRM


> Hi all,
>
> I am seeing an issue relating to the jiffies counter wrapping around
> at 0x7FFFFFFF.
>
> This is a legacy application, and when it runs on 32-bit Unix-Like
> OS's, the application silently dies without leaving core after 248
> days.
>
> I was able to manipulate the jiffies counter and run the application.
> I was able to reproduce the problem. I captured an strace log, and I
> see that SIGALRM (alarm clock) is raised after select times out
> (because of no data).
>
> I can add a signal handler to intercept the SIGALRM. But my question
> is, why should the signal be raised?
>
> ---[ strace.log ]---
> select(1024, [3 4 5 6], NULL, NULL, {0, 320000}) = 0 (Timeout)
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 684895}}) 
> = 0
> adjtimex({modes=32769, offset=0, freq=0, maxerror=16384000,
> esterror=16384000, status=64, constant=2, precision=1,
> tolerance=33554432, time={1097551596, 43475}}) = 5
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 684895}}) 
> = 0
> select(1024, [3 4 5 6], NULL, NULL, {1, 0}) = ? ERESTARTNOHAND (To be 
> restarted)
> --- SIGALRM (Alarm clock) @ 0 (0) ---
> Process 4881 detached
> ---[ eof strace.log ]---
>
>
> Anyone have any ideas?
>
>
> -- 
> You're not your Job;
> You're not the contents of your wallet.
> You're the all singing all dancing crap of the world
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

