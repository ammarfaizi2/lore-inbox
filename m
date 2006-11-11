Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754914AbWKKXyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbWKKXyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 18:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbWKKXyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 18:54:21 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:51406 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1754913AbWKKXyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 18:54:21 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix via586 irq routing for pirq 5
Date: Sun, 12 Nov 2006 00:52:44 +0100
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>,
       Daniel Paschka <monkey20181@gmx.net>, Adrian Bunk <bunk@susta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611120052.45485.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1378;
	Body=6 Fuz1=6 Fuz2=6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( for 2.6.19, and i think it would be good for -stable too... )

[PATCH] fix via586 irq routing for pirq 5

fix interrput routing for via 586 bridges. pirq can be 5 which needs to be
mapped to INTD. but currently the access functions can handle only pirq 1-4.
this is similar to the other via chipsets where pirq 4 and 5 are both mapped
to INTD. fixes bugzilla #7490

Cc: Daniel Paschka <monkey20181@gmx.net>
Cc: Adrian Bunk <bunk@susta.de>
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>


diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index dbc4aae..567126b 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -255,13 +255,13 @@ static int pirq_via_set(struct pci_dev *
  */
 static int pirq_via586_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	static const unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	static const unsigned int pirqmap[5] = { 3, 2, 5, 1, 1 };
 	return read_config_nybble(router, 0x55, pirqmap[pirq-1]);
 }
 
 static int pirq_via586_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	static const unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	static const unsigned int pirqmap[5] = { 3, 2, 5, 1, 1 };
 	write_config_nybble(router, 0x55, pirqmap[pirq-1], irq);
 	return 1;
 }
