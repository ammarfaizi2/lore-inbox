Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266815AbUG1HNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUG1HNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUG1HM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:12:27 -0400
Received: from ozlabs.org ([203.10.76.45]:3978 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266792AbUG1HLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:47 -0400
Date: Wed, 28 Jul 2004 16:54:50 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [4/15] orinoco merge preliminaries - use ALIGN()
Message-ID: <20040728065450.GG16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065418.GF16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kernel's ALIGN macro instead of our own dodgy version for
rounding things up to an even number.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:31.213900600 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:34.768360240 +1000
@@ -490,8 +490,6 @@
 
 #define DUMMY_FID		0xFFFF
 
-#define RUP_EVEN(a) (((a) + 1) & (~1))
-
 /*#define MAX_MULTICAST(priv)	(priv->firmware_type == FIRMWARE_TYPE_AGERE ? \
   HERMES_MAX_MULTICAST : 0)*/
 #define MAX_MULTICAST(priv)	(HERMES_MAX_MULTICAST)
@@ -847,7 +845,7 @@
 	}
 
 	/* Round up for odd length packets */
-	err = hermes_bap_pwrite(hw, USER_BAP, p, RUP_EVEN(data_len), txfid, data_off);
+	err = hermes_bap_pwrite(hw, USER_BAP, p, ALIGN(data_len, 2), txfid, data_off);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",
 		       dev->name, err);
@@ -1132,7 +1130,7 @@
 	}
 
 	p = skb_put(skb, data_len);
-	err = hermes_bap_pread(hw, IRQ_BAP, p, RUP_EVEN(data_len),
+	err = hermes_bap_pread(hw, IRQ_BAP, p, ALIGN(data_len, 2),
 			       rxfid, data_off);
 	if (err) {
 		printk(KERN_ERR "%s: error %d reading frame. "


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
