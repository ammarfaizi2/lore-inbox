Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTEKEMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 00:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTEKEMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 00:12:18 -0400
Received: from smtp1.wanadoo.es ([62.37.236.135]:49363 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S262442AbTEKEMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 00:12:16 -0400
Message-ID: <3EBDD09F.6050101@wanadoo.es>
Date: Sun, 11 May 2003 06:25:03 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: marcelo <marcelo@conectiva.com.br>
Subject: Re: [PATCH] avoid two sym53c8xx names
References: <3EBDAEE9.3080608@wanadoo.es>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xose Vazquez Perez wrote:
> hi,
>
> To avoid that it has two modules with same name:
>
> patch for 2.4.21-rc2:
> --cut--
> diff -Nuar linux/drivers/scsi/Makefile linux.xose/drivers/scsi/Makefile
> --- linux/drivers/scsi/Makefile 2003-05-11 02:53:40.000000000 +0200
> +++ linux.xose/drivers/scsi/Makefile    2003-05-11 03:52:41.000000000 +0200
> @@ -97,7 +97,7 @@
>  obj-$(CONFIG_SCSI_NCR53C7xx)   += 53c7,8xx.o
>  subdir-$(CONFIG_SCSI_SYM53C8XX_2)      += sym53c8xx_2
>  ifeq ($(CONFIG_SCSI_SYM53C8XX_2),y)
> -  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx.o
> +  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx_2.o
>  endif
>  obj-$(CONFIG_SCSI_SYM53C8XX)   += sym53c8xx.o
>  obj-$(CONFIG_SCSI_NCR53C8XX)   += ncr53c8xx.o

regards,

I am sorry, I forgot the other makefile

--cut--
diff -Nuar linux/drivers/scsi/Makefile linux.xose/drivers/scsi/Makefile
--- linux/drivers/scsi/Makefile 2003-05-11 02:53:40.000000000 +0200
+++ linux.xose/drivers/scsi/Makefile    2003-05-11 03:52:41.000000000 +0200
@@ -97,7 +97,7 @@
 obj-$(CONFIG_SCSI_NCR53C7xx)   += 53c7,8xx.o
 subdir-$(CONFIG_SCSI_SYM53C8XX_2)      += sym53c8xx_2
 ifeq ($(CONFIG_SCSI_SYM53C8XX_2),y)
-  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx.o
+  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx_2.o
 endif
 obj-$(CONFIG_SCSI_SYM53C8XX)   += sym53c8xx.o
 obj-$(CONFIG_SCSI_NCR53C8XX)   += ncr53c8xx.o
diff -Nuar linux/drivers/scsi/sym53c8xx_2/Makefile linux.xose/drivers/scsi/sym53c8xx_2/Makefile
--- linux/drivers/scsi/sym53c8xx_2/Makefile     2001-11-10 00:22:54.000000000 +0100
+++ linux.xose/drivers/scsi/sym53c8xx_2/Makefile        2003-05-11 06:10:04.000000000 +0200
@@ -1,14 +1,14 @@
 # File: drivers/sym53c8xx/Makefile
 # Makefile for the NCR/SYMBIOS/LSI 53C8XX PCI SCSI controllers driver.

-list-multi := sym53c8xx.o
-sym53c8xx-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
-obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx.o
+list-multi := sym53c8xx_2.o
+sym53c8xx_2-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
+obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx_2.o

 EXTRA_CFLAGS += -I.

-sym53c8xx.o: $(sym53c8xx-objs)
-       $(LD) -r -o $@ $(sym53c8xx-objs)
+sym53c8xx_2.o: $(sym53c8xx_2-objs)
+       $(LD) -r -o $@ $(sym53c8xx_2-objs)

 include $(TOPDIR)/Rules.make
--end--

-- 
Galiza nin perdoa nin esquence. Governo demision!


