Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268694AbUILLc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268694AbUILLc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUILLbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:31:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51452 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268694AbUILL2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:28:05 -0400
Date: Sun, 12 Sep 2004 13:27:53 +0200 (MEST)
Message-Id: <200409121127.i8CBRraH015212@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dm@sangoma.com, marcelo.tosatti@cyclades.com, ncorbic@sangoma.com
Subject: [PATCH][2.4.28-pre3] WANPIPE/SDLA driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's WANPIPE/SDLA net drivers. The 2.6 version of the code has
not been fixed for gcc-3.4, so the changes are all new.

/Mikael

--- linux-2.4.28-pre3/drivers/net/wan/sdla_fr.c.~1~	2003-11-29 00:28:12.000000000 +0100
+++ linux-2.4.28-pre3/drivers/net/wan/sdla_fr.c	2004-09-12 01:56:20.000000000 +0200
@@ -3929,7 +3929,7 @@
                                 break;
                         }
 
-			(void *)ptr_trc_el = card->u.f.curr_trc_el;
+			ptr_trc_el = (void *)card->u.f.curr_trc_el;
 
                         buffer_length = 0;
 			fr_udp_pkt->data[0x00] = 0x00;
@@ -3980,7 +3980,7 @@
                                
 				ptr_trc_el ++;
 				if((void *)ptr_trc_el > card->u.f.trc_el_last)
-					(void*)ptr_trc_el = card->u.f.trc_el_base;
+					ptr_trc_el = (void*)card->u.f.trc_el_base;
 
 				buffer_length += sizeof(fpipemon_trc_hdr_t);
                                	if(fpipemon_trc->fpipemon_trc_hdr.data_passed) {
--- linux-2.4.28-pre3/drivers/net/wan/sdladrv.c.~1~	2001-09-23 21:06:34.000000000 +0200
+++ linux-2.4.28-pre3/drivers/net/wan/sdladrv.c	2004-09-12 01:56:20.000000000 +0200
@@ -1002,7 +1002,7 @@
                         peek_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
                         addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (char*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -1086,7 +1086,7 @@
                         poke_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
 	                addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (char*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -2130,7 +2130,7 @@
 	(void *)hw->dpmbase = ioremap((unsigned long)S514_mem_base_addr,
 		(unsigned long)MAX_SIZEOF_S514_MEMORY);
     	/* map the physical control register memory to virtual memory */
-	(void *)hw->vector = ioremap(
+	hw->vector = (unsigned long)ioremap(
 		(unsigned long)(S514_mem_base_addr + S514_CTRL_REG_BYTE),
 		(unsigned long)16);
      
--- linux-2.4.28-pre3/drivers/net/wan/sdlamain.c.~1~	2003-11-29 00:28:12.000000000 +0100
+++ linux-2.4.28-pre3/drivers/net/wan/sdlamain.c	2004-09-12 01:56:20.000000000 +0200
@@ -1027,7 +1027,7 @@
                       #endif
                         dump.length     -= len;
                         dump.offset     += len;
-                        (char*)dump.ptr += len;
+                        dump.ptr         = (char*)dump.ptr + len;
                 }
 		
                 sdla_mapmem(&card->hw, oldvec);/* restore DPM window position */
