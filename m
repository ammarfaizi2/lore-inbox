Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTAGM6O>; Tue, 7 Jan 2003 07:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTAGM6O>; Tue, 7 Jan 2003 07:58:14 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:55761 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267372AbTAGM6L>; Tue, 7 Jan 2003 07:58:11 -0500
Date: Tue, 7 Jan 2003 15:06:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: fix "assignment from incopatible pointer type" in amd-k7-agp.c
Message-ID: <20030107130639.GH25540@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agp_bridge.gatt_table and agp_bridge.gatt_table_real are both
u32*. Cast unsignments to them from unsigned long*'s to u32*'s. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.973   -> 1.974  
#	drivers/char/agp/amd-k7-agp.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	mulix@alhambra.mulix.org	1.974
# fix "assignment from incompatible pointer type". 
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
--- a/drivers/char/agp/amd-k7-agp.c	Tue Jan  7 14:16:34 2003
+++ b/drivers/char/agp/amd-k7-agp.c	Tue Jan  7 14:16:34 2003
@@ -138,8 +138,8 @@
 		return retval;
 	}
 
-	agp_bridge.gatt_table_real = (unsigned long *)page_dir.real;
-	agp_bridge.gatt_table = (unsigned long *)page_dir.remapped;
+	agp_bridge.gatt_table_real = (u32 *)page_dir.real;
+	agp_bridge.gatt_table = (u32 *)page_dir.remapped;
 	agp_bridge.gatt_bus_addr = virt_to_phys(page_dir.real);
 
 	/* Get the address for the gart region.

-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

