Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161347AbWALWFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWALWFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWALWFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:05:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:29077 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161347AbWALWFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:05:49 -0500
Date: Thu, 12 Jan 2006 16:05:30 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Jiri Slaby <slaby@liberouter.org>, mulix@mulix.org,
       Jaroslav Kysela <perex@suse.cz>, audio@tridentmicro.com
Subject: [PATCH] Prevent ALSA trident driver from grabbing pcnet32 hardware
Message-ID: <20060112220530.GF17539@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some pcnet32 hardware erroneously has the Vendor ID for Trident.  The
pcnet32 driver looks for the PCI ethernet class before grabbing the
hardware, but the current trident driver does not check against the
PCI audio class.  This allows the trident driver to claim the pcnet32
hardware.  This patch prevents that.

Per Jiri Slaby's request, I changed the trident driver to use
PCI_DEVICE macro and PCI ID #defines.

This patch is untested on Trident 4DWAVE_DX hardware, but has been
tested on pcnet32 hardware.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>


diff -r 4a7597b41d25 sound/pci/trident/trident.c
--- a/sound/pci/trident/trident.c	Wed Jan 11 19:14:08 2006
+++ b/sound/pci/trident/trident.c	Thu Jan 12 15:52:34 2006
@@ -64,9 +64,11 @@
 MODULE_PARM_DESC(wavetable_size, "Maximum memory size in kB for wavetable synth.");
 
 static struct pci_device_id snd_trident_ids[] = {
-	{ 0x1023, 0x2000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* Trident 4DWave DX PCI Audio */
-	{ 0x1023, 0x2001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* Trident 4DWave NX PCI Audio */
-	{ 0x1039, 0x7018, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* SiS SI7018 PCI Audio */
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX), 
+		PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0},
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX), 
+		0, 0, 0},
+	{PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7018), 0, 0, 0},
 	{ 0, }
 };
 
