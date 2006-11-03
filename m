Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753331AbWKCQrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbWKCQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbWKCQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:47:25 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:59081 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1753331AbWKCQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:47:24 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.19-rc4 1/3] ehea: Nullpointer dereferencation fix
Date: Fri, 3 Nov 2006 17:47:20 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1154
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev <netdev@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>,
       "Christoph Raisch" <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "Jan-Bernd Themann" <ossthema@de.ibm.com>,
       Marcus Eder <meder@de.ibm.com>, "Thomas Klein" <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611031747.21667.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: Must check for nullpointer before dereferencing it - not afterwards.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

diff -Nurp git.netdev-2.6.base/drivers/net/ehea/ehea_qmr.c git.netdev-2.6/drivers/net/ehea/ehea_qmr.c
--- git.netdev-2.6.base/drivers/net/ehea/ehea_qmr.c	2006-11-03 14:19:51.000000000 +0100
+++ git.netdev-2.6/drivers/net/ehea/ehea_qmr.c	2006-11-03 14:27:53.000000000 +0100
@@ -209,11 +209,11 @@ int ehea_destroy_cq(struct ehea_cq *cq)
 {
 	u64 adapter_handle, hret;
 
-	adapter_handle = cq->adapter->handle;
-
 	if (!cq)
 		return 0;
 
+	adapter_handle = cq->adapter->handle;
+
 	/* deregister all previous registered pages */
 	hret = ehea_h_free_resource(adapter_handle, cq->fw_handle);
 	if (hret != H_SUCCESS) {
