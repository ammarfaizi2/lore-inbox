Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFCT0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFCT0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFCT0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:26:05 -0400
Received: from orb.pobox.com ([207.8.226.5]:41106 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261411AbVFCTZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:25:38 -0400
Date: Fri, 3 Jun 2005 14:25:25 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, roland@topspin.com
Subject: [PATCH] prom_find_machine_type typo breaks pSeries lpar boot
Message-ID: <20050603192525.GC11355@otto>
References: <374360000.1117810369@[10.10.2.4]> <52is0vwd49.fsf@topspin.com> <20050603182725.GB11355@otto> <52vf4vuum5.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52vf4vuum5.fsf@topspin.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in prom_find_machine_type from Ben's recent patch "ppc64: Fix
result code handling in prom_init" prevents pSeries LPAR systems from
booting.

Tested on a pSeries 570 and OpenPower 720 (both Power5 LPAR).

Signed-off-by: Nathan Lynch <ntl@pobox.com>

 arch/ppc64/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc5-git8/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-2.6.12-rc5-git8.orig/arch/ppc64/kernel/prom_init.c
+++ linux-2.6.12-rc5-git8/arch/ppc64/kernel/prom_init.c
@@ -1370,7 +1370,7 @@ static int __init prom_find_machine_type
 	}
 	/* Default to pSeries. We need to know if we are running LPAR */
 	rtas = call_prom("finddevice", 1, 1, ADDR("/rtas"));
-	if (!PHANDLE_VALID(rtas)) {
+	if (PHANDLE_VALID(rtas)) {
 		int x = prom_getproplen(rtas, "ibm,hypertas-functions");
 		if (x != PROM_ERROR) {
 			prom_printf("Hypertas detected, assuming LPAR !\n");
