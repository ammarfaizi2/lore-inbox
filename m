Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273558AbRIQKI4>; Mon, 17 Sep 2001 06:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273554AbRIQKIr>; Mon, 17 Sep 2001 06:08:47 -0400
Received: from PA1-1C-u-0120.mc.onolab.com ([62.42.200.121]:32269 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id <S272548AbRIQKIh>;
	Mon, 17 Sep 2001 06:08:37 -0400
Date: Mon, 17 Sep 2001 12:09:54 +0200
From: Celso Gonzalez <mitago@ono.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Little bug in 8139too net driver
Message-ID: <20010917120954.A14699@debian>
Reply-To: mitago@ono.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22i
X-Mailer: Mutt 1.3.22i (2001-08-30)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch fixes a bug with an unasigned variable in the net driver 8139too
when its compiled with the
CONFIG_8139TOO_PIO=y option from kernel 2.4.3 to 2.4.9

The error message normally is "Assertion failed! ioaddr != NULL"


diff -u -r linux-2.4.9/drivers/net/8139too.c
linux-2.4.9-patched/drivers/net/8139too.c
--- linux-2.4.9/drivers/net/8139too.c   Sun Aug 12 19:52:29 2001
+++ linux-2.4.9-patched/drivers/net/8139too.c   Mon Sep 17 11:10:40 2001
@@ -825,6 +825,7 @@
 #ifdef USE_IO_OPS
        ioaddr = (void *) pio_start;
        dev->base_addr = pio_start;
+       tp->mmio_addr = ioaddr;
 #else
        /* ioremap MMIO region */
        ioaddr = ioremap (mmio_start, mmio_len);

I try to contact with Jeff Garzik , but seems heŽs missing. 

Regards

Celso González
(mitago@ono.com)
