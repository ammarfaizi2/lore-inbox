Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWCVQky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWCVQky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWCVQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:40:52 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49837 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932069AbWCVQkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:40:49 -0500
Date: Wed, 22 Mar 2006 17:42:09 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [patch 4/6] s390: qeth :allow setting of attribute "route6" to
 "no_router".
Message-ID: <20060322174209.0763b174@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/6] s390: qeth :allow setting of attribute "route6" to "no_router". 

From: Ursula Braun <braunu@de.ibm.com>
	when setting route6 attribute back to no_router qeth does not
	issue an IP ASSIST command to reset router value to no_router.
	Once primary_router is set device stays in this mode.
	Issue an IP ASSIST command when no_router is set in route6.
	Device will be reset and thus will not longer run as a primary
	router.
			    
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_main.c |    5 -----
 1 files changed, 5 deletions(-)

diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 69329ea..021cd5d 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -7339,11 +7339,6 @@ qeth_setrouting_v6(struct qeth_card *car
 	qeth_correct_routing_type(card, &card->options.route6.type,
 				  QETH_PROT_IPV6);
 
-	if ((card->options.route6.type == NO_ROUTER) ||
-	    ((card->info.type == QETH_CARD_TYPE_OSAE) &&
-	     (card->options.route6.type == MULTICAST_ROUTER) &&
-	     !qeth_is_supported6(card,IPA_OSA_MC_ROUTER)))
-		return 0;
 	rc = qeth_send_setrouting(card, card->options.route6.type,
 				  QETH_PROT_IPV6);
 	if (rc) {
