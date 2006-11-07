Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754075AbWKGGam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbWKGGam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbWKGGam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:30:42 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:33683 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1754075AbWKGGal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:30:41 -0500
Subject: [PATCH 1/1] mspec driver: tighten Kconfig dependencies
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: jes@sgi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 07 Nov 2006 15:30:40 +0900
Message-Id: <1162881040.13700.106.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mspec driver needs bte_copy (a sn-specific function) as well as some
functions of the uncached page allocator, but these dependencies are not
reflected in Kconfig which leads to compile errors with certain
configurations.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.19-rc4-orig/drivers/char/Kconfig
linux-2.6.19-rc4/drivers/char/Kconfig
--- linux-2.6.19-rc4-orig/drivers/char/Kconfig  2006-11-07
14:02:31.000000000 +0900
+++ linux-2.6.19-rc4/drivers/char/Kconfig       2006-11-07
14:59:33.000000000 +0900
@@ -411,7 +411,8 @@ config SGI_MBCS

 config MSPEC
        tristate "Memory special operations driver"
-       depends on IA64
+       depends on IA64 && (IA64_GENERIC || IA64_SGI_SN2)
+       select IA64_UNCACHED_ALLOCATOR
        help
          If you have an ia64 and you want to enable memory special
          operations support (formerly known as fetchop), say Y here,


