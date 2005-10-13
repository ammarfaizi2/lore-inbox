Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbVJMTXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbVJMTXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbVJMTXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:23:21 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:33648 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751630AbVJMTXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:23:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=ZHduQAKYW3bNBsffH1Ilpr5ZcyKTUYdxNVQQpHN3MKcnPFc4OVQj39j3Tidhi+7PLcAUkH6puXTygRe7nCcXGCTf5jfdnb3SRk4oMN4vZs2w+0FfHUbTMwjQgPghOtVhTwmORwo8yMmEgjVSWBLS67+imAe3NzofWBmdp+LsqZk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/14] Big kfree NULL check cleanup - drivers/mtd
Date: Thu, 13 Oct 2005 21:26:12 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-mtd@lists.infradead.org, Nicolas Pitre <nico@cam.org>,
       source@mvista.com, Simon Evans <spse@secret.org.uk>,
       Greg Ungerer <gerg@snapgear.com>, Ben Dooks <ben@simtec.co.uk>,
       jamey.hicks@hp.com, Deepak Saxena <dsaxena@plexity.net>, jzhang@ti.com,
       Eric Brower <ebrower@usa.net>, Kirk Lee <kirk@hpc.ee.ntu.edu.tw>,
       "Steven J. Hill" <sjhill@realitydiluted.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132126.13411.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/mtd part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/mtd/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/mtd/chips/cfi_cmdset_0001.c |    3 +--
 drivers/mtd/chips/cfi_cmdset_0002.c |    4 ++--
 drivers/mtd/devices/blkmtd.c        |    7 ++-----
 drivers/mtd/inftlcore.c             |   12 ++++--------
 drivers/mtd/maps/amd76xrom.c        |    4 +---
 drivers/mtd/maps/bast-flash.c       |    3 +--
 drivers/mtd/maps/ceiva.c            |    3 +--
 drivers/mtd/maps/ichxrom.c          |    5 ++---
 drivers/mtd/maps/integrator-flash.c |    6 ++----
 drivers/mtd/maps/ipaq-flash.c       |    3 +--
 drivers/mtd/maps/iq80310.c          |    3 +--
 drivers/mtd/maps/ixp2000.c          |    3 +--
 drivers/mtd/maps/ixp4xx.c           |    3 +--
 drivers/mtd/maps/lubbock-flash.c    |    3 +--
 drivers/mtd/maps/omap-toto-flash.c  |    3 +--
 drivers/mtd/maps/sa1100-flash.c     |    3 +--
 drivers/mtd/maps/sun_uflash.c       |    4 +---
 drivers/mtd/maps/tqm8xxl.c          |    6 ++----
 drivers/mtd/nand/nand_base.c        |    5 ++---
 drivers/mtd/nftlcore.c              |   12 ++++--------
 20 files changed, 32 insertions(+), 63 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/mtd/maps/omap-toto-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/omap-toto-flash.c	2005-10-12 16:17:34.000000000 +0200
@@ -124,8 +124,7 @@ static void  __exit omap_toto_mtd_cleanu
 	if (flash_mtd) {
 		del_mtd_partitions(flash_mtd);
 		map_destroy(flash_mtd);
-		if (parsed_parts)
-			kfree(parsed_parts);
+		kfree(parsed_parts);
 	}
 }
 
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/ipaq-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/ipaq-flash.c	2005-10-12 16:17:48.000000000 +0200
@@ -431,8 +431,7 @@ static void __exit ipaq_mtd_cleanup(void
 				if (my_sub_mtd[i])
 					map_destroy(my_sub_mtd[i]);
 			}
-		if (parsed_parts)
-			kfree(parsed_parts);
+		kfree(parsed_parts);
 	}
 }
 
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/sa1100-flash.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/sa1100-flash.c	2005-10-12 16:17:58.000000000 +0200
@@ -235,8 +235,7 @@ static void sa1100_destroy(struct sa_inf
 #endif
 	}
 
-	if (info->parts)
-		kfree(info->parts);
+	kfree(info->parts);
 
 	for (i = info->num_subdev - 1; i >= 0; i--)
 		sa1100_destroy_subdev(&info->subdev[i]);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/iq80310.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/iq80310.c	2005-10-12 16:18:05.000000000 +0200
@@ -103,8 +103,7 @@ static void __exit cleanup_iq80310(void)
 	if (mymtd) {
 		del_mtd_partitions(mymtd);
 		map_destroy(mymtd);
-		if (parsed_parts)
-			kfree(parsed_parts);
+		kfree(parsed_parts);
 	}
 	if (iq80310_map.virt)
 		iounmap((void *)iq80310_map.virt);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/ixp4xx.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/ixp4xx.c	2005-10-12 16:18:23.000000000 +0200
