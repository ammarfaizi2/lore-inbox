Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSCMCTd>; Tue, 12 Mar 2002 21:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292045AbSCMCTY>; Tue, 12 Mar 2002 21:19:24 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:16134 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S292035AbSCMCTN>;
	Tue, 12 Mar 2002 21:19:13 -0500
Date: Tue, 12 Mar 2002 21:04:13 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>, <fdavis@si.rr.com>
Subject: [PATCH] 2.5.7-pre1: net/ipv4/ipmr.c
Message-ID: <Pine.LNX.4.33.0203122102100.12006-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch fixes following compile error:
ipmr.c: In function `ip_mroute_setsockopt':
ipmr.c:858: structure has no member named `num'
make[3]: *** [ipmr.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2

--- net/ipv4/ipmr.c.old	Sun Feb  3 19:55:14 2002
+++ net/ipv4/ipmr.c	Tue Mar 12 20:59:44 2002
@@ -855,7 +855,7 @@
 	switch(optname)
 	{
 		case MRT_INIT:
-			if(sk->type!=SOCK_RAW || sk->num!=IPPROTO_IGMP)
+			if(sk->type!=SOCK_RAW || inet_sk(sk)->num!=IPPROTO_IGMP)
 				return -EOPNOTSUPP;
 			if(optlen!=sizeof(int))
 				return -ENOPROTOOPT;

