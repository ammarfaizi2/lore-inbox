Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUG1HPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUG1HPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUG1HOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:14:41 -0400
Received: from ozlabs.org ([203.10.76.45]:8330 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266803AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:58:27 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [10/15] orinoco merge preliminaries - miscelaneous
Message-ID: <20040728065827.GM16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065800.GL16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Random trivial cleanups that don't belong with anything else:
	- Use ETH_DATA_LEN instead of hard-coded constant
	- Remove a duplicated constant in an | expression

Signed-off-by: David Gibson <hermes@gibson.dropbear.id>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:43.829982664 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:47.239464344 +1000
@@ -813,7 +813,7 @@
 			   HERMES_802_3_OFFSET - HERMES_802_11_OFFSET);
 
 	/* Encapsulate Ethernet-II frames */
-	if (ntohs(eh->h_proto) > 1500) { /* Ethernet-II frame */
+	if (ntohs(eh->h_proto) > ETH_DATA_LEN) { /* Ethernet-II frame */
 		struct header_struct hdr;
 		data_len = len;
 		data_off = HERMES_802_3_OFFSET + sizeof(hdr);
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:43.818984336 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:47.241464040 +1000
@@ -78,7 +78,7 @@
 
 static char dev_info[] = "orinoco_tmd";
 
-#define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
+#define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
 
 static int orinoco_tmd_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
