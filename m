Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVBXEUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVBXEUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVBXES3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:18:29 -0500
Received: from ozlabs.org ([203.10.76.45]:16566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261788AbVBXENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:24 -0500
Date: Thu, 24 Feb 2005 15:01:53 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [9/14] Orinoco driver updates - update is_ethersnap()
Message-ID: <20050224040153.GK32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040052.GJ32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the is_ethersnap() function take a void * rather than a pointer
to the internal header structure.  This makes more logical sense and
reduces dependencies between different parts of the code.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-24 14:50:48.426788064 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-24 14:50:50.125529816 +1100
@@ -966,15 +966,17 @@
 
 /* Does the frame have a SNAP header indicating it should be
  * de-encapsulated to Ethernet-II? */
-static inline int is_ethersnap(struct header_struct *hdr)
+static inline int is_ethersnap(void *_hdr)
 {
+	u8 *hdr = _hdr;
+
 	/* We de-encapsulate all packets which, a) have SNAP headers
 	 * (i.e. SSAP=DSAP=0xaa and CTRL=0x3 in the 802.2 LLC header
 	 * and where b) the OUI of the SNAP header is 00:00:00 or
 	 * 00:00:f8 - we need both because different APs appear to use
 	 * different OUIs for some reason */
-	return (memcmp(&hdr->dsap, &encaps_hdr, 5) == 0)
-		&& ( (hdr->oui[2] == 0x00) || (hdr->oui[2] == 0xf8) );
+	return (memcmp(hdr, &encaps_hdr, 5) == 0)
+		&& ( (hdr[5] == 0x00) || (hdr[5] == 0xf8) );
 }
 
 static inline void orinoco_spy_gather(struct net_device *dev, u_char *mac,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
