Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVEFJtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVEFJtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEFJtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 05:49:01 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:49372 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261198AbVEFJsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 05:48:40 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] drivers/block/rd.c: don't make a variable static
Date: Fri, 6 May 2005 19:48:31 +1000
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
References: <20050502014719.GE3592@stusta.de>
In-Reply-To: <20050502014719.GE3592@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505061948.31332.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 11:47, Adrian Bunk wrote:
> This patch makes a needlessly global variable static.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.12-rc2-mm2-full/drivers/block/rd.c.old	2005-04-10
> 02:00:08.000000000 +0200 +++
> linux-2.6.12-rc2-mm2-full/drivers/block/rd.c	2005-04-10 02:01:00.000000000
> +0200 @@ -74,7 +74,7 @@
>   * architecture-specific setup routine (from the stored boot sector
>   * information).
>   */
> -int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
> +static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;	/* Size of the RAM disks */
>  /*
>   * It would be very desirable to have a soft-blocksize (that in the case
>   * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because


This patch breaks PPC iSeries in arch/ppc64/kernel/iSeries_setup.c


--- veth-fixes/drivers/block/rd.c	2005-05-06 19:26:53.000000000 +1000
+++ 2.6.12-rc3/drivers/block/rd.c	2005-04-29 15:14:23.000000000 +1000
@@ -74,7 +74,7 @@
  * architecture-specific setup routine (from the stored boot sector
  * information).
  */
-static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;	/* Size of the RAM disks */
+int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
 /*
  * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
