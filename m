Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274788AbTHFCrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274813AbTHFCrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:47:32 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18305 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S274788AbTHFCqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:46:51 -0400
Date: Tue, 5 Aug 2003 22:15:07 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221507.GC13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030805221415.GB13275@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805221415.GB13275@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/08/05	ambx1@neo.rr.com	1.1108
# [PNP] Remove protocol_data from pnp_dev and pnp_card
# 
# This is not needed.
# 
# --------------------------------------------
#
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Aug  5 21:25:05 2003
+++ b/include/linux/pnp.h	Tue Aug  5 21:25:05 2003
@@ -133,7 +133,6 @@
 	struct pnp_protocol * protocol;
 	struct pnp_id * id;		/* contains supported EISA IDs*/
 
-	void	      * protocol_data;	/* Used to store protocol specific data */
 	unsigned char	pnpver;		/* Plug & Play version */
 	unsigned char	productver;	/* product version */
 	unsigned int	serial;		/* serial number */
@@ -149,16 +148,6 @@
 	(card) != global_to_pnp_card(&pnp_cards); \
 	(card) = global_to_pnp_card((card)->global_list.next))
 
-static inline void *pnp_get_card_protodata (struct pnp_card *pcard)
-{
-	return pcard->protocol_data;
-}
-
-static inline void pnp_set_card_protodata (struct pnp_card *pcard, void *data)
-{
-	pcard->protocol_data = data;
-}
-
 struct pnp_card_link {
 	struct pnp_card * card;
 	struct pnp_card_driver * driver;
@@ -198,7 +187,6 @@
 	struct pnp_option * dependent;
 	struct pnp_resource_table res;
 
-	void * protocol_data;		/* Used to store protocol specific data */
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
@@ -226,16 +214,6 @@
 static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
 {
 	dev_set_drvdata(&pdev->dev, data);
-}
-
-static inline void *pnp_get_protodata (struct pnp_dev *pdev)
-{
-	return pdev->protocol_data;
-}
-
-static inline void pnp_set_protodata (struct pnp_dev *pdev, void *data)
-{
-	pdev->protocol_data = data;
 }
 
 struct pnp_fixup {
