Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbTFSLQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbTFSLQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:16:38 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:29111 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S265767AbTFSLQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:16:37 -0400
From: Matthias Juchem <lists@konfido.de>
To: netfilter-devel@lists.netfilter.org
Subject: [PATCH 2.4] Trivial: kill __FUNCTION__ warnings in ip_nat_helper.c
Date: Thu, 19 Jun 2003 13:30:09 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306191326.09187.lists@konfido.de>
Reply-To: Matthias Juchem <lists@konfido.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

The attached patch kills two warnings (produced by gcc 3.3):

ip_nat_helper.c:493: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
ip_nat_helper.c:577: warning: concatenation of string literals with 
__FUNCTION__ is deprecated

Diff is against 2.4.21.

Regards,
 Matthias

diff -urN linux-2.4.21-vanilla/net/ipv4/netfilter/ip_nat_helper.c 
linux-2.4.21/net/ipv4/netfilter/ip_nat_helper.c
--- linux-2.4.21-vanilla/net/ipv4/netfilter/ip_nat_helper.c     2003-06-19 
11:53:43.000000000 +0200
+++ linux-2.4.21/net/ipv4/netfilter/ip_nat_helper.c     2003-06-19 
12:37:26.000000000 +0200
@@ -488,9 +488,9 @@
                        const char *tmp = me->me->name;

                        if (strlen(tmp) + 6 > MODULE_MAX_NAMELEN) {
-                               printk(__FUNCTION__ ": unable to "
-                                      "compute conntrack helper name "
-                                      "from %s\n", tmp);
+                               printk("%s: unable to compute conntrack "
+                                      "helper name from %s\n",
+                                      __FUNCTION__, tmp);
                                return -EBUSY;
                        }
                        tmp += 6;
@@ -573,7 +573,8 @@
                    && ct_helper->me) {
                        __MOD_DEC_USE_COUNT(ct_helper->me);
                } else
-                       printk(__FUNCTION__ ": unable to decrement usage 
count"
-                              " of conntrack helper %s\n", me->me->name);
+                       printk("%s: unable to decrement usage count of "
+                              "conntrack helper %s\n",
+                              __FUNCTION__, me->me->name);
        }
 }

