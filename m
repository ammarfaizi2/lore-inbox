Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVKKM4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKKM4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVKKM4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:56:55 -0500
Received: from mail.isurf.ca ([66.154.97.68]:10981 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S1750706AbVKKM4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:56:54 -0500
Message-ID: <43749512.8040002@staticwave.ca>
Date: Fri, 11 Nov 2005 07:56:50 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [RESEND] [PATCH] drivers/net/wireless/airo.c unsigned comparason
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fid is declared as a u32 (unsigned int), and then a few lines later, it is checked for a value < 0, which is clearly useless.
In the two locations this function is used, in one it is *explicitly* given a negative number, which would be ignored with the
current definition.

Thanks to LinuxICC (http://linuxicc.sf.net).

This patch applies to linus' git tree as of 03.11.2005

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

