Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGYQu1>; Thu, 25 Jul 2002 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGYQu1>; Thu, 25 Jul 2002 12:50:27 -0400
Received: from RAS23-045.gwdg.de ([134.76.23.45]:37541 "EHLO macavity")
	by vger.kernel.org with ESMTP id <S315442AbSGYQu0>;
	Thu, 25 Jul 2002 12:50:26 -0400
Date: Thu, 25 Jul 2002 18:51:59 +0200
From: Martin Uecker <muecker@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@debian.org>
Subject: 2.4.18: symbol versioning error (patch)
Message-ID: <20020725165159.GA4887@macavity>
Mail-Followup-To: Martin Uecker <muecker@gmx.de>,
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

if "sock.h" is not included, the versioned symbols
for "sk_run_filter" and "sk_chk_filter" are not created
correctly.

(kernel version: 2.4.18 (with debian patches))


--- net/netsyms.c.old	Thu Jul 25 17:46:31 2002
+++ net/netsyms.c	Thu Jul 25 17:59:31 2002
@@ -82,7 +82,7 @@
 extern void destroy_8023_client(struct datalink_proto *);
 #endif
 
-#ifdef CONFIG_ATALK_MODULE
+#if defined(CONFIG_ATALK_MODULE) || defined(CONFIG_FILTER)
 #include <net/sock.h>
 #endif
 
