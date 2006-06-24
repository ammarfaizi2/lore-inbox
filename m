Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWFXMbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWFXMbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWFXMbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:31:49 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33479 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964813AbWFXMbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:31:48 -0400
Date: Sat, 24 Jun 2006 08:31:45 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: =?BIG5?B?s1yspbuo?= <brianhsu.hsu@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A question about behavior of SCHED_FIFO: Only one process in
 run queue at any time.
In-Reply-To: <615cd8d10606240224m2a0dece7t3bdb41df0dae71f2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606240828430.23087@gandalf.stny.rr.com>
References: <615cd8d10606240224m2a0dece7t3bdb41df0dae71f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Jun 2006, [BIG5] ³\¬¥»¨ wrote:

>
> I have read some textbook about OS and Linux kernel, according to these books,
> SCHED_FIFO is a real-time scheduling policy, and when a process is a SCHED_FIFO
> process, it will be preempted only when follwing case happend:
>
> 1.There are some process with higher priority.
> 2.The process is in blocking opreation.
> 3.The process is dead.
> 4.sched_yield()

That all sounds right.

>
> Man page of sched_setscheduler even says:"SCHED_FIFO is a  simple
> scheduling  algorithm  without  time slicing."

Correct.

>
> Then I worte an user space program (in the attachment),
> which fork an SCHED_FIFO child process, it does nothing expect an infinite loop
> and print something on screen.

How did you run more than one SCHED_FIFO process?  If you are not on a SMP
machine, as soon as you run 1 of these children, it will run to completion
because it is higher priority than any other process.  So the next
child you run will run after that.

>
> Here is the dmesg result, it is clearly these process is in the same
> queue, and there
> is only one process in the queue at any time point.
>
> RT-Queue[1]:P[9822] ->
> RT-Queue[1]:P[9822] ->
> RT-Queue[1]:P[9810] ->
> RT-Queue[1]:P[9810] ->
> RT-Queue[1]:P[9816] ->
> RT-Queue[1]:P[9816] ->
> RT-Queue[1]:P[9822] ->
> RT-Queue[1]:P[9822] ->
>
> Did I misunderstand about SCHED_FIFO policy?
>

No, but I still don't know how you ran all of them.

-- Steve

