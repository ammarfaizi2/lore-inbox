Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVIAUqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVIAUqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIAUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:46:40 -0400
Received: from host-84-9-201-83.bulldogdsl.com ([84.9.201.83]:4233 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1030299AbVIAUqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:46:38 -0400
Date: Thu, 1 Sep 2005 21:46:10 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to KERN_INFO
Message-ID: <20050901204610.GA1816@home.fluff.org>
References: <43177223.8030403@gmail.com> <431766C2.2020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431766C2.2020604@gmail.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:38:26PM +0200, Jiri Slaby wrote:
> Alon Bar-Lev napsal(a):
> 
> >Hello,
> >
> >
> >When upgrading to 2.6.13 I've noticed that serial driver reports it 
> >status with unknown severity, causing the boot-splash to be overridden.
> >
> >
> >Please consider this modification.
> >
> >
> >Best Regards,
> >
> >Alon Bar-Lev.
> >
> >
> >At drivers/serial/serial_core.c
> >
> >
> >static inline void
> >
> >uart_report_port(struct uart_driver *drv, struct uart_port *port)
> >{
> >-        printk("%s%d", drv->dev_name, port->line);
> >+      printk(KERN_INFO + "%s%d", drv->dev_name, port->line);
> 
> plus sign between that?
> 
> >
> >        printk(" at ");
> 
> why the fellows didn't put this to the line above?
> >        switch (port->iotype) {
> >        case UPIO_PORT:
> >                printk("I/O 0x%x", port->iobase);
> 
> And what about these?

looks like they're not on a newline, so need no severity.
 
> >                break;
> >        case UPIO_HUB6:
> >                printk("I/O 0x%x offset 0x%x", port->iobase, port->hub6);
> >                break;
> >        case UPIO_MEM:
> >        case UPIO_MEM32:
> >                printk("MMIO 0x%lx", port->mapbase);
> >                break;
> >        }
> >        printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
> >}

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
