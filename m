Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVIAUma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVIAUma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVIAUma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:42:30 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:17030 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1030291AbVIAUm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:42:29 -0400
Message-ID: <431766C2.2020604@gmail.com>
Date: Thu, 01 Sep 2005 22:38:26 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to
 KERN_INFO
References: <43177223.8030403@gmail.com>
In-Reply-To: <43177223.8030403@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev napsal(a):

> Hello,
>
>
> When upgrading to 2.6.13 I've noticed that serial driver reports it 
> status with unknown severity, causing the boot-splash to be overridden.
>
>
> Please consider this modification.
>
>
> Best Regards,
>
> Alon Bar-Lev.
>
>
> At drivers/serial/serial_core.c
>
>
> static inline void
>
> uart_report_port(struct uart_driver *drv, struct uart_port *port)
> {
> -        printk("%s%d", drv->dev_name, port->line);
> +      printk(KERN_INFO + "%s%d", drv->dev_name, port->line);

plus sign between that?

>
>         printk(" at ");

why the fellows didn't put this to the line above?

>         switch (port->iotype) {
>         case UPIO_PORT:
>                 printk("I/O 0x%x", port->iobase);

And what about these?

>                 break;
>         case UPIO_HUB6:
>                 printk("I/O 0x%x offset 0x%x", port->iobase, port->hub6);
>                 break;
>         case UPIO_MEM:
>         case UPIO_MEM32:
>                 printk("MMIO 0x%lx", port->mapbase);
>                 break;
>         }
>         printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
> }

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

