Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269456AbUIRMl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269456AbUIRMl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 08:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUIRMl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 08:41:26 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15253 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269456AbUIRMlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 08:41:00 -0400
Date: Sat, 18 Sep 2004 14:40:49 +0200 (MEST)
Message-Id: <200409181240.i8ICenYI006568@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, dm@sangoma.com, ncorbic@sangoma.com
Subject: [PATCH][2.6.9-rc2] WANPIPE/SDLA driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.6.9-rc2
kernel's WANPIPE/SDLA net drivers. This is a forward port of the
fix I made for the 2.4 kernel.

/Mikael

--- linux-2.6.9-rc2/drivers/net/wan/sdla_fr.c.~1~	2003-09-28 12:19:47.000000000 +0200
+++ linux-2.6.9-rc2/drivers/net/wan/sdla_fr.c	2004-09-18 13:53:33.000000000 +0200
@@ -3678,7 +3678,7 @@
                                 break;
                         }
 
-			(void *)ptr_trc_el = card->u.f.curr_trc_el;
+			ptr_trc_el = (void *)card->u.f.curr_trc_el;
 
                         buffer_length = 0;
 			fr_udp_pkt->data[0x00] = 0x00;
@@ -3729,7 +3729,7 @@
                                
 				ptr_trc_el ++;
 				if((void *)ptr_trc_el > card->u.f.trc_el_last)
-					(void*)ptr_trc_el = card->u.f.trc_el_base;
+					ptr_trc_el = (void*)card->u.f.trc_el_base;
 
 				buffer_length += sizeof(fpipemon_trc_hdr_t);
                                	if(fpipemon_trc->fpipemon_trc_hdr.data_passed) {
--- linux-2.6.9-rc2/drivers/net/wan/sdladrv.c.~1~	2004-03-11 14:01:28.000000000 +0100
+++ linux-2.6.9-rc2/drivers/net/wan/sdladrv.c	2004-09-18 13:51:49.000000000 +0200
@@ -937,7 +937,7 @@
                         peek_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
                         addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (char*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -1019,7 +1019,7 @@
                         poke_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
 	                addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (char*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -2001,7 +2001,7 @@
 	(void *)hw->dpmbase = ioremap((unsigned long)S514_mem_base_addr,
 		(unsigned long)MAX_SIZEOF_S514_MEMORY);
     	/* map the physical control register memory to virtual memory */
-	(void *)hw->vector = ioremap(
+	hw->vector = (unsigned long)ioremap(
 		(unsigned long)(S514_mem_base_addr + S514_CTRL_REG_BYTE),
 		(unsigned long)16);
      
--- linux-2.6.9-rc2/drivers/net/wan/sdlamain.c.~1~	2004-03-11 14:01:28.000000000 +0100
+++ linux-2.6.9-rc2/drivers/net/wan/sdlamain.c	2004-09-18 13:52:25.000000000 +0200
@@ -976,7 +976,7 @@
 
                         dump.length     -= len;
                         dump.offset     += len;
-                        (char*)dump.ptr += len;
+                        dump.ptr         = (char*)dump.ptr + len;
                 }
 		
                 sdla_mapmem(&card->hw, oldvec);/* restore DPM window position */
