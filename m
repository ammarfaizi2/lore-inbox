Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUDTB2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUDTB2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 21:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDTB2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 21:28:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18818 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262080AbUDTB2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 21:28:13 -0400
Date: Mon, 19 Apr 2004 21:32:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Fabiano Ramos <fabramos@bol.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: task switching at Page Faults
In-Reply-To: <1082399579.1146.15.camel@slack.domain.invalid>
Message-ID: <Pine.LNX.4.53.0404192127240.8297@chaos>
References: <1082399579.1146.15.camel@slack.domain.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Fabiano Ramos wrote:

> Hi all.
>
> 	I am in doubt about the linux kernel behaviour is this situation:
> supose a have the process A, with the highest realtime
> priority and SCHED_FIFO policy. The process then issues a syscall,
> say read():
>
> 	1) Can I be sure that there will be no process switch during the
> syscall processing, even if the system call causes a page fault?
>
> 	2) What if the process was a non-realtime processes (ordinary
> one, SCHED_OTHER)?
>
>
> Thanks a lot.
> Fabiano


Read() from a device will probably sleep so you will certainly
end up losing the CPU while the data are being fetched. You can
prevent any of your processes pages from being faulted out.
See mlockall() and friends.

Normally, a system call does not cause a context switch. The kernel
handles the requirements of the caller in the context of the caller
just like a library. BUT.... If the kernel needs to wait for something,
it will always give the CPU to some runable task. That causes a
context-switch. The kernel does not busy-wait, i.e, spin.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


