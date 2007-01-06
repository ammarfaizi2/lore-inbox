Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbXAFClG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXAFClG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXAFCab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36611 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXAFCaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:18 -0500
Message-Id: <20070106023354.554430000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, clameter@engr.sgi.com, sgoel01@yahoo.com
Subject: [patch 27/50] Buglet in vmscan.c
Content-Disposition: inline; filename=buglet-in-vmscan.c.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Shantanu Goel <sgoel01@yahoo.com>

Fix a rather obvious buglet.  Noticed while instrumenting the VM using
/proc/vmstat.

Cc: Christoph Lameter <clameter@engr.sgi.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/mm/vmscan.c
+++ linux-2.6.19.1/mm/vmscan.c
@@ -691,7 +691,7 @@ static unsigned long shrink_inactive_lis
 			__count_vm_events(KSWAPD_STEAL, nr_freed);
 		} else
 			__count_zone_vm_events(PGSCAN_DIRECT, zone, nr_scan);
-		__count_vm_events(PGACTIVATE, nr_freed);
+		__count_zone_vm_events(PGSTEAL, zone, nr_freed);
 
 		if (nr_taken == 0)
 			goto done;

--
