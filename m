Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSIAHpC>; Sun, 1 Sep 2002 03:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSIAHpC>; Sun, 1 Sep 2002 03:45:02 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:1029 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S316538AbSIAHpC>;
	Sun, 1 Sep 2002 03:45:02 -0400
Date: 1 Sep 2002 07:49:25 -0000
Message-ID: <20020901074925.6153.qmail@legolas.dynup.net>
From: rudmer@legolas.dynup.net
To: rusty@rustcorp.com.au
Subject: [PATCH] fix __FUNCTION__ use in ip_nat_helper.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got the following errors:

  CC     net/ipv4/netfilter/ip_nat_helper.o
ip_nat_helper.c: In function `ip_nat_helper_register':
ip_nat_helper.c:385: parse error before string constant
ip_nat_helper.c: In function `ip_nat_helper_unregister':
ip_nat_helper.c:470: parse error before string constant
ip_nat_helper.c:471: warning: left-hand operand of comma expression has no effect
ip_nat_helper.c:471: parse error before `)'
make[3]: *** [ip_nat_helper.o] Error 1
make[2]: *** [netfilter] Error 2
make[1]: *** [ipv4] Error 2
make: *** [net] Error 2

both due to bad use of __FUNCTION__ patch follows

	Rudmer

--- linux-2.5.33/net/ipv4/netfilter/ip_nat_helper.c.orig	Sun Sep  1 09:23:54 2002
+++ linux-2.5.33/net/ipv4/netfilter/ip_nat_helper.c	Sun Sep  1 09:28:13 2002
@@ -382,9 +382,9 @@
 			const char *tmp = me->me->name;
 			
 			if (strlen(tmp) + 6 > MODULE_MAX_NAMELEN) {
-				printk(__FUNCTION__ ": unable to "
+				printk("%s: unable to "
 				       "compute conntrack helper name "
-				       "from %s\n", tmp);
+				       "from %s\n", __FUNCTION__, tmp);
 				return -EBUSY;
 			}
 			tmp += 6;
@@ -467,7 +467,8 @@
 		    && ct_helper->me) {
 			__MOD_DEC_USE_COUNT(ct_helper->me);
 		} else 
-			printk(__FUNCTION__ ": unable to decrement usage count"
-			       " of conntrack helper %s\n", me->me->name);
+			printk("%s: unable to decrement usage count"
+			       " of conntrack helper %s\n",
+			       __FUNCTION__, me->me->name);
 	}
 }
