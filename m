Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAAMcu>; Mon, 1 Jan 2001 07:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAAMck>; Mon, 1 Jan 2001 07:32:40 -0500
Received: from adsl-65-64-162-194.dsl.snantx.swbell.net ([65.64.162.194]:35851
	"EHLO gearbox.exploits.org") by vger.kernel.org with ESMTP
	id <S129562AbRAAMc2>; Mon, 1 Jan 2001 07:32:28 -0500
Date: Mon, 01 Jan 2001 06:01:15 -0600
From: Russell Kroll <rkroll@exploits.org>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] 2.4.0-prerelease: radio card request_region fixes
Cc: linux-kernel@vger.kernel.org
Message-ID: <3A50718B.mailOM11K4AFD@exploits.org>
User-Agent: nail 9.23 11/15/00
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the radio card drivers got the request_region sense inverted and
make a horrible mess on insmod.  I've tested the patches in this set for
radio-aimslab and radio-aztech locally.  The others are "obviously
correct" since they are the same core code.

--- drivers/media/radio/radio-aimslab.c.stock	Mon Jan  1 05:14:29 2001
+++ drivers/media/radio/radio-aimslab.c	Mon Jan  1 05:14:35 2001
@@ -338,7 +338,7 @@
 		return -EINVAL;
 	}
 
-	if (request_region(io, 2, "rtrack")) 
+	if (!request_region(io, 2, "rtrack")) 
 	{
 		printk(KERN_ERR "rtrack: port 0x%x already in use\n", io);
 		return -EBUSY;
--- drivers/media/radio/radio-aztech.c.stock	Mon Jan  1 05:35:07 2001
+++ drivers/media/radio/radio-aztech.c	Mon Jan  1 05:35:15 2001
@@ -289,7 +289,7 @@
 		return -EINVAL;
 	}
 
-	if (request_region(io, 2, "aztech")) 
+	if (!request_region(io, 2, "aztech")) 
 	{
 		printk(KERN_ERR "aztech: port 0x%x already in use\n", io);
 		return -EBUSY;
--- drivers/media/radio/radio-rtrack2.c.stock	Mon Jan  1 05:42:52 2001
+++ drivers/media/radio/radio-rtrack2.c	Mon Jan  1 05:43:02 2001
@@ -230,7 +230,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=0x20c or io=0x30c\n");
 		return -EINVAL;
 	}
-	if (request_region(io, 4, "rtrack2")) 
+	if (!request_region(io, 4, "rtrack2")) 
 	{
 		printk(KERN_ERR "rtrack2: port 0x%x already in use\n", io);
 		return -EBUSY;
--- drivers/media/radio/radio-sf16fmi.c.stock	Mon Jan  1 05:44:36 2001
+++ drivers/media/radio/radio-sf16fmi.c	Mon Jan  1 05:44:43 2001
@@ -291,7 +291,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=0x???\n");
 		return -EINVAL;
 	}
-	if (request_region(io, 2, "fmi")) 
+	if (!request_region(io, 2, "fmi")) 
 	{
 		printk(KERN_ERR "fmi: port 0x%x already in use\n", io);
 		return -EBUSY;
--- drivers/media/radio/radio-terratec.c.stock	Mon Jan  1 05:45:13 2001
+++ drivers/media/radio/radio-terratec.c	Mon Jan  1 05:45:26 2001
@@ -309,7 +309,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=0x???\n");
 		return -EINVAL;
 	}
-	if (request_region(io, 2, "terratec")) 
+	if (!request_region(io, 2, "terratec")) 
 	{
 		printk(KERN_ERR "TerraTec: port 0x%x already in use\n", io);
 		return -EBUSY;
--- drivers/media/radio/radio-trust.c.stock	Mon Jan  1 05:46:47 2001
+++ drivers/media/radio/radio-trust.c	Mon Jan  1 05:46:51 2001
@@ -300,7 +300,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=0x???\n");
 		return -EINVAL;
 	}
-	if(request_region(io, 2, "Trust FM Radio")) {
+	if(!request_region(io, 2, "Trust FM Radio")) {
 		printk(KERN_ERR "trust: port 0x%x already in use\n", io);
 		return -EBUSY;
 	}
--- drivers/media/radio/radio-typhoon.c.stock	Mon Jan  1 05:47:07 2001
+++ drivers/media/radio/radio-typhoon.c	Mon Jan  1 05:47:15 2001
@@ -350,7 +350,7 @@
 
 	printk(KERN_INFO BANNER);
 	io = typhoon_unit.iobase;
-	if (request_region(io, 8, "typhoon")) {
+	if (!request_region(io, 8, "typhoon")) {
 		printk(KERN_ERR "radio-typhoon: port 0x%x already in use\n",
 		       typhoon_unit.iobase);
 		return -EBUSY;
--- drivers/media/radio/radio-zoltrix.c.stock	Mon Jan  1 05:47:50 2001
+++ drivers/media/radio/radio-zoltrix.c	Mon Jan  1 05:47:58 2001
@@ -361,7 +361,7 @@
 	}
 
 	zoltrix_radio.priv = &zoltrix_unit;
-	if (request_region(io, 2, "zoltrix")) {
+	if (!request_region(io, 2, "zoltrix")) {
 		printk(KERN_ERR "zoltrix: port 0x%x already in use\n", io);
 		return -EBUSY;
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
