Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWE3LWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWE3LWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWE3LWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:22:03 -0400
Received: from www.osadl.org ([213.239.205.134]:7620 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932253AbWE3LWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:22:01 -0400
Subject: Re: RT_PREEMPT problem with cascaded irqchip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Yann.LEPROVOST@wavecom.fr
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Sven-Thorsten Dietrich <sven@mvista.com>
In-Reply-To: <OF7D277146.13CDBC6A-ONC125717E.0039350C-C125717E.0039F142@wavecom.fr>
References: <OF7D277146.13CDBC6A-ONC125717E.0039350C-C125717E.0039F142@wavecom.fr>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:22:44 +0200
Message-Id: <1148988165.20582.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 12:26 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Of course, here is the file arch/arm/mach-at91rm9200/gpio.c with my
> modified gpio_irq_handler.

>             for (i = 0; i < 32; i++, pin++) {
>                   set_irq_chip(pin, &gpio_irqchip);
>                         printk(KERN_ERR "GPIO SET_IRQ_CHIP\n");
>                   set_irq_handler(pin, do_simple_IRQ);

-----------------------------------------^^^^^^^^^^^^^^^

Care to look into the implementation of this ? As the name says, its
simple. It does no ack/mask whatever. Use the level resp. the edge
handler instead.

	tglx




