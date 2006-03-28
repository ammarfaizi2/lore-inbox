Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWC1Wgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWC1Wgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWC1Wgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:36:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48294 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932464AbWC1Wgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:36:36 -0500
Date: Tue, 28 Mar 2006 16:36:23 -0600
To: tsbogend@alpha.franken.de, donf@us.ibm.com
Cc: jklewis@us.bm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
Message-ID: <20060328223623.GD2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please sign-off/ack/apply and/or forward upstream.

[PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments

The comments concerning how the pcnet32 ethernet device driver selects 
the MAC addr to use are incorrect. A recent patch (in the last 3 months)
changed how the code worked, but did not change the comments.

Side comment: the new behaviour is good; I've got a pcnet32 card which
powers up with garbage in the CSR's, and a good MAC addr in the PROM.

Signed-off-by: Linas Vepstas <linas@linas.org>

----

 drivers/net/pcnet32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-git6/drivers/net/pcnet32.c
===================================================================
--- linux-2.6.16-git6.orig/drivers/net/pcnet32.c	2006-03-23 12:21:41.000000000 -0600
+++ linux-2.6.16-git6/drivers/net/pcnet32.c	2006-03-28 16:08:23.398158717 -0600
@@ -1167,8 +1167,8 @@ pcnet32_probe1(unsigned long ioaddr, int
 	 * station address PROM at the base address and programmed into the
 	 * "Physical Address Registers" CSR12-14.
 	 * As a precautionary measure, we read the PROM values and complain if
-	 * they disagree with the CSRs.  Either way, we use the CSR values, and
-	 * double check that they are valid.
+	 * they disagree with the CSRs.  If they miscompare, and the PROM addr
+	 * is valid, then the PROM addr is used.
 	 */
 	for (i = 0; i < 3; i++) {
 		unsigned int val;
