Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbULACSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbULACSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULACSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:18:42 -0500
Received: from ozlabs.org ([203.10.76.45]:31393 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261160AbULACSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:18:40 -0500
Date: Wed, 1 Dec 2004 13:17:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Reorder sata_nv amongst SATA drivers
Message-ID: <20041201021723.GA1001@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  Hardly a big deal, but makes life a little
nicer.

Moves the sata_nv (NForce) driver earlier in the Makefile, so that it
will be scanned earlier than other drivers.  Since this SATA
controller is in the NForce integrated chipset, it's very likely to be
considered the "primary" controller on motherboards which also have
another SATA controller (e.g. the ASUS K8N-E, which has a Silicon
Image SATA/RAID controller too, handled by the sata_sil driver).
Therefore, it makes sense to list it early, so that Linux's (default)
idea of the order of devices won't be confusingly different from order
that the BIOS thinks they belong in.

Index: working-2.6/drivers/scsi/Makefile
===================================================================
--- working-2.6.orig/drivers/scsi/Makefile	2004-10-19 13:37:59.000000000 +1000
+++ working-2.6/drivers/scsi/Makefile	2004-11-22 20:17:49.445893320 +1100
@@ -123,13 +123,13 @@
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
+obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
 obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
 obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
 obj-$(CONFIG_SCSI_SATA_SX4)	+= libata.o sata_sx4.o
-obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
 
 obj-$(CONFIG_ARM)		+= arm/
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
