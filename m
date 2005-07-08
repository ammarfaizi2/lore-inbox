Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVGHHLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVGHHLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVGHHLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:11:54 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:62736 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S262035AbVGHHLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:11:48 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: Andrew Victor <andrew@sanpeople.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <200507080152.03976.adobriyan@gmail.com>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <200507080152.03976.adobriyan@gmail.com>
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1120806643.24896.26.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Jul 2005 09:10:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Alexey,

Thanks for the constructive comments.


> And check for non-NULL data in at91_add_device_usbh() is useless:

There are many more custom AT91RM9200-based boards.  That NULL check is
really just there to help the developers when they write their own
board-XX.c file.


> at91_wdt_ioctl() isn't __user annotated. Let alone it is ioctl.

All the other watchdog drivers use ioctl?  That is how it's described in
Documentation/watchdog/watchdog-api.txt.


> > +       char* command = kmalloc(2, GFP_KERNEL);
> 
> Anyone remembers 1 kmallocated byte?

That command buffer is passed down to the SPI driver, which then DMA's
directly from/to it.  We can't DMA to an address on the stack (atleast
not in 2.4 when that driver was written).


Regards,
  Andrew Victor


