Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965647AbWIRKtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965647AbWIRKtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965648AbWIRKtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:49:22 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:18407 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965647AbWIRKtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:49:21 -0400
Date: Mon, 18 Sep 2006 12:51:05 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [-mm patch] AVR32: Fix exported headers
Message-ID: <20060918125105.4b3e88ba@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two problems with the headers exported for AVR32.

asm/user.h includes asm/processor.h, which isn't exported. It doesn't
seem to actually need anything from asm/processor.h, so the include can
be dropped. After this, the asm and asm-generic parts of headers_check
pass. There are still a few failures with non-AVR32 specific headers,
but I'm assuming they will be fixed separately.

strace needs asm/cachectl.h. Export it.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/Kbuild |    2 ++
 include/asm-avr32/user.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc6-mm2/include/asm-avr32/user.h
===================================================================
--- linux-2.6.18-rc6-mm2.orig/include/asm-avr32/user.h	2006-09-15 10:00:11.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/asm-avr32/user.h	2006-09-18 12:41:35.000000000 +0200
@@ -12,7 +12,6 @@
 #define __ASM_AVR32_USER_H
 
 #include <linux/types.h>
-#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
Index: linux-2.6.18-rc6-mm2/include/asm-avr32/Kbuild
===================================================================
--- linux-2.6.18-rc6-mm2.orig/include/asm-avr32/Kbuild	2006-09-18 12:34:46.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/asm-avr32/Kbuild	2006-09-18 12:34:54.000000000 +0200
@@ -1 +1,3 @@
 include include/asm-generic/Kbuild.asm
+
+headers-y	+= cachectl.h
