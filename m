Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWF0UNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWF0UNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWF0UNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:13:11 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5760 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161265AbWF0UNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:13:07 -0400
Message-Id: <20060627201101.386390000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       Vlad Yasevich <vladislav.yasevich@hp.com>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: [PATCH 07/25] SCTP: Reset rtt_in_progress for the chunk when processing its sack.
Content-Disposition: inline; filename=sctp-reset-rtt_in_progress-for-the-chunk-when-processing-its-sack.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

Reset rtt_in_progress for the chunk when processing its sack.

Signed-off-by: Vlad Yasevich <vladislav.yasevich@hp.com>
Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/sctp/outqueue.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.1.orig/net/sctp/outqueue.c
+++ linux-2.6.17.1/net/sctp/outqueue.c
@@ -1262,6 +1262,7 @@ static void sctp_check_transmitted(struc
 			   	if (!tchunk->tsn_gap_acked &&
 				    !tchunk->resent &&
 				    tchunk->rtt_in_progress) {
+					tchunk->rtt_in_progress = 0;
 					rtt = jiffies - tchunk->sent_at;
 					sctp_transport_update_rto(transport,
 								  rtt);

--
