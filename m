Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVBXHYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVBXHYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVBXHXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:23:01 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:38810 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261881AbVBXHVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:21:49 -0500
Subject: [PATCH 6/13] no aggressive idle balancing
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229650.5177.78.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-rXjf2NuVIRVZpA76fU0s"
Date: Thu, 24 Feb 2005 18:21:40 +1100
Message-Id: <1109229700.5177.79.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rXjf2NuVIRVZpA76fU0s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


6/13


--=-rXjf2NuVIRVZpA76fU0s
Content-Disposition: attachment; filename=sched-lessaggressive-idle.patch
Content-Type: text/x-patch; name=sched-lessaggressive-idle.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the special casing for idle CPU balancing. Things like this are
hurting for example on SMT, where are single sibling being idle doesn't
really warrant a really aggressive pull over the NUMA domain, for example.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:43.537742489 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:38.340504724 +1100
@@ -1875,15 +1875,9 @@
 
 	/* Get rid of the scaling factor, rounding down as we divide */
 	*imbalance = *imbalance / SCHED_LOAD_SCALE;
-
 	return busiest;
 
 out_balanced:
-	if (busiest && (idle == NEWLY_IDLE ||
-			(idle == SCHED_IDLE && max_load > SCHED_LOAD_SCALE)) ) {
-		*imbalance = 1;
-		return busiest;
-	}
 
 	*imbalance = 0;
 	return NULL;

--=-rXjf2NuVIRVZpA76fU0s--

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
