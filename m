Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbTAHQNU>; Wed, 8 Jan 2003 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTAHQNU>; Wed, 8 Jan 2003 11:13:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27329 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265085AbTAHQNS>;
	Wed, 8 Jan 2003 11:13:18 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: kiran@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IPV6]: Convert mibstats to use kmalloc_percpu
Date: Wed, 8 Jan 2003 17:18:37 +0100
User-Agent: KMail/1.4.3
Organization: IBM Deutschland Entwicklung GmbH
Cc: Trivial Patches <trivial@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301081718.37263.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1.879.9.7 from kiran@in.ibm.com contains:

> @@ -765,6 +847,7 @@
>  #ifdef CONFIG_SYSCTL
>         ipv6_sysctl_unregister();       
>  #endif
> +       cleanup_ipv6_mibs();
>  }
>  module_exit(inet6_exit);
>  #endif /* MODULE */

This does not work when cleanup_ipv6_mibs() is marked __exit,
the fix below is needed to build a kernel with ipv6.

===== net/ipv6/af_inet6.c 1.18 vs edited =====
--- 1.18/net/ipv6/af_inet6.c	Tue Jan  7 11:19:42 2003
+++ edited/net/ipv6/af_inet6.c	Wed Jan  8 17:08:52 2003
@@ -684,7 +684,7 @@
 	
 }
 
-static void __exit cleanup_ipv6_mibs(void)
+static void cleanup_ipv6_mibs(void)
 {
 	kfree_percpu(ipv6_statistics[0]);
 	kfree_percpu(ipv6_statistics[1]);
