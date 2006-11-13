Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754798AbWKMOuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbWKMOuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbWKMOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:50:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40583 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754813AbWKMOuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:50:00 -0500
Message-ID: <4558860B.8090908@garzik.org>
Date: Mon, 13 Nov 2006 09:49:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
CC: paulkf@microgate.com, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>
In-Reply-To: <200611130943.42463.toralf.foerster@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------080607090403010808080100"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607090403010808080100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Toralf Förster wrote:
> Hello,
> 
> the build with the attached .config failed, make ends with:
> ... 
> UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `hdlcdev_open':
> synclink.c:(.text+0x650d5): undefined reference to `hdlc_open'
> synclink.c:(.text+0x6510d): undefined reference to `hdlc_open'
> ...
> synclink_cs.c:(.text+0x7aece): undefined reference to `hdlc_ioctl'
> drivers/built-in.o: In function `hdlcdev_init':
> synclink_cs.c:(.text+0x7b336): undefined reference to `alloc_hdlcdev'
> drivers/built-in.o: In function `hdlcdev_exit':
> synclink_cs.c:(.text+0x7b434): undefined reference to `unregister_hdlc_device'
> make: *** [.tmp_vmlinux1] Error 1

Does this patch work for you?

	Jeff



--------------080607090403010808080100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 39a9f8c..5ac61e1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -213,7 +213,7 @@ config ISI
 
 config SYNCLINK
 	tristate "Microgate SyncLink card support"
-	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API && HDLC
 	help
 	  Provides support for the SyncLink ISA and PCI multiprotocol serial
 	  adapters. These adapters support asynchronous and HDLC bit
@@ -226,7 +226,7 @@ config SYNCLINK
 
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && HDLC
 	help
 	  Enable support for the SyncLink Multiport (2 or 4 ports)
 	  serial adapter, running asynchronous and HDLC communications up
diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
index 27c1179..2b852bf 100644
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -7,7 +7,7 @@ menu "PCMCIA character devices"
 
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
-	depends on PCMCIA
+	depends on PCMCIA && HDLC
 	help
 	  Enable support for the SyncLink PC Card serial adapter, running
 	  asynchronous and HDLC communications up to 512Kbps. The port is

--------------080607090403010808080100--
