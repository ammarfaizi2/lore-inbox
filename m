Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWFNMJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWFNMJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFNMJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:09:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5002 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751281AbWFNMJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:09:16 -0400
Date: Wed, 14 Jun 2006 07:07:33 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: fpavlic@de.ibm.com, linux390@de.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390: move var declarations behind ifdef
Message-ID: <20060614120733.GF15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two variables in drivers/s390/net/qeth_main.c:qeth_send_packet()
are only used if CONFIG_QETH_PERF_STATS.  Move their definition
under the same ifdef to remove compiler warning.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/s390/net/qeth_main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

74bcd2e9461534ccd39ec84455b0b2c07c7f24a5
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 9e671a4..8f8c0f4 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -4416,8 +4416,10 @@ qeth_send_packet(struct qeth_card *card,
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
 	int tx_bytes = skb->len;
+#ifdef CONFIG_QETH_PERF_STATS
 	unsigned short nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned short tso_size = skb_shinfo(skb)->tso_size;
+#endif
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
-- 
1.1.6
