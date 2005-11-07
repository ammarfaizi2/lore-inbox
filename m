Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVKGOM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVKGOM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVKGOM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:12:26 -0500
Received: from send.forptr.21cn.com ([202.105.45.49]:56573 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S932468AbVKGOMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:12:25 -0500
Message-ID: <436F610E.8010400@21cn.com>
Date: Mon, 07 Nov 2005 22:13:34 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
Subject: [PATCH][MCAST]Clear MAF_GSQUERY flag when process MLDv1 general query
 messages.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: rEGlH9OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
 

MAF_GSQUERY flag may cause problem when MLDv1 compatibility mode expires.  



Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index: net/ipv6/mcast.c
================================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-11-05 09:09:47.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-07 21:57:27.000000000 +0800
@@ -1166,6 +1166,7 @@ int igmp6_event_query(struct sk_buff *sk
 	if (group_type == IPV6_ADDR_ANY) {
 		for (ma = idev->mc_list; ma; ma=ma->next) {
 			spin_lock_bh(&ma->mca_lock);
+			ma->mca_flags &= ~MAF_GSQUERY;
 			igmp6_group_queried(ma, max_delay);
 			spin_unlock_bh(&ma->mca_lock);
 		}

