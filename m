Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUG1HdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUG1HdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUG1HdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:33:01 -0400
Received: from ozlabs.org ([203.10.76.45]:9098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266807AbUG1HLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:49 -0400
Date: Wed, 28 Jul 2004 17:00:18 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [13/15] orinoco merge preliminaries - don't typedef structs
Message-ID: <20040728070018.GP16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax> <20040728065827.GM16908@zax> <20040728065913.GN16908@zax> <20040728065953.GO16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065953.GO16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In line with normal kernel conventions, don't create typedefs for
structures.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/hermes.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.c	2004-07-28 14:57:53.055551256 +1000
+++ working-2.6/drivers/net/wireless/hermes.c	2004-07-28 15:04:15.767370216 +1000
@@ -224,7 +224,7 @@
  *
  * Callable from any context, but locking is your problem. */
 int hermes_docmd_wait(hermes_t *hw, u16 cmd, u16 parm0,
-		      hermes_response_t *resp)
+		      struct hermes_response *resp)
 {
 	int err;
 	int k;
Index: working-2.6/drivers/net/wireless/hermes.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.h	2004-07-28 14:58:27.164365928 +1000
+++ working-2.6/drivers/net/wireless/hermes.h	2004-07-28 15:01:39.039196520 +1000
@@ -252,9 +252,9 @@
 	u16 linkstatus;         /* Link status */
 } __attribute__ ((packed));
 
-typedef struct hermes_response {
+struct hermes_response {
 	u16 status, resp0, resp1, resp2;
-} hermes_response_t;
+};
 
 /* "ID" structure - used for ESSID and station nickname */
 struct hermes_idstring {
@@ -262,9 +262,9 @@
 	u16 val[16];
 } __attribute__ ((packed));
 
-typedef struct hermes_multicast {
+struct hermes_multicast {
 	u8 addr[HERMES_MAX_MULTICAST][ETH_ALEN];
-} __attribute__ ((packed)) hermes_multicast_t;
+} __attribute__ ((packed));
 
 // #define HERMES_DEBUG_BUFFER 1
 #define HERMES_DEBUG_BUFSIZE 4096
@@ -316,7 +316,7 @@
 			int reg_spacing);
 int hermes_init(hermes_t *hw);
 int hermes_docmd_wait(hermes_t *hw, u16 cmd, u16 parm0,
-		      hermes_response_t *resp);
+		      struct hermes_response *resp);
 int hermes_allocate(hermes_t *hw, u16 size, u16 *fid);
 
 int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:00:37.185599696 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:05.235849864 +1000
@@ -1768,7 +1768,7 @@
 
 	if (! promisc && (mc_count || priv->mc_count) ) {
 		struct dev_mc_list *p = dev->mc_list;
-		hermes_multicast_t mclist;
+		struct hermes_multicast mclist;
 		int i;
 
 		for (i = 0; i < mc_count; i++) {

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
