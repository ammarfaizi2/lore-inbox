Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162262AbWKPCrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162262AbWKPCrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162248AbWKPCqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:46:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15504 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:46:40 -0500
Message-Id: <20061116024742.602522000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, monkey20181@gmx.net,
       daniel.ritz-ml@swissonline.ch, daniel.ritz@gmx.ch, bunk@susta.de
Subject: [patch 20/30] fix via586 irq routing for pirq 5
Content-Disposition: inline; filename=fix-via586-irq-routing-for-pirq-5.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>

Fix interrupt routing for via 586 bridges.  pirq can be 5 which needs to be
mapped to INTD.  But currently the access functions can handle only pirq
1-4.  this is similar to the other via chipsets where pirq 4 and 5 are both
mapped to INTD.  Fixes bugzilla #7490

Cc: Daniel Paschka <monkey20181@gmx.net>
Cc: Adrian Bunk <bunk@susta.de>
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/i386/pci/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.2.orig/arch/i386/pci/irq.c
+++ linux-2.6.18.2/arch/i386/pci/irq.c
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

--
