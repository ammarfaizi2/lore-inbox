Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVKNKk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVKNKk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 05:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKNKk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 05:40:57 -0500
Received: from send.forptr.21cn.com ([202.105.45.52]:34803 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751062AbVKNKk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 05:40:56 -0500
Message-ID: <43786A16.9070100@21cn.com>
Date: Mon, 14 Nov 2005 18:42:30 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: [PATCH]IPv6: small fix for ipv6_dev_get_saddr(...)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: U40nbbOB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "score.rule++" doesn't make any sense for me. 
According to codes above, I think it should be "hiscore.rule++;" .


Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index: net/ipv6/addrconf.c
============================================================
--- a/net/ipv6/addrconf.c	2005-11-13 12:23:06.000000000 +0800
+++ b/net/ipv6/addrconf.c	2005-11-14 18:29:27.000000000 +0800
@@ -1045,9 +1045,10 @@ int ipv6_dev_get_saddr(struct net_device
 			}
 #endif
 			/* Rule 8: Use longest matching prefix */
-			if (hiscore.rule < 8)
+			if (hiscore.rule < 8) {
 				hiscore.matchlen = ipv6_addr_diff(&ifa_result->addr, daddr);
-			score.rule++;
+				hiscore.rule++;
+			}
 			score.matchlen = ipv6_addr_diff(&ifa->addr, daddr);
 			if (score.matchlen > hiscore.matchlen) {
 				score.rule = 8;