@@ -120,8 +120,7 @@ static int ixp4xx_flash_remove(struct de
 	if (info->map.map_priv_1)
 		iounmap((void *) info->map.map_priv_1);
 
-	if (info->partitions)
-		kfree(info->partitions);
+	kfree(info->partitions);
 
 	if (info->res) {
 		release_resource(info->res);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/amd76xrom.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/amd76xrom.c	2005-10-12 16:18:41.000000000 +0200
@@ -259,9 +259,7 @@ static int __devinit amd76xrom_init_one 
 
  out:
 	/* Free any left over map structures */
-	if (map) {
-		kfree(map);
-	}
+	kfree(map);
 	/* See if I have any map structures */
 	if (list_empty(&window->maps)) {
 		amd76xrom_cleanup(window);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/tqm8xxl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/tqm8xxl.c	2005-10-12 16:19:17.000000000 +0200
@@ -222,10 +222,8 @@ int __init init_tqm_mtd(void)
 error_mem:
 	for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
 		if(map_banks[idx] != NULL) {
-			if(map_banks[idx]->name != NULL) {
-				kfree(map_banks[idx]->name);
-				map_banks[idx]->name = NULL;
-			}
+			kfree(map_banks[idx]->name);
+			map_banks[idx]->name = NULL;
 			kfree(map_banks[idx]);
 			map_banks[idx] = NULL;
 		}
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/integrator-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/integrator-flash.c	2005-10-12 16:19:37.000000000 +0200
@@ -148,8 +148,7 @@ static int armflash_probe(struct device 
 			del_mtd_partitions(info->mtd);
 			map_destroy(info->mtd);
 		}
-		if (info->parts)
-			kfree(info->parts);
+		kfree(info->parts);
 
  no_device:
 		iounmap(base);
@@ -176,8 +175,7 @@ static int armflash_remove(struct device
 			del_mtd_partitions(info->mtd);
 			map_destroy(info->mtd);
 		}
-		if (info->parts)
-			kfree(info->parts);
+		kfree(info->parts);
 
 		iounmap(info->map.virt);
 		release_resource(info->res);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/ixp2000.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/ixp2000.c	2005-10-12 16:20:13.000000000 +0200
@@ -126,8 +126,7 @@ static int ixp2000_flash_remove(struct d
 	if (info->map.map_priv_1)
 		iounmap((void *) info->map.map_priv_1);
 
-	if (info->partitions) {
-		kfree(info->partitions); }
+	kfree(info->partitions);
 
 	if (info->res) {
 		release_resource(info->res);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/lubbock-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/lubbock-flash.c	2005-10-12 16:20:20.000000000 +0200
@@ -155,8 +155,7 @@ static void __exit cleanup_lubbock(void)
 		if (lubbock_maps[i].cached)
 			iounmap(lubbock_maps[i].cached);
 
-		if (parsed_parts[i])
-			kfree(parsed_parts[i]);
+		kfree(parsed_parts[i]);
 	}
 }
 
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/bast-flash.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/bast-flash.c	2005-10-12 16:20:29.000000000 +0200
@@ -103,8 +103,7 @@ static int bast_flash_remove(struct devi
 		map_destroy(info->mtd);
 	}
 
-	if (info->partitions)
-		kfree(info->partitions);
+	kfree(info->partitions);
 
 	if (info->area) {
 		release_resource(info->area);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/sun_uflash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/sun_uflash.c	2005-10-12 16:20:56.000000000 +0200
@@ -166,9 +166,7 @@ static void __exit uflash_cleanup(void)
 			iounmap(udev->map.virt);
 			udev->map.virt = NULL;
 		}
-		if(0 != udev->name) {
-			kfree(udev->name);
-		}
+		kfree(udev->name);
 		kfree(udev);
 	}	
 }
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/ichxrom.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/ichxrom.c	2005-10-12 16:21:20.000000000 +0200
@@ -306,9 +306,8 @@ static int __devinit ichxrom_init_one (s
 
  out:
 	/* Free any left over map structures */
-	if (map) {
-		kfree(map);
-	}
+	kfree(map);
+
 	/* See if I have any map structures */
 	if (list_empty(&window->maps)) {
 		ichxrom_cleanup(window);
--- linux-2.6.14-rc4-orig/drivers/mtd/maps/ceiva.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/maps/ceiva.c	2005-10-12 16:21:37.000000000 +0200
@@ -312,8 +312,7 @@ static void __init clps_locate_partition
 
 static void __exit clps_destroy_partitions(void)
 {
-	if (parsed_parts)
-		kfree(parsed_parts);
+	kfree(parsed_parts);
 }
 
 static struct mtd_info *mymtd;
--- linux-2.6.14-rc4-orig/drivers/mtd/nand/nand_base.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/nand/nand_base.c	2005-10-12 16:22:12.000000000 +0200
@@ -2676,9 +2676,8 @@ void nand_release (struct mtd_info *mtd)
 	/* Deregister the device */
 	del_mtd_device (mtd);
 
-	/* Free bad block table memory, if allocated */
-	if (this->bbt)
-		kfree (this->bbt);
+	/* Free bad block table memory */
+	kfree (this->bbt);
 	/* Buffer allocated by nand_scan ? */
 	if (this->options & NAND_OOBBUF_ALLOC)
 		kfree (this->oob_buf);
--- linux-2.6.14-rc4-orig/drivers/mtd/devices/blkmtd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/devices/blkmtd.c	2005-10-12 16:22:46.000000000 +0200
@@ -539,11 +539,8 @@ static void free_device(struct blkmtd_de
 {
 	DEBUG(2, "blkmtd: free_device() dev = %p\n", dev);
 	if(dev) {
-		if(dev->mtd_info.eraseregions)
-			kfree(dev->mtd_info.eraseregions);
-		if(dev->mtd_info.name)
-			kfree(dev->mtd_info.name);
-
+		kfree(dev->mtd_info.eraseregions);
+		kfree(dev->mtd_info.name);
 		if(dev->blkdev) {
 			invalidate_inode_pages(dev->blkdev->bd_inode->i_mapping);
 			close_bdev_excl(dev->blkdev);
--- linux-2.6.14-rc4-orig/drivers/mtd/inftlcore.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/inftlcore.c	2005-10-12 16:23:13.000000000 +0200
@@ -126,10 +126,8 @@ static void inftl_add_mtd(struct mtd_blk
 	}
 
 	if (add_mtd_blktrans_dev(&inftl->mbd)) {
-		if (inftl->PUtable)
-			kfree(inftl->PUtable);
-		if (inftl->VUtable)
-			kfree(inftl->VUtable);
+		kfree(inftl->PUtable);
+		kfree(inftl->VUtable);
 		kfree(inftl);
 		return;
 	}
@@ -147,10 +145,8 @@ static void inftl_remove_dev(struct mtd_
 
 	del_mtd_blktrans_dev(dev);
 
-	if (inftl->PUtable)
-		kfree(inftl->PUtable);
-	if (inftl->VUtable)
-		kfree(inftl->VUtable);
+	kfree(inftl->PUtable);
+	kfree(inftl->VUtable);
 	kfree(inftl);
 }
 
--- linux-2.6.14-rc4-orig/drivers/mtd/chips/cfi_cmdset_0001.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/chips/cfi_cmdset_0001.c	2005-10-12 16:23:58.000000000 +0200
@@ -455,8 +455,7 @@ static struct mtd_info *cfi_intelext_set
 
  setup_err:
 	if(mtd) {
-		if(mtd->eraseregions)
-			kfree(mtd->eraseregions);
+		kfree(mtd->eraseregions);
 		kfree(mtd);
 	}
 	kfree(cfi->cmdset_priv);
--- linux-2.6.14-rc4-orig/drivers/mtd/chips/cfi_cmdset_0002.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/chips/cfi_cmdset_0002.c	2005-10-12 16:24:25.000000000 +0200
@@ -378,8 +378,7 @@ static struct mtd_info *cfi_amdstd_setup
 
  setup_err:
 	if(mtd) {
-		if(mtd->eraseregions)
-			kfree(mtd->eraseregions);
+		kfree(mtd->eraseregions);
 		kfree(mtd);
 	}
 	kfree(cfi->cmdset_priv);
@@ -1742,6 +1741,7 @@ static void cfi_amdstd_destroy(struct mt
 {
 	struct map_info *map = mtd->priv;
 	struct cfi_private *cfi = map->fldrv_priv;
+
 	kfree(cfi->cmdset_priv);
 	kfree(cfi->cfiq);
 	kfree(cfi);
--- linux-2.6.14-rc4-orig/drivers/mtd/nftlcore.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mtd/nftlcore.c	2005-10-12 16:24:52.000000000 +0200
@@ -114,10 +114,8 @@ static void nftl_add_mtd(struct mtd_blkt
 	}
 
 	if (add_mtd_blktrans_dev(&nftl->mbd)) {
-		if (nftl->ReplUnitTable)
-			kfree(nftl->ReplUnitTable);
-		if (nftl->EUNtable)
-			kfree(nftl->EUNtable);
+		kfree(nftl->ReplUnitTable);
+		kfree(nftl->EUNtable);
 		kfree(nftl);
 		return;
 	}
@@ -133,10 +131,8 @@ static void nftl_remove_dev(struct mtd_b
 	DEBUG(MTD_DEBUG_LEVEL1, "NFTL: remove_dev (i=%d)\n", dev->devnum);
 
 	del_mtd_blktrans_dev(dev);
-	if (nftl->ReplUnitTable)
-		kfree(nftl->ReplUnitTable);
-	if (nftl->EUNtable)
-		kfree(nftl->EUNtable);
+	kfree(nftl->ReplUnitTable);
+	kfree(nftl->EUNtable);
 	kfree(nftl);
 }
 


