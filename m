Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUDSXHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDSXHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUDSXHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:07:05 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22658 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261184AbUDSXHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:07:01 -0400
Date: Tue, 20 Apr 2004 01:07:37 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?q?Fabiano=20Ramos?= <ramos_fabiano@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: task switching at Page Faults
In-Reply-To: <20040419201230.45125.qmail@web20210.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0404200103330.18802@artax.karlin.mff.cuni.cz>
References: <20040419201230.45125.qmail@web20210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	I am in doubt about the linux kernel behaviour is
> > this situation:
> > > supose a have the process A, with the highest
> > realtime
> > > priority and SCHED_FIFO policy. The process then
> > issues a syscall,
> > > say read():
> > >
> > > 	1) Can I be sure that there will be no process
> > switch during the
> > > syscall processing, even if the system call causes
> > a page fault?
> >
> > No. If the data read is not in cache and if read
> > operations causes page
> > fault there will be process switch.
> >
> > Additionally, if you don't mlock memory, there can
> > be process switch at
> > any place, because of page faults on code pages or
> > swapping of data pages.
>
>     I was reading the book "Understanding the Linux
> kernel", about 2.4, and the authors:
>     1)assure that there is no process switch during
> the execution of an eception handler (aka syscall).
> they emphasize it.

It is wrong. The process switch will occur, if the process blocks waiting
for some resource (disk IO, keyboard, net or similar). Moreover, on 2.6
kernels, if you turn on CONFIG_PREEMPT, process switch in kernel may occur
almost anywhere

>     2) say that the execption handler may not generate
> exceptions, except for page faults.

That's true. Kernel can generate only page fault.

>      So, if process switching occurs at page faults, I
> was wondering which statement is true of if I am
> missing sth.
>      You mentioned page faults due to code. Aren´t the
> syscall handlers located in mlocked?

Kernel is nonswappable, but when the syscalls returns from kernel, it can
generate page-fault because of its code or data were paged-out.

Mikulas

> Thanks again
> Fabiano
