Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbVJTEud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbVJTEud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 00:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbVJTEud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 00:50:33 -0400
Received: from send.forptr.21cn.com ([202.105.45.50]:4281 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751739AbVJTEuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 00:50:32 -0400
Message-ID: <43572256.40101@21cn.com>
Date: Thu, 20 Oct 2005 12:51:34 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]behavior of ip6_route_input() for link local address.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I find that linux will reply echo request destined to an address which belongs to an interface other than the one from which the request received.
This behavior doesn't make sense for link local address.


Index: net/ipv6/route.c
===================================================================
--- linux-2.6.14-rc4-git6/net/ipv6/route.c	2005-10-20 12:02:49.000000000 +0800
+++ linux/net/ipv6/route.c	2005-10-20 12:21:03.000000000 +0800
@@ -483,7 +483,7 @@
 		goto out;
 	}
 
-	rt = rt6_device_match(rt, skb->dev->ifindex, 0);
+	rt = rt6_device_match(rt, skb->dev->ifindex, strict);
 	BACKTRACK();
 
 	if (!rt->rt6i_nexthop && !(rt->rt6i_flags & RTF_NONEXTHOP)) {
