Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263121AbSJHDUP>; Mon, 7 Oct 2002 23:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbSJHDTe>; Mon, 7 Oct 2002 23:19:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:45840 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S262932AbSJHDTa>; Mon, 7 Oct 2002 23:19:30 -0400
Message-ID: <3DA25005.A25EBDF@digeo.com>
Date: Mon, 07 Oct 2002 20:24:53 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dahl <dahlm@izno.net>, Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41-ac1: Debug: sleeping function called from illegal context at 
 include/asm/semaphore.h:145
References: <20021008031136.GA1887@izno.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dahl wrote:
> 
> ...
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:145
> Call Trace:
>  [<c01a14f8>] acpi_os_wait_semaphore+0x1e8/0x240
>  [<c01ce53d>] acpi_ut_acquire_mutex+0xdd/0x200
>  [<c01b6334>] acpi_ex_enter_interpreter+0x44/0xa0
>  [<c01ad33d>] acpi_acquire_global_lock+0x1d/0x60
>  [<c01d5ed9>] acpi_ec_query+0x79/0x1c0
>  [<c01d61bc>] acpi_ec_gpe_handler+0x8c/0xf0
>  [<c01aa319>] acpi_ev_gpe_dispatch+0x229/0x2b0
>  [<c01a9f6f>] acpi_ev_gpe_detect+0x14f/0x160
>  [<c01aaf4e>] acpi_ev_sci_handler+0x9e/0xc0
>  [<c01a0971>] acpi_irq+0x11/0x20
>  [<c0108dc5>] handle_IRQ_event+0x45/0x70
>  [<c01a0960>] acpi_irq+0x0/0x20
>  [<c0108ff7>] do_IRQ+0x97/0x120
>  [<c01053f0>] default_idle+0x0/0x40
>  [<c01053f0>] default_idle+0x0/0x40
>  [<c0107970>] common_interrupt+0x18/0x20

ewww.

acpi_os_wait_semaphore() is doing down_interruptible() and
schedule_timeout() in hard interrupt context.
