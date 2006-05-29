Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWE2Xpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWE2Xpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWE2Xpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:45:45 -0400
Received: from xenotime.net ([66.160.160.81]:63667 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751258AbWE2Xpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:45:45 -0400
Date: Mon, 29 May 2006 16:48:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: earny@net4u.de, akpm <akpm@osdl.org>
Cc: list-lkml@net4u.de, linux-kernel@vger.kernel.org, rth@twiddle.net,
       mita@miraclelinux.com
Subject: [PATCH] alpha: generic hweight (Re: ALPHA 2.6.17-rc5 compile error)
Message-Id: <20060529164822.c16cfe43.rdunlap@xenotime.net>
In-Reply-To: <200605291848.58756.list-lkml@net4u.de>
References: <200605291848.58756.list-lkml@net4u.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 18:48:58 +0200 Ernst Herzberg wrote:

> moin.
> 
> 2.6.16.18 works fine.
> 
> 2.6.17-rc5 bails out with
> 
> [.....]
>   LD      net/ipv4/built-in.o
>   LD      net/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> lib/lib.a(bitmap.o): In function `__bitmap_weight':
> : undefined reference to `hweight64'
> lib/lib.a(bitmap.o): In function `__bitmap_weight':
> : undefined reference to `hweight64'
> lib/lib.a(bitmap.o): In function `__bitmap_weight':
> : undefined reference to `hweight64'
> lib/lib.a(bitmap.o): In function `__bitmap_weight':
> : undefined reference to `hweight64'
> drivers/built-in.o: In function `pcips2_interrupt':
> : undefined reference to `hweight8'
> drivers/built-in.o: In function `pcips2_interrupt':
> : undefined reference to `hweight8'
> net/built-in.o: In function `netlink_bind':
> : undefined reference to `hweight32'
> net/built-in.o: In function `netlink_bind':
> : undefined reference to `hweight32'
> net/built-in.o: In function `netlink_bind':
> : undefined reference to `hweight32'
> net/built-in.o: In function `netlink_bind':
> : undefined reference to `hweight32'
> make: *** [.tmp_vmlinux1] Error 1

Please try the patch below.

From: Randy Dunlap <rdunlap@xenotime.net>

According to include/asm-alpha/bitops.h, only ALPHA_EV67 has
hardware hweight support, so ALPHA_EV6 needs to use GENERIC_HWEIGHT.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/alpha/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc5.orig/arch/alpha/Kconfig
+++ linux-2617-rc5/arch/alpha/Kconfig
@@ -453,7 +453,7 @@ config ALPHA_IRONGATE
 
 config GENERIC_HWEIGHT
 	bool
-	default y if !ALPHA_EV6 && !ALPHA_EV67
+	default y if !ALPHA_EV67
 
 config ALPHA_AVANTI
 	bool
