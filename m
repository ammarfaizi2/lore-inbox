Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVCSWPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVCSWPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCSWOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:14:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:13797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbVCSWOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:14:43 -0500
Date: Sat, 19 Mar 2005 14:13:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Bitrotting serial drivers
Message-Id: <20050319141351.74f6b2a5.akpm@osdl.org>
In-Reply-To: <20050319172101.C23907@flint.arm.linux.org.uk>
References: <20050319172101.C23907@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Hi,
> 
> m32r_sio
> --------
> 
> Maintainer: Hirokazu Takata
> 
> Please clean up the m32r_sio driver, removing whatever bits of code
> aren't absolutely necessary.
> 
> Specifically, I'd like to see the following addressed:
> 
> - the usage of SERIAL_IO_HUB6
>   (this driver doesn't support hub6 cards)
> - SERIAL_IO_* should be UPIO_*
> - __register_m32r_sio, register_m32r_sio, unregister_m32r_sio,
>   m32r_sio_get_irq_map
>   (this driver doesn't support PCMCIA cards, all of which are based on
>    8250-compatible devices.)
> - early_serial_setup
>   (should we really have the function name duplicated across different
>    hardware drivers?)
> 
> au1x00_uart
> -----------
> 
> Maintainer: unknown (akpm - any ideas?)

Ralf.

> This is a complete clone of 8250.c, which includes all the 8250-specific
> structure names.
> 
> Specifically, I'd like to see the following addressed:
> 
> - Please clean this up to use au1x00-specific names.
> - this driver is lagging behind with fixes that the other drivers are
>   getting.  Is au1x00_uart actually maintained?
> - the usage of UPIO_HUB6
>   (this driver doesn't support hub6 cards)
> - __register_serial, register_serial, unregister_serial
>   (this driver doesn't support PCMCIA cards, all of which are based on
>    8250-compatible devices.)
> - early_serial_setup
>   (should we really have the function name duplicated across different
>    hardware drivers?)
> 
> The main reason is I wish to kill off uart_register_port and
> uart_unregister_port, but these drivers are using it.
> 
> Thanks.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
