Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbTCTPtQ>; Thu, 20 Mar 2003 10:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCTPtP>; Thu, 20 Mar 2003 10:49:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59896 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261483AbTCTPtO>; Thu, 20 Mar 2003 10:49:14 -0500
Date: Thu, 20 Mar 2003 17:00:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg Ungerer <gerg@snapgear.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.5.56: undefined reference to `_ebss' from drivers/mtd/maps/uclinux.c
Message-ID: <20030320160008.GB3174@fs.tum.de>
References: <20030112095559.GT21826@fs.tum.de> <3E226969.5080406@snapgear.com> <20030320145927.GF11659@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320145927.GF11659@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:59:28PM +0100, Adrian Bunk wrote:
>...
> It might not be a solution for the whole issue, but is it intentionally
> that it's possible to enable CONFIG_MTD_UCLINUX on non-uClinux 
> architectures or should an appropriate dependency be added to the 
> Kconfig file?

The following patch should do what I was thinking of:

--- linux-2.5.65-full/drivers/mtd/maps/Kconfig.old	2003-03-20 16:56:25.000000000 +0100
+++ linux-2.5.65-full/drivers/mtd/maps/Kconfig	2003-03-20 16:56:45.000000000 +0100
@@ -348,7 +348,7 @@
 
 config MTD_UCLINUX
 	tristate "Generic uClinux RAM/ROM filesystem support"
-	depends on MTD_PARTITIONS
+	depends on MTD_PARTITIONS && !MMU
 	help
 	  Map driver to support image based filesystems for uClinux.
 


Any comments on whether this is correct?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

