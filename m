Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVAMBF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVAMBF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVALVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:51:54 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57254 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261502AbVALVst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:49 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.B8o2ZVVtV8zXmvPq@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:27 -0800
Message-Id: <20051121348.PHUuXZDT6PZldJ8r@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][18/18] InfiniBand/core: rename handle_outgoing_smp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:27.0782 (UTC) FILETIME=[72F69A60:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change routine name from handle_outgoing_smp to handle_outgoing_dr_smp.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/core/mad.c	(revision 1449)
+++ linux/drivers/infiniband/core/mad.c	(revision 1450)
@@ -619,9 +619,9 @@
  * Return 1 if SMP was consumed locally (whether or not solicited)
  * Return < 0 if error
  */
-static int handle_outgoing_smp(struct ib_mad_agent_private *mad_agent_priv,
-			       struct ib_smp *smp,
-			       struct ib_send_wr *send_wr)
+static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
+				  struct ib_smp *smp,
+				  struct ib_send_wr *send_wr)
 {
 	int ret, alloc_flags;
 	unsigned long flags;
@@ -797,7 +797,8 @@
 
 		smp = (struct ib_smp *)send_wr->wr.ud.mad_hdr;
 		if (smp->mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
-			ret = handle_outgoing_smp(mad_agent_priv, smp, send_wr);
+			ret = handle_outgoing_dr_smp(mad_agent_priv, smp,
+						     send_wr);
 			if (ret < 0)		/* error */
 				goto error2;
 			else if (ret == 1)	/* locally consumed */

