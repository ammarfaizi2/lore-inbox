Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTEODYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTEODXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:23:20 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:20204 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263766AbTEODSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:24 -0400
Date: Thu, 15 May 2003 04:31:09 +0100
Message-Id: <200305150331.h4F3V96r000655@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix tulip slowdowns patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This found its way into 2.4 on 13 Mar 2002, with the comment
"Revert tulip changes which were apparently causing slowdowns"
by some guy called Jeff Garzik.

It was part of a larger cset. The other part touched tulip_core.c
in a part that no longer seems to be there in 2.5 (See the
DC21041 part of tulip_up in 2.4).

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tulip/tulip.h linux-2.5/drivers/net/tulip/tulip.h
--- bk-linus/drivers/net/tulip/tulip.h	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/drivers/net/tulip/tulip.h	2003-04-22 01:23:14.000000000 +0100
@@ -199,8 +199,8 @@ enum t21041_csr13_bits {
 	csr13_cac = (1<<2), /* CSR13/14/15 autoconfiguration */
 	csr13_srl = (1<<0), /* When reset, resets all SIA functions, machines */
 
-	csr13_mask_auibnc = (csr13_eng | csr13_aui | csr13_srl),
-	csr13_mask_10bt = (csr13_eng | csr13_srl),
+	csr13_mask_auibnc = (csr13_eng | csr13_aui | csr13_srl | csr13_cac),
+	csr13_mask_10bt = (csr13_eng | csr13_srl | csr13_cac),
 };
 
 enum t21143_csr6_bits {
