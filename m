Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUIGAfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUIGAfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 20:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUIGAfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 20:35:39 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:61876
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S267451AbUIGAfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 20:35:37 -0400
Date: Mon, 6 Sep 2004 20:39:27 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Make IRDA_DEBUG() Calls Uniform in ircomm_{lmp,ttp}.c
Message-ID: <20040907003927.GB4370@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.4.26
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While chasing down a kernel janitor task, I found a minor typo/cosmetic
blemish in ircomm_lmp.c and ircomm_ttp.c. The patches below fix two 
IRDA_DEBUG calls to look like all of the other IRDA_DEBUG calls in these 
two files.

Diffed against 2.6.7
Compile tested

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

diff -Naur linux-2.6.7/net/irda/ircomm/ircomm_lmp.c b/net/irda/ircomm/ircomm_lmp.c
--- linux-2.6.7/net/irda/ircomm/ircomm_lmp.c	2003-12-17 21:58:05.000000000 -0500
+++ b/net/irda/ircomm/ircomm_lmp.c	2004-09-06 20:06:01.000000000 -0400
@@ -64,7 +64,7 @@
 
 	self->lsap = irlmp_open_lsap(LSAP_ANY, &notify, 0);
 	if (!self->lsap) {
-		IRDA_DEBUG(0,"%sfailed to allocate tsap\n", __FUNCTION__ );
+		IRDA_DEBUG(0,"%s(), failed to allocate tsap\n", __FUNCTION__ );
 		return -1;
 	}
 	self->slsap_sel = self->lsap->slsap_sel;
diff -Naur linux-2.6.7/net/irda/ircomm/ircomm_ttp.c b/net/irda/ircomm/ircomm_ttp.c
--- linux-2.6.7/net/irda/ircomm/ircomm_ttp.c	2003-12-17 21:59:41.000000000 -0500
+++ b/net/irda/ircomm/ircomm_ttp.c	2004-09-06 20:07:16.000000000 -0400
@@ -65,7 +65,7 @@
 	self->tsap = irttp_open_tsap(LSAP_ANY, DEFAULT_INITIAL_CREDIT,
 				     &notify);
 	if (!self->tsap) {
-		IRDA_DEBUG(0, "%sfailed to allocate tsap\n", __FUNCTION__ );
+		IRDA_DEBUG(0, "%s(), failed to allocate tsap\n", __FUNCTION__ );
 		return -1;
 	}
 	self->slsap_sel = self->tsap->stsap_sel;

Regards,

Kurt
-- 
Intolerance is the last defense of the insecure.
