Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUAHCiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUAHChD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:37:03 -0500
Received: from palrel10.hp.com ([156.153.255.245]:24517 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263545AbUAHCfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:35:15 -0500
Date: Wed, 7 Jan 2004 18:35:14 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] gcc warning fix
Message-ID: <20040108023514.GF13620@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir2609_afirda_max_string.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Fix a gcc warning


diff -u -p linux/net/irda/af_irda.d5.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d5.c	Wed Nov 19 16:21:42 2003
+++ linux/net/irda/af_irda.c	Wed Nov 19 16:26:04 2003
@@ -1890,11 +1890,10 @@ static int irda_setsockopt(struct socket
 		case IAS_STRING:
 			/* Should check charset & co */
 			/* Check length */
-			if(ias_opt->attribute.irda_attrib_string.len >
-			   IAS_MAX_STRING) {
-				kfree(ias_opt);
-				return -EINVAL;
-			}
+			/* The length is encoded in a __u8, and
+			 * IAS_MAX_STRING == 256, so there is no way
+			 * userspace can pass us a string too large.
+			 * Jean II */
 			/* NULL terminate the string (avoid troubles) */
 			ias_opt->attribute.irda_attrib_string.string[ias_opt->attribute.irda_attrib_string.len] = '\0';
 			/* Add a string attribute */
