Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSCMRuA>; Wed, 13 Mar 2002 12:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310937AbSCMRtu>; Wed, 13 Mar 2002 12:49:50 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:52667 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310917AbSCMRto>; Wed, 13 Mar 2002 12:49:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 09:49:36 -0800
Message-Id: <200203131749.JAA00556@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Patch: linux-2.5.7-pre1/net/ipv4/ipmr.c did not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It looks like sk->num became inet_sk(sk)->num in 2.5.7-pre1,
but one of these changes was missed in net/ipv4/ipmr.c.  Here is
the patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.5.7-pre1/net/ipv4/ipmr.c	Thu Mar  7 18:18:31 2002
+++ linux/net/ipv4/ipmr.c	Wed Mar 13 07:27:45 2002
@@ -855,7 +855,8 @@
 	switch(optname)
 	{
 		case MRT_INIT:
-			if(sk->type!=SOCK_RAW || sk->num!=IPPROTO_IGMP)
+			if(sk->type!=SOCK_RAW ||
+			   inet_sk(sk)->num!=IPPROTO_IGMP)
 				return -EOPNOTSUPP;
 			if(optlen!=sizeof(int))
 				return -ENOPROTOOPT;
