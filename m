Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWAEOSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWAEOSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAEOSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:18:43 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:52050 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbWAEOSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:18:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rSs1jS/YA4IJ7saeVGRVRQg72kM4m6aP87b7d0DZwIT9jI0uPmDavKqmnHyEePDwB2hpaQAJGGSYWoUskK8N3Bz7J8V7m8JJPOeudG0FWmhi0WkdpA4wmQHuMipGiGtax4YDdGPKVKDrdZ2s8QKvDsiPfFam7VUbT/ARQkhcAOA=
Subject: Re: [PATCH] PXA2xx: build PCMCIA as a module
From: Florin Malita <fmalita@gmail.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1136419973.2768.7.camel@zed.malinux.net>
References: <1136409389.14442.20.camel@scox.glenatl.glenayre.com>
	 <1136413220.9902.94.camel@localhost.localdomain>
	 <1136419973.2768.7.camel@zed.malinux.net>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 09:17:51 -0500
Message-Id: <1136470671.14442.26.camel@scox.glenatl.glenayre.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2006-01-04 at 22:20 +0000, Richard Purdie wrote:
> > NAK. This breaks poodle, tosa and collie who also use scoop and this
> > pcmcia driver. I'd suggest moving scoop_pcmcia_config to
> > arch/arm/common/scoop.c instead.

Here's a version with the modified comment following your suggestion.

Thanks,
Florin

Signed-off-by: Florin Malita <fmalita@gmail.com>
--
diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -19,6 +19,16 @@
 
 #define SCOOP_REG(d,adr) (*(volatile unsigned short*)(d +(adr)))
 
+/* PCMCIA to Scoop linkage
+
+   There is no easy way to link multiple scoop devices into one
+   single entity for the pxa2xx_pcmcia device so this structure
+   is used which is setup by the platform code and used by the
+   pcmcia driver.
+*/
+struct scoop_pcmcia_config *platform_scoop_config;
+EXPORT_SYMBOL(platform_scoop_config);
+
 struct  scoop_dev {
 	void  *base;
 	spinlock_t scoop_lock;
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -27,13 +27,6 @@
 
 #define	NO_KEEP_VS 0x0001
 
-/* PCMCIA to Scoop linkage
-
-   There is no easy way to link multiple scoop devices into one
-   single entity for the pxa2xx_pcmcia device so this structure
-   is used which is setup by the platform code
-*/
-struct scoop_pcmcia_config *platform_scoop_config;
 #define SCOOP_DEV platform_scoop_config->devs
 
 static void sharpsl_pcmcia_init_reset(struct scoop_pcmcia_dev *scoopdev)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -846,3 +846,4 @@ int soc_common_drv_pcmcia_remove(struct 
 
 	return 0;
 }
+EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);


