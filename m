Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTE1H5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTE1H5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:57:10 -0400
Received: from hydra1.fw.med.uni-muenchen.de ([138.245.10.1]:21872 "EHLO
	OITZ2N.helios.med.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S264555AbTE1H5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:57:08 -0400
Date: Wed, 28 May 2003 10:10:20 +0200
From: Olaf Dietrich <odt@dtrx.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc5
Message-ID: <20030528081020.GE626@gracvn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-OriginalArrivalTime: 28 May 2003 08:10:21.0458 (UTC) FILETIME=[9572B720:01C324F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached are two tiny type-related fixes for
2.4.21-rc5 to avoid compiler warnings.

Olaf

--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="type-fix.diff"

diff -Nur linux-2.4.21-rc5/drivers/char/agp/agpgart_be.c linux-2.4.21-rc5.n/drivers/char/agp/agpgart_be.c
--- linux-2.4.21-rc5/drivers/char/agp/agpgart_be.c	Wed May 28 08:54:24 2003
+++ linux-2.4.21-rc5.n/drivers/char/agp/agpgart_be.c	Wed May 28 09:32:54 2003
@@ -577,7 +577,7 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		SetPageReserved(page);
 
-	agp_bridge.gatt_table_real = (unsigned long *) table;
+	agp_bridge.gatt_table_real = (u32 *) table;
 	agp_gatt_table = (void *)table;
 #ifdef CONFIG_X86
 	err = change_page_attr(virt_to_page(table), 1<<page_order, PAGE_KERNEL_NOCACHE);
diff -Nur linux-2.4.21-rc5/fs/ext2/balloc.c linux-2.4.21-rc5.n/fs/ext2/balloc.c
--- linux-2.4.21-rc5/fs/ext2/balloc.c	Wed May 28 08:54:37 2003
+++ linux-2.4.21-rc5.n/fs/ext2/balloc.c	Wed May 28 09:18:36 2003
@@ -520,7 +520,7 @@
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
 		      EXT2_SB(sb)->s_itb_per_group)) {
 		ext2_error (sb, "ext2_new_block",
-			    "Allocating block in system zone - block = %lu",
+			    "Allocating block in system zone - block = %u",
 			    tmp);
 		ext2_set_bit(j, bh->b_data);
 		DQUOT_FREE_BLOCK(inode, 1);

--TKYYegg/GYAC5JIZ--
