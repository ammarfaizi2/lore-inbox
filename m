Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUCCMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbUCCMsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:48:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10881 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262455AbUCCMhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:37:23 -0500
Date: Wed, 3 Mar 2004 07:38:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <52vflmpoe9.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0403030736350.11111@chaos>
References: <Pine.LNX.4.53.0403021817050.9351@chaos> <404521B2.2030504@americasm01.nt.com>
 <Pine.LNX.4.53.0403022006250.9695@chaos> <52vflmpoe9.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Roland Dreier wrote:

>     Richard> Well the device's poll function isn't getting called the
>     Richard> second time with 2.6.0. I never checked it in 2.4.x
>     Richard> because it always worked.  This problem occurs in a
>     Richard> driver that only returns the fact that one event
>     Richard> occurred. When it failed to report the event when built
>     Richard> with a newer kernel, I added diagnostics which showed
>     Richard> that the poll in the driver was only called once --and
>     Richard> that the return from poll_wait happened immediately.
>
> Your driver is buggy.  It's not surprising since you fundamentally
> don't understand the kernel interface you're trying to use.
>
>     Richard> So, if the poll_wait isn't a wait-function, but just some
>     Richard> add-wakeup to the queue function, then its name probably
>     Richard> should have been changed when it changed. At one time it
>     Richard> did, truly, wait until it was awakened with
>     Richard> wake_up_interruptible.
>
> When did it change?  Show me a kernel version where poll_wait() waited
> until the driver woke it up.  (Kernel versions at least as far back as
> 1.0 are readily available from kernel.org, so it should be easy for
> you)
>
>  - Roland
>

I never said the DRIVER woke up, but that poll sleeps.

 FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
   100     0     1     0   6   0    224   148 do_select   S   ?   0:01 /sbin/init auto
[SNIPPED....]

    40     0   115   114   9   0   1452   728 pipe_wait   S   ?   0:00 /usr/sbin/nmbd -D
100000     0 11109  9459  16   0   1044   476             R    1  0:00 ps -laxw
     0     0 11107  9504  12   0    692   216 do_poll     S    2  0:00 ./tester


.... and if it DOESN'T then ps is buggy and/or the entry in /proc
in buggy.

Clearly this task is sleeping in do_poll.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


