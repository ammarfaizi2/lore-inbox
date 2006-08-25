Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWHYScE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWHYScE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWHYS3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:29:13 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19121 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422791AbWHYS2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:28:51 -0400
Date: Sat, 26 Aug 2006 03:28:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: another NUMA build error
Message-Id: <20060826032834.ead83dec.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060825103507.4f2d193e.rdunlap@xenotime.net>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825103507.4f2d193e.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 10:35:07 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> OK, I prefer option 2 because it is more generic (not hardware-
> specific).  Someone else can prefer option 1 because it is
> hardware-specific.  :)
> 
ok. patch is here. but people who know x86-numa should confirm this.

-Kame
--
compile fix for

In file included from include/asm/mmzone.h:18,
                 from include/linux/mmzone.h:439,
<snip>
include/asm/srat.h:31:2: error: #error CONFIG_ACPI_SRAT not defined, and srat.h header has been included
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1

This can happen with CONFIG_NUMA && !CONFIG_ACPI && !CONFIG_X86_NUMAQ

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/asm-i386/mmzone.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc4/include/asm-i386/mmzone.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-i386/mmzone.h
+++ linux-2.6.18-rc4/include/asm-i386/mmzone.h
@@ -14,7 +14,7 @@ extern struct pglist_data *node_data[];
 
 #ifdef CONFIG_X86_NUMAQ
 	#include <asm/numaq.h>
-#else	/* summit or generic arch */
+#elif defined(CONFIG_ACPI_SRAT)/* summit or generic arch */
 	#include <asm/srat.h>
 #endif
 

