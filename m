Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUCPWcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCPWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:32:12 -0500
Received: from colino.net ([62.212.100.143]:19438 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261766AbUCPWbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:31:47 -0500
Date: Tue, 16 Mar 2004 23:30:32 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: PPC compile fixes for 2.6.5-rc1
Message-Id: <20040316233032.63a6e26f@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__16_Mar_2004_23_30_32_+0100_wEuyNNH7vdr5ducV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__16_Mar_2004_23_30_32_+0100_wEuyNNH7vdr5ducV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I had trouble compiling 2.6.5-rc1 on ppc32. For information and
people interested in testing it, here are the changes I needed to
make it work.
No doubt these little glitches will be ironed out for 2.6.5, anyway :)

hth,
-- 
Colin

--Multipart=_Tue__16_Mar_2004_23_30_32_+0100_wEuyNNH7vdr5ducV
Content-Type: text/plain;
 name="2.6.5-rc1.diff"
Content-Disposition: attachment;
 filename="2.6.5-rc1.diff"
Content-Transfer-Encoding: 7bit

--- include/sound/pcm.h.orig	2004-03-16 23:24:29.564616688 +0100
+++ include/sound/pcm.h	2004-03-16 23:20:02.236256776 +0100
@@ -904,6 +904,8 @@
  *  Memory
  */
 
+#define snd_pcm_dma_flags(x) ((void *)(unsigned long)(x))
+
 int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream);
 int snd_pcm_lib_preallocate_free_for_all(snd_pcm_t *pcm);
 int snd_pcm_lib_preallocate_pages(snd_pcm_substream_t *substream,
--- arch/ppc/syslib/indirect_pci.c.orig	2004-03-16 23:25:49.905403032 +0100
+++ arch/ppc/syslib/indirect_pci.c	2004-03-16 13:23:20.000000000 +0100
@@ -44,8 +44,8 @@
 			cfg_type = 1;
 
 	PCI_CFG_OUT(hose->cfg_addr, 					 
-		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
-		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
 
 	/*
 	 * Note: the caller has already checked that offset is
@@ -83,8 +83,8 @@
 			cfg_type = 1;
 
 	PCI_CFG_OUT(hose->cfg_addr, 					 
-		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
-		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
 
 	/*
 	 * Note: the caller has already checked that offset is
--- include/asm-ppc/pci.h.orig	2004-03-16 23:27:41.291469776 +0100
+++ include/asm-ppc/pci.h	2004-03-16 23:27:28.587401088 +0100
@@ -10,6 +10,11 @@
 #include <asm/io.h>
 #include <asm/pci-bridge.h>
 
+#define consistent_sync_for_cpu consistent_sync
+#define consistent_sync_for_device consistent_sync
+#define consistent_sync_page_for_cpu consistent_sync_page
+#define consistent_sync_page_for_device consistent_sync_page
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */

--Multipart=_Tue__16_Mar_2004_23_30_32_+0100_wEuyNNH7vdr5ducV--
