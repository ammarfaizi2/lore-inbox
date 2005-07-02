Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVGBVoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVGBVoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVGBVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:44:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261292AbVGBVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:43:53 -0400
Date: Sat, 2 Jul 2005 23:43:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Zoltan Boszormenyi <zboszor@freemail.hu>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] SCSI_SATA has to be a tristate
Message-ID: <20050702214351.GB5346@stusta.de>
References: <42C6C5CE.50203@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C6C5CE.50203@freemail.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 06:50:22PM +0200, Zoltan Boszormenyi wrote:

> Hi!

Hi Zoltan!

> I got this, the tree is freshly untarred and patched:
> 
>   BUILD   arch/x86_64/boot/bzImage
> Root device is (3, 10)
> Boot sector 512 bytes.
> Setup is 7249 bytes.
> System is 1586 kB
> Kernel: arch/x86_64/boot/bzImage is ready
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "is_broadcast_ether_addr" [net/ieee80211/ieee80211.ko] 
> undefined!

Known bug, fix was already posted.

> *** Warning: "ata_device_add" [drivers/scsi/sata_vsc.ko] undefined!
>...
> .config is attached.

Thanks for this report, the fix is below.

> Best regards,
> Zoltán Böszörményi

cu
Adrian


<--  snip  -->


SCSI=m must disallow static drivers.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
@@ -447,7 +447,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
