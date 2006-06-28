Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWF1AwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWF1AwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWF1AwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:52:16 -0400
Received: from xenotime.net ([66.160.160.81]:6092 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932597AbWF1AwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:52:15 -0400
Date: Tue, 27 Jun 2006 17:50:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz, akpm <akpm@osdl.org>
Subject: [PATCH] sound: fix cs4232 section mismatch
Message-Id: <20060627175025.dde71b87.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix section mismatch: adds __init to probe function,
frees some init memory, not critical.
WARNING: sound/oss/cs4232.o - Section mismatch: reference to .init.text: from .text after 'cs4232_pnp_probe' (at offset 0x152)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/oss/cs4232.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g11.orig/sound/oss/cs4232.c
+++ linux-2617-g11/sound/oss/cs4232.c
@@ -405,7 +405,7 @@ static const struct pnp_device_id cs4232
 
 MODULE_DEVICE_TABLE(pnp, cs4232_pnp_table);
 
-static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
+static int __init cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct address_info *isapnpcfg;
 


---
