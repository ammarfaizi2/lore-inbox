Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWF1VdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWF1VdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWF1VdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:33:24 -0400
Received: from mail.gmx.net ([213.165.64.21]:33760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751559AbWF1VdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:33:23 -0400
X-Authenticated: #704063
Subject: [Patch] Deref in drivers/block/paride/pf.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: tim@cyberelk.net
Content-Type: text/plain
Date: Wed, 28 Jun 2006 23:33:18 +0200
Message-Id: <1151530398.27856.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another possible dereference detected by
coverity (id #759). pf_probe() might call
pf_identify() which might call get_capacity()
which dereferences pf->disk

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.17-git11/drivers/block/paride/pf.c.orig	2006-06-28 23:30:13.000000000 +0200
+++ linux-2.6.17-git11/drivers/block/paride/pf.c	2006-06-28 23:30:32.000000000 +0200
@@ -707,7 +707,7 @@ static int pf_detect(void)
 			if (pi_init(pf->pi, 0, conf[D_PRT], conf[D_MOD],
 				    conf[D_UNI], conf[D_PRO], conf[D_DLY],
 				    pf_scratch, PI_PF, verbose, pf->name)) {
-				if (!pf_probe(pf) && pf->disk) {
+				if (pf->disk && !pf_probe(pf)) {
 					pf->present = 1;
 					k++;
 				} else


