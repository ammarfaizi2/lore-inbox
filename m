Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUFWNlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUFWNlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 09:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFWNlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 09:41:07 -0400
Received: from [203.178.140.15] ([203.178.140.15]:23560 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265206AbUFWNlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 09:41:01 -0400
Date: Wed, 23 Jun 2004 22:42:03 +0900 (JST)
Message-Id: <20040623.224203.122414746.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, clem@clem.clem-digital.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.7-bk6 fails module compile -- iptable_raw.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200406231256.IAA28505@clem.clem-digital.net>
References: <200406231256.IAA28505@clem.clem-digital.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200406231256.IAA28505@clem.clem-digital.net> (at Wed, 23 Jun 2004 08:56:08 -0400 (EDT)), Pete Clements <clem@clem.clem-digital.net> says:

> FYI:  (gcc version 2.95.4)
> 
>   CC [M]  net/ipv4/netfilter/iptable_raw.o
> net/ipv4/netfilter/iptable_raw.c:57: unknown field `target_size' specified in initializer
> net/ipv4/netfilter/iptable_raw.c:57: warning: missing braces around initializer
> net/ipv4/netfilter/iptable_raw.c:57: warning: (near initialization for `initial_table.entries[0].target.target.u')
> net/ipv4/netfilter/iptable_raw.c:71: unknown field `target_size' specified in initializer
> net/ipv4/netfilter/iptable_raw.c:85: unknown field `user' specified in initializer
> net/ipv4/netfilter/iptable_raw.c:87: unknown field `name' specified in initializer
> net/ipv4/netfilter/iptable_raw.c:87: warning: excess elements in union initializer
> net/ipv4/netfilter/iptable_raw.c:87: warning: (near initialization for `initial_table.term.target.target.u')
> make[3]: *** [net/ipv4/netfilter/iptable_raw.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2

Please try this.

===== net/ipv4/netfilter/iptable_raw.c 1.2 vs edited =====
--- 1.2/net/ipv4/netfilter/iptable_raw.c	2004-06-22 06:39:19 +09:00
+++ edited/net/ipv4/netfilter/iptable_raw.c	2004-06-23 22:35:44 +09:00
@@ -54,7 +54,9 @@
 		     },
 		     .target = { 
 			  .target = { 
-				  .u.target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
+				  .u = {
+					  .target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
+				  },
 			  },
 			  .verdict = -NF_ACCEPT - 1,
 		     },
@@ -68,7 +70,9 @@
 		     },
 		     .target = {
 			     .target = {
-				     .u.target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
+				     .u = {
+					     .target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
+				     },
 			     },
 			     .verdict = -NF_ACCEPT - 1,
 		     },
@@ -82,9 +86,11 @@
 		},
 		.target = {
 			.target = {
-				.u.user = {
-					.target_size = IPT_ALIGN(sizeof(struct ipt_error_target)), 
-					.name = IPT_ERROR_TARGET,
+				.u = {
+					.user = {
+						.target_size = IPT_ALIGN(sizeof(struct ipt_error_target)), 
+						.name = IPT_ERROR_TARGET,
+					},
 				},
 			},
 			.errorname = "ERROR",

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
