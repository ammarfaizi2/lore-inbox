Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161711AbWKHTT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161711AbWKHTT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161714AbWKHTT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:19:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161711AbWKHTT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:19:26 -0500
Date: Wed, 8 Nov 2006 11:19:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: "Hesse, Christian" <mail@earthworm.de>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108111907.a534f61d.akpm@osdl.org>
In-Reply-To: <200611081557.21516.m.kozlowski@tuxland.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611081332.36644.mail@earthworm.de>
	<200611081354.23671.m.kozlowski@tuxland.pl>
	<200611081557.21516.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 15:57:20 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

>   CC [M]  drivers/media/video/pwc/pwc-uncompress.o
> In file included from drivers/media/video/pwc/pwc-uncompress.c:29:
> include/asm/current.h: In function `get_current':
> include/asm/current.h:11: error: `size_t' undeclared (first use in this function)
> include/asm/current.h:11: error: (Each undeclared identifier is reported only once
> include/asm/current.h:11: error: for each function it appears in.)

Ah, you're i386, not x86_64.   This should help.


From: Andrew Morton <akpm@osdl.org>

i386's pda.h needs types.h for size_t (used by offsetof if gcc-3)

Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
Cc: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-i386/pda.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/asm-i386/current.h~fix-x86_64-mm-pda-current include/asm-i386/current.h
diff -puN include/asm-i386/pda.h~fix-x86_64-mm-pda-current include/asm-i386/pda.h
--- a/include/asm-i386/pda.h~fix-x86_64-mm-pda-current
+++ a/include/asm-i386/pda.h
@@ -7,6 +7,7 @@
 #define _I386_PDA_H
 
 #include <linux/stddef.h>
+#include <linux/types.h>
 
 struct i386_pda
 {
_

