Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285937AbRLTDZD>; Wed, 19 Dec 2001 22:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285946AbRLTDYs>; Wed, 19 Dec 2001 22:24:48 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:23562 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S285937AbRLTDYe>; Wed, 19 Dec 2001 22:24:34 -0500
Date: Wed, 19 Dec 2001 20:24:30 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tossati <marcelo@conectiva.com.br>
Subject: [PATCH] Alpha-Nautilus compilation fix for 2.4.17rc2
Message-ID: <20011219202430.A8610@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To compile 2.4.17rc2 sources on Alpha not "generic" but Nautilus-specic,
or for any other Alpha type where Irongate chipset is used, the
following obvious patch is required:

--- linux-2.4.17rc/arch/alpha/kernel/alpha_ksyms.c.orig	Tue Nov 20 16:49:31 2001
+++ linux-2.4.17rc/arch/alpha/kernel/alpha_ksyms.c	Wed Dec 19 19:21:02 2001
@@ -258,3 +258,8 @@
 EXPORT_SYMBOL_NOVERS(memchr);
 
 EXPORT_SYMBOL(get_wchan);
+
+#ifdef CONFIG_ALPHA_IRONGATE
+EXPORT_SYMBOL(irongate_ioremap);
+EXPORT_SYMBOL(irongate_iounmap);
+#endif

Without it assorted modules will be really unhappy with depmod spilling
"unresolved symbols".

Actually the same patch applies to at least 2.4.16 and possibly earlier
kernels.  With "generic" kernel configuration 'ioremap' and 'iounmap'
are not redefined in headers to their "irongate" variants and problem
does not occur.

   Michal
   michal@harddata.com
