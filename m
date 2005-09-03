Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVICMs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVICMs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 08:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVICMs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 08:48:26 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:43787 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751143AbVICMs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 08:48:26 -0400
Date: Sat, 03 Sep 2005 21:49:43 +0900 (JST)
Message-Id: <20050903.214943.64835619.yoshfuji@linux-ipv6.org>
To: rmk+lkml@arm.linux.org.uk, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: 2.6.13-git3: build failure: sysctl_optmem_max
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050903112756.D29708@flint.arm.linux.org.uk>
References: <20050903112756.D29708@flint.arm.linux.org.uk>
Organization: USAGI/WIDE Project
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

In article <20050903112756.D29708@flint.arm.linux.org.uk> (at Sat, 3 Sep 2005 11:27:56 +0100), Russell King <rmk+lkml@arm.linux.org.uk> says:

> While trying to build a kernel with CONFIG_SYSCTL disabled, the following
> error occurs:
> 
>   CC      net/ipv4/ip_sockglue.o
> net/ipv4/ip_sockglue.c: In function `ip_setsockopt':
> net/ipv4/ip_sockglue.c:622: error: `sysctl_optmem_max' undeclared (first use in
> net/ipv4/ip_sockglue.c:622: error: (Each undeclared identifier is reported only
> net/ipv4/ip_sockglue.c:622: error: for each function it appears in.)
> 
> It seems that sysctl_optmem_max is only available if CONFIG_SYSCTL is set.
> However, ip_setsockopt makes unconditional usage of this variable.

This should fix the issue.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1374,8 +1374,8 @@ extern void sk_init(void);
 
 #ifdef CONFIG_SYSCTL
 extern struct ctl_table core_table[];
-extern int sysctl_optmem_max;
 #endif
+extern int sysctl_optmem_max;
 
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
diff --git a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1719,8 +1719,8 @@ EXPORT_SYMBOL(sock_wfree);
 EXPORT_SYMBOL(sock_wmalloc);
 EXPORT_SYMBOL(sock_i_uid);
 EXPORT_SYMBOL(sock_i_ino);
-#ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_optmem_max);
+#ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_rmem_max);
 EXPORT_SYMBOL(sysctl_wmem_max);
 #endif

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
