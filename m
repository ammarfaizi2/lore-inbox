Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUFRRRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUFRRRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUFRRRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:17:35 -0400
Received: from [203.178.140.15] ([203.178.140.15]:58117 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265467AbUFRRRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:17:23 -0400
Date: Sat, 19 Jun 2004 02:18:18 +0900 (JST)
Message-Id: <20040619.021818.04202102.yoshfuji@linux-ipv6.org>
To: kalin@ThinRope.net
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, yoshfuji@linux-ipv6.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <40D31EA6.5030207@ThinRope.net>
References: <40D313DC.7000202@blue-labs.org>
	<200406181721.47968.andrew@walrond.org>
	<40D31EA6.5030207@ThinRope.net>
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

In article <40D31EA6.5030207@ThinRope.net> (at Sat, 19 Jun 2004 01:56:06 +0900), Kalin KOZHUHAROV <kalin@ThinRope.net> says:

> Yes, I confirm with linux-2.6.7 and iptables-1.2.9 I got:
> gcc -march=athlon-xp -m3dnow -msse -mfpmath=sse -mmmx -O3 -pipe -Iinclude -Wall -Wunused -I/usr/src/linux/include  -DIPTABLES_VERSION=\"1.2.9\"  -fPIC -o extensions/libipt_stealth_sh.o -c extensions/libipt_stealth.c
> distcc[6323] ERROR: compile on localhost failed
> In file included from include/libiptc/libiptc.h:6,
>                  from include/iptables.h:5,
>                  from extensions/libipt_stealth.c:10:
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:255: warning: no semicolon at end of struct or union
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:255: error: syntax error before '*' token
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:259: error: syntax error before '}' token
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: type defaults to `int' in declaration of `DECLARE_MUTEX'
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: parameter names (without types) in function declaration
> /usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: `DECLARE_MUTEX' declared `static' but never defined
> make: *** [extensions/libipt_stealth_sh.o] Error 1
> 
> Last time I recompiled it with 2.6.6 it was ok. The compiled version still seems to work with 2.6.7 for now.

Please try this. Thanks

===== include/linux/netfilter.h 1.9 vs edited =====
--- 1.9/include/linux/netfilter.h	2004-06-07 12:15:03 +09:00
+++ edited/include/linux/netfilter.h	2004-06-19 02:10:55 +09:00
@@ -10,6 +10,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #endif
+#include <linux/compiler.h>
 
 /* Responses from hook functions. */
 #define NF_DROP 0
===== include/linux/netfilter_arp/arp_tables.h 1.3 vs edited =====
--- 1.3/include/linux/netfilter_arp/arp_tables.h	2004-06-04 09:52:00 +09:00
+++ edited/include/linux/netfilter_arp/arp_tables.h	2004-06-19 02:08:09 +09:00
@@ -16,7 +16,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #endif
-
+#include <linux/compiler.h>
 #include <linux/netfilter_arp.h>
 
 #define ARPT_FUNCTION_MAXNAMELEN 30
===== include/linux/netfilter_ipv4/ip_tables.h 1.7 vs edited =====
--- 1.7/include/linux/netfilter_ipv4/ip_tables.h	2004-06-07 12:15:03 +09:00
+++ edited/include/linux/netfilter_ipv4/ip_tables.h	2004-06-19 02:08:39 +09:00
@@ -22,6 +22,7 @@
 #include <linux/ip.h>
 #include <linux/skbuff.h>
 #endif
+#include <linux/compiler.h>
 #include <linux/netfilter_ipv4.h>
 
 #define IPT_FUNCTION_MAXNAMELEN 30
@@ -336,8 +337,8 @@
 /*
  *	Main firewall chains definitions and global var's definitions.
  */
-static DECLARE_MUTEX(ipt_mutex);
 #ifdef __KERNEL__
+static DECLARE_MUTEX(ipt_mutex);
 
 #include <linux/init.h>
 extern void ipt_init(void) __init;
===== include/linux/netfilter_ipv6/ip6_tables.h 1.6 vs edited =====
--- 1.6/include/linux/netfilter_ipv6/ip6_tables.h	2004-06-07 12:15:04 +09:00
+++ edited/include/linux/netfilter_ipv6/ip6_tables.h	2004-06-19 02:09:29 +09:00
@@ -22,6 +22,7 @@
 #include <linux/ipv6.h>
 #include <linux/skbuff.h>
 #endif
+#include <linux/compiler.h>
 #include <linux/netfilter_ipv6.h>
 
 #define IP6T_FUNCTION_MAXNAMELEN 30
@@ -106,7 +107,9 @@
 	u_int64_t pcnt, bcnt;			/* Packet and byte counters */
 };
 
+#ifdef __KERNEL__
 static DECLARE_MUTEX(ip6t_mutex);
+#endif
 
 /* Values for "flag" field in struct ip6t_ip6 (general ip6 structure). */
 #define IP6T_F_PROTO		0x01	/* Set if rule cares about upper 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
