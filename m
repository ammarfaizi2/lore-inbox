Return-Path: <linux-kernel-owner+w=401wt.eu-S1751698AbXAVL4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXAVL4n (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXAVL4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:56:43 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47879 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXAVL4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:56:42 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 7/7] ehea: Fixed possible nullpointer access
Date: Mon, 22 Jan 2007 12:55:20 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 472
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
Message-Id: <200701221255.20768.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed possible nullpointer access in event queue processing

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:33:04.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:36:05.000000000 +0100
@@ -575,8 +575,9 @@ static struct ehea_port *ehea_get_port(s
 	int i;
 
 	for (i = 0; i < adapter->num_ports; i++)
-		if (adapter->port[i]->logical_port_id == logical_port)
-			return adapter->port[i];
+		if (adapter->port[i])
+	                if (adapter->port[i]->logical_port_id == logical_port)
+				return adapter->port[i];
 	return NULL;
 }
 

