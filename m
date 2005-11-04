Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbVKDA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbVKDA3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbVKDA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:29:50 -0500
Received: from mail.isurf.ca ([66.154.97.68]:13218 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S1030571AbVKDA3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:29:49 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/wireless/airo.c unsigned comparason
Date: Thu, 3 Nov 2005 19:30:47 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511031930.47317.ace@staticwave.ca>
X-Length: 1297
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fid is declared as a u32 (unsigned int), and then a few lines later, it is checked for a value < 0, which is clearly useless. 
In the two locations this function is used, in one it is *explicitly* given a negative number, which would be ignored with the
current definition.

Thanks to LinuxICC (http://linuxicc.sf.net).

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 750c016..849ac88 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -2040,7 +2040,7 @@ static int mpi_send_packet (struct net_d
 	return 1;
 }
 
-static void get_tx_error(struct airo_info *ai, u32 fid)
+static void get_tx_error(struct airo_info *ai, s32 fid)
 {
 	u16 status;
 

-- 
Gabriel A. Devenyi
ace@staticwave.ca
