Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVJPPYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJPPYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 11:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVJPPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 11:24:25 -0400
Received: from send.forptr.21cn.com ([202.105.45.49]:60918 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751321AbVJPPYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 11:24:24 -0400
Message-ID: <435270E9.10005@21cn.com>
Date: Sun, 16 Oct 2005 23:25:29 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]The second param of addrconf_ifdown() in function addrconf_notify()
 for event NETDEV_CHANGEMTU.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 
I think the second parameter of addrconf_ifdown() should be 0 for event NETDEV_CHANGEMTU.




Signed-off-by: Yan Zheng  <yanzheng@21cn.com>

Index: net/ipv6/addrconf.c
===================================================================
--- linux-2.6.14-rc4-git2/net/ipv6/addrconf.c	2005-10-14 18:28:01.000000000 +0800
+++ linux/net/ipv6/addrconf.c	2005-10-16 23:04:40.000000000 +0800
@@ -2018,7 +2018,7 @@
 			   stop IPv6 on this interface.
 			 */
 			if (dev->mtu < IPV6_MIN_MTU)
-				addrconf_ifdown(dev, event != NETDEV_DOWN);
+				addrconf_ifdown(dev, 0);
 		}
 		break;
 
@@ -2036,7 +2036,7 @@
 		/*
 		 *	Remove all addresses from this interface.
 		 */
-		addrconf_ifdown(dev, event != NETDEV_DOWN);
+		addrconf_ifdown(dev, event == NETDEV_UNREGISTER);
 		break;
 	case NETDEV_CHANGE:
 		break;
