Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUKNUQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUKNUQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUKNUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:16:03 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:14573
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261345AbUKNUPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:15:53 -0500
Message-ID: <4197BCEE.1080409@ppp0.net>
Date: Sun, 14 Nov 2004 21:15:42 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] matrox w1: fix integer to pointer conversion warnings
References: <41974A6C.20302@ppp0.net> <20041114230617.5ce14ce9@zanzibar.2ka.mipt.ru>
In-Reply-To: <20041114230617.5ce14ce9@zanzibar.2ka.mipt.ru>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040900070800070305010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900070800070305010207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Evgeniy Polyakov wrote:
> On Sun, 14 Nov 2004 13:07:08 +0100
> Jan Dittmer <jdittmer@ppp0.net> wrote:
> 
> 
>>Get rid of some pointer to integer conversion warnings
>>in the matrox w1 bus driver.
> 

You mean like this? (Incremental to the other one)

Jan


--------------040900070800070305010207
Content-Type: text/x-patch;
 name="w1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="w1.diff"

===== matrox_w1.c 1.4 vs edited =====
--- 1.4/drivers/w1/matrox_w1.c	2004-11-14 13:02:18 +01:00
+++ edited/matrox_w1.c	2004-11-14 21:15:09 +01:00
@@ -78,12 +78,12 @@
 
 struct matrox_device
 {
-	char *base_addr;
-	char *port_index, *port_data;
+	char __iomem *base_addr;
+	char __iomem *port_index, *port_data;
 	u8 data_mask;
 
 	unsigned long phys_addr;
-	char *virt_addr;
+	char __iomem *virt_addr;
 	unsigned long found;
 
 	struct w1_bus_master *bus_master;
@@ -227,7 +227,7 @@
 
 	if (dev->found) {
 		w1_remove_master_device(dev->bus_master);
-		iounmap((void *) dev->virt_addr);
+		iounmap(dev->virt_addr);
 	}
 	kfree(dev);
 }

--------------040900070800070305010207--
