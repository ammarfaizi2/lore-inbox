Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLCPvq>; Tue, 3 Dec 2002 10:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLCPvq>; Tue, 3 Dec 2002 10:51:46 -0500
Received: from avscan1.sentex.ca ([199.212.134.11]:40721 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S261732AbSLCPvp>; Tue, 3 Dec 2002 10:51:45 -0500
Message-ID: <006601c29ae5$57b28220$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Martin Buck" <mb-kernel0212@gromit.dyndns.org>,
       <linux-kernel@vger.kernel.org>
References: <20021203093323.GA25957@gromit.at.home>
Subject: Re: Race condition in tty_flip_buffer_push/flush_to_ldisc?
Date: Tue, 3 Dec 2002 11:02:12 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin Buck" <mb-kernel0212@gromit.dyndns.org>
> Suppose I'm running a serial port with low_latency enabled. The low-level
> serial interrupt handler will call tty_flip_buffer_push() which will
> immediately call flush_to_ldisc() due to low_latency being set. In
> flush_to_ldisc(), if the TTY_DONT_FLIP bit is set, it will add itself to
> the timer task queue and return. When the task queue gets processed,
> processing might get interrupted by another serial interrupt or vice
versa,
> resulting in 2 concurrent calls to flush_to_ldisc(). This time, the
> TTY_DONT_FLIP bit probably isn't set, so they both will try to process the
> same flip buffer.

What causes the DONT_FLIP bit to be un/set? I don't think your
situation can occur under normal operation. But ICBW.

> Note that reading the current flip buffer pointers isn't protected by
> cli(), only modifying them is. And even if it were, we could end up
calling
> tty->ldisc.receive_buf() twice for the same tty which probably isn't safe
> either.
>
> Any ideas on how to fix this?

If you search the lkml archive, recently Ted stated that it's
acceptable to call the line discpline's receive_buf() routine
directly, bypassing the flip buffers.

..Stu


