Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUDAJnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUDAJnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:43:24 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:34989 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262356AbUDAJnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:43:19 -0500
Date: Thu, 1 Apr 2004 11:43:56 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA aureal driver
Message-ID: <Pine.LNX.4.58.0404011142300.1843@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

Additional notes:

  - compilation fix

The pull command will update the following files:

 include/linux/pci_ids.h   |    1 +
 sound/pci/au88x0/au8820.c |    2 +-
 sound/pci/au88x0/au8830.c |    2 +-
 sound/pci/au88x0/au88x0.h |    4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/04/01 1.1735)
   Fixed ALSA aureal driver compilation - wrong and missing PCI IDs


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1734  -> 1.1735 
#	sound/pci/au88x0/au8830.c	1.1     -> 1.2    
#	include/linux/pci_ids.h	1.143   -> 1.144  
#	sound/pci/au88x0/au88x0.h	1.3     -> 1.4    
#	sound/pci/au88x0/au8820.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/01	perex@suse.cz	1.1735
# Fixed ALSA aureal driver compilation - wrong and missing PCI IDs
# --------------------------------------------
#
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Thu Apr  1 11:34:56 2004
+++ b/include/linux/pci_ids.h	Thu Apr  1 11:34:56 2004
@@ -1636,6 +1636,7 @@
 #define PCI_VENDOR_ID_AUREAL		0x12eb
 #define PCI_DEVICE_ID_AUREAL_VORTEX_1	0x0001
 #define PCI_DEVICE_ID_AUREAL_VORTEX_2	0x0002
+#define PCI_DEVICE_ID_AUREAL_ADVANTAGE	0x0003
 
 #define PCI_VENDOR_ID_ELECTRONICDESIGNGMBH 0x12f8
 #define PCI_DEVICE_ID_LML_33R10		0x8a02
diff -Nru a/sound/pci/au88x0/au8820.c b/sound/pci/au88x0/au8820.c
--- a/sound/pci/au88x0/au8820.c	Thu Apr  1 11:34:56 2004
+++ b/sound/pci/au88x0/au8820.c	Thu Apr  1 11:34:56 2004
@@ -1,7 +1,7 @@
 #include "au8820.h"
 #include "au88x0.h"
 static struct pci_device_id snd_vortex_ids[] = {
-	{PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX,
+	{PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX_1,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
 	{0,}
 };
diff -Nru a/sound/pci/au88x0/au8830.c b/sound/pci/au88x0/au8830.c
--- a/sound/pci/au88x0/au8830.c	Thu Apr  1 11:34:56 2004
+++ b/sound/pci/au88x0/au8830.c	Thu Apr  1 11:34:56 2004
@@ -1,7 +1,7 @@
 #include "au8830.h"
 #include "au88x0.h"
 static struct pci_device_id snd_vortex_ids[] = {
-	{PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX2,
+	{PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX_2,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
 	{0,}
 };
diff -Nru a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
--- a/sound/pci/au88x0/au88x0.h	Thu Apr  1 11:34:56 2004
+++ b/sound/pci/au88x0/au88x0.h	Thu Apr  1 11:34:56 2004
@@ -80,8 +80,8 @@
 #define VORTEX_IS_QUAD(x) ((x->codec == NULL) ?  0 : (x->codec->ext_id|0x80))
 /* Check if chip has bug. */
 #define IS_BAD_CHIP(x) (\
-	(x->rev < 3 && x->device == PCI_DEVICE_ID_AUREAL_VORTEX) || \
-	(x->rev < 0xfe && x->device == PCI_DEVICE_ID_AUREAL_VORTEX2) || \
+	(x->rev < 3 && x->device == PCI_DEVICE_ID_AUREAL_VORTEX_1) || \
+	(x->rev < 0xfe && x->device == PCI_DEVICE_ID_AUREAL_VORTEX_2) || \
 	(x->rev < 0xfe && x->device == PCI_DEVICE_ID_AUREAL_ADVANTAGE))
 
 

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
