Return-Path: <linux-kernel-owner+w=401wt.eu-S1751738AbXAVLwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXAVLwy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbXAVLwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:52:54 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47664 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbXAVLwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:52:53 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 2/7] ehea: Fixing firmware queue config issue
Date: Mon, 22 Jan 2007 12:52:50 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1638
To: Jeff Garzik <jeff@garzik.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <ossthema@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Stefan Roscher <roscher@de.ibm.com>,
       Stefan Roscher <ossrosch@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701221252.50724.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to use exactly one queue for incoming packets in all
firmware configurations

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 13:59:07.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:01:38.000000000 +0100
@@ -998,7 +998,7 @@ static int ehea_configure_port(struct eh
 		     | EHEA_BMASK_SET(PXLY_RC_JUMBO_FRAME, 1);
 
 	for (i = 0; i < port->num_def_qps; i++)
-		cb0->default_qpn_arr[i] = port->port_res[i].qp->init_attr.qp_nr;
+		cb0->default_qpn_arr[i] = port->port_res[0].qp->init_attr.qp_nr;
 
 	if (netif_msg_ifup(port))
 		ehea_dump(cb0, sizeof(*cb0), "ehea_configure_port");


