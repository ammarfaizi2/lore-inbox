Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTJFQHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTJFQHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:07:42 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:65450 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263898AbTJFQHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:07:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2.6] Warnings in 8250_acpi
Date: Mon, 6 Oct 2003 10:07:36 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310060131.55852.dtor_core@ameritech.net> <20031006093811.A12713@flint.arm.linux.org.uk>
In-Reply-To: <20031006093811.A12713@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310061007.36240.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 October 2003 2:38 am, Russell King wrote:
> On Mon, Oct 06, 2003 at 01:31:55AM -0500, Dmitry Torokhov wrote:
> > Lastest changes in 8250_acpi.c produce warnings about type mismatch
> > in printk. We could either change format to print long long arguments
> > or, until most of us are on 64 bits, just trim values to 32.
> 
> I'd like Bjorn to comment before I apply this.

Oops, sorry about that.  Here's my preference for fixing it:

===== drivers/serial/8250_acpi.c 1.3 vs edited =====
--- 1.3/drivers/serial/8250_acpi.c	Wed Oct  1 03:11:17 2003
+++ edited/drivers/serial/8250_acpi.c	Mon Oct  6 12:33:54 2003
@@ -28,8 +28,7 @@
 	req->iomem_base = ioremap(req->iomap_base, size);
 	if (!req->iomem_base) {
 		printk(KERN_ERR "%s: couldn't ioremap 0x%lx-0x%lx\n",
-			__FUNCTION__, addr->min_address_range,
-			addr->max_address_range);
+			__FUNCTION__, req->iomap_base, req->iomap_base + size);
 		return AE_ERROR;
 	}
 	req->io_type = SERIAL_IO_MEM;



