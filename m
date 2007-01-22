Return-Path: <linux-kernel-owner+w=401wt.eu-S1751751AbXAVLxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbXAVLxZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbXAVLxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:53:25 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47692 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXAVLxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:53:23 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 3/7] ehea: Modified initial autoneg state determination
Date: Mon, 22 Jan 2007 12:53:20 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1318
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
Message-Id: <200701221253.20959.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Logical partitions are not allowed to (try to) set the autonegotiation status.
This patch removes the respective function call from the port setup function.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:02:20.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:11:30.000000000 +0100
@@ -642,6 +642,8 @@ int ehea_sense_port_attr(struct ehea_por
 		break;
 	}
 
+	port->autoneg = 1;
+
 	/* Number of default QPs */
 	port->num_def_qps = cb0->num_default_qps;
 
@@ -2334,8 +2336,6 @@ static int ehea_setup_single_port(struct
 
 	INIT_LIST_HEAD(&port->mc_list->list);
 
-	ehea_set_portspeed(port, EHEA_SPEED_AUTONEG);
-
 	ret = ehea_sense_port_attr(port);
 	if (ret)
 		goto out;

