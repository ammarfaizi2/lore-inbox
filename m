Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTJFIiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTJFIiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:38:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6661 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262836AbTJFIiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:38:17 -0400
Date: Mon, 6 Oct 2003 09:38:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Warnings in 8250_acpi
Message-ID: <20031006093811.A12713@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
References: <200310060131.55852.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200310060131.55852.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Oct 06, 2003 at 01:31:55AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 01:31:55AM -0500, Dmitry Torokhov wrote:
> Lastest changes in 8250_acpi.c produce warnings about type mismatch
> in printk. We could either change format to print long long arguments
> or, until most of us are on 64 bits, just trim values to 32.

I'd like Bjorn to comment before I apply this.

--- 1.3/drivers/serial/8250_acpi.c      Wed Oct  1 04:11:17 2003
+++ edited/drivers/serial/8250_acpi.c   Mon Oct  6 01:18:22 2003
@@ -28,8 +28,9 @@
        req->iomem_base = ioremap(req->iomap_base, size);
        if (!req->iomem_base) {
                printk(KERN_ERR "%s: couldn't ioremap 0x%lx-0x%lx\n",
-                       __FUNCTION__, addr->min_address_range,
-                       addr->max_address_range);
+                       __FUNCTION__,
+                       (unsigned long)addr->min_address_range,
+                       (unsigned long)addr->max_address_range);
                return AE_ERROR;
        }
        req->io_type = SERIAL_IO_MEM;

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
