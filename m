Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132627AbRDQN7m>; Tue, 17 Apr 2001 09:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDQN7d>; Tue, 17 Apr 2001 09:59:33 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:30385 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132620AbRDQN7X>; Tue, 17 Apr 2001 09:59:23 -0400
Date: Tue, 17 Apr 2001 15:00:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] emu10k1/audio un reserve
In-Reply-To: <Pine.LNX.4.21.0103291510060.1167-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0104171457110.1062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code for mem_map_reserving has been copied a little too
faithfully to the places where it wants to mem_map_unreserve.

Hugh

--- 2.4.3-ac7/drivers/sound/emu10k1/audio.c	Tue Apr 17 14:43:09 2001
+++ linux/drivers/sound/emu10k1/audio.c	Tue Apr 17 14:46:20 2001
@@ -272,7 +272,7 @@
 
 					/* Undo marking the pages as reserved */
 					for (i = 0; i < woinst->buffer.pages; i++)
-						mem_map_reserve(virt_to_page(woinst->buffer.addr[i]));
+						mem_map_unreserve(virt_to_page(woinst->buffer.addr[i]));
 				}
 
 				emu10k1_waveout_close(wave_dev);
@@ -322,7 +322,7 @@
 
 					/* Undo marking the pages as reserved */
 					for (i = 0; i < woinst->buffer.pages; i++)
-						mem_map_reserve(virt_to_page(woinst->buffer.addr[i]));
+						mem_map_unreserve(virt_to_page(woinst->buffer.addr[i]));
 				}
 
 				emu10k1_waveout_close(wave_dev);
@@ -1204,7 +1204,7 @@
 
 				/* Undo marking the pages as reserved */
 				for (i = 0; i < woinst->buffer.pages; i++)
-					mem_map_reserve(virt_to_page(woinst->buffer.addr[i]));
+					mem_map_unreserve(virt_to_page(woinst->buffer.addr[i]));
 			}
 
 			emu10k1_waveout_close(wave_dev);

