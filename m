Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263261AbSJCNWA>; Thu, 3 Oct 2002 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263271AbSJCNWA>; Thu, 3 Oct 2002 09:22:00 -0400
Received: from web9604.mail.yahoo.com ([216.136.129.183]:64916 "HELO
	web9604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263261AbSJCNV7>; Thu, 3 Oct 2002 09:21:59 -0400
Message-ID: <20021003132727.70505.qmail@web9604.mail.yahoo.com>
Date: Thu, 3 Oct 2002 06:27:27 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] 2.4.18 IPV6_ADDRFORM
To: linux-kernel@vger.kernel.org, davem@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch is created against 2.4.18 (but
2.4.19 seems very close). It adds support for
IPV6_ADDRFORM getsockopt. I sent a patch earlier
deleting IPV6_ADDRFORM from 2.5, but since 2.4 has
IPV6_ADDRFORM defined (and its shipped), it should be
supported rather than deleted.

Cheers,
Steve Grubb

-------

diff -ur linux-2.4.18/net/ipv6/ipv6_sockglue.c
linux-2.4.18a/net/ipv6/ipv6_sockglue.c
--- linux-2.4.18/net/ipv6/ipv6_sockglue.c	Thu Sep 20
17:12:56 2001
+++ linux-2.4.18a/net/ipv6/ipv6_sockglue.c	Thu Oct  3
09:23:55 2002
@@ -412,6 +412,16 @@
 	if (get_user(len, optlen))
 		return -EFAULT;
 	switch (optname) {
+	case IPV6_ADDRFORM:
+		if (sk->protocol != IPPROTO_UDP &&
+                    sk->protocol != IPPROTO_TCP)
+			return -EINVAL;
+
+		if (sk->state != TCP_ESTABLISHED) 
+			return -ENOTCONN;
+					 
+		val = sk->family;	
+		break;
 	case IPV6_PKTOPTIONS:
 	{
 		struct msghdr msg;


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
