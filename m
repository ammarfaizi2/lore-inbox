Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUHITJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUHITJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUHITJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:09:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17384 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266898AbUHITE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:04:57 -0400
Date: Mon, 9 Aug 2004 21:04:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix CCISS with PROC_FS=n
Message-ID: <20040809190447.GU26174@fs.tum.de>
References: <20040809153446.GS26174@fs.tum.de> <20040809160743.GB4770@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809160743.GB4770@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 11:07:43AM -0500, mikem wrote:
>...
> > -#ifdef CONFIG_PROC_FS
> >  
> >  #include "cciss_scsi.c"		/* For SCSI tape support */
> 
> We use /proc to hook into the SCSI subsystem. If you do not build /proc support
> into your kernel then you should also disable tape support in the driver. 
>...


Thanks for this informaition. Better patch below.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/drivers/block/Kconfig.old	2004-08-09 20:57:36.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/drivers/block/Kconfig	2004-08-09 20:57:56.000000000 +0200
@@ -166,7 +166,7 @@
 
 config CISS_SCSI_TAPE
 	bool "SCSI tape drive support for Smart Array 5xxx"
-	depends on BLK_CPQ_CISS_DA && SCSI
+	depends on BLK_CPQ_CISS_DA && SCSI && PROC_FS
 	help
 	  When enabled (Y), this option allows SCSI tape drives and SCSI medium
 	  changers (tape robots) to be accessed via a Compaq 5xxx array 

