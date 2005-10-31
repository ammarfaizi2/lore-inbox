Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVJaCvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVJaCvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJaCvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:51:12 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:16621 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751286AbVJaCvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:51:10 -0500
Message-ID: <436586F0.9080101@21cn.com>
Date: Mon, 31 Oct 2005 10:52:32 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
Subject: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: rWWnZ6OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I think ip6_mc_add_src(...) should be called when number of sources is zero and filter mode is exclude.

Regards



Signed-off-by: Yan Zheng <yanzheng@21cn.com> 

Index: net/ipv6/mcast.c
================================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-10-31 10:37:36.000000000 +0800
@@ -545,8 +545,10 @@ int ip6_mc_msfilter(struct sock *sk, str
 			sock_kfree_s(sk, newpsl, IP6_SFLSIZE(newpsl->sl_max));
 			goto done;
 		}
-	} else
+	} else {
 		newpsl = NULL;
+		ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
+	}
 	psl = pmc->sflist;
 	if (psl) {
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode,
