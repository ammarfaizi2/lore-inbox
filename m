Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJFGcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 02:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTJFGcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 02:32:04 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:33443 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261892AbTJFGcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 02:32:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Warnings in 8250_acpi
Date: Mon, 6 Oct 2003 01:31:55 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310060131.55852.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lastest changes in 8250_acpi.c produce warnings about type mismatch
in printk. We could either change format to print long long arguments
or, until most of us are on 64 bits, just trim values to 32.

Dmitry

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
