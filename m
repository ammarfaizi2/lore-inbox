Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311925AbSDCO5S>; Wed, 3 Apr 2002 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311919AbSDCO5I>; Wed, 3 Apr 2002 09:57:08 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:8578 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S311884AbSDCO45>; Wed, 3 Apr 2002 09:56:57 -0500
Date: Wed, 3 Apr 2002 07:56:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] Don't always ask about Intel or AMD RNGs
Message-ID: <20020403145604.GB3840@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following patch hides the option for Intel (i8x0) RNG
support.  I suspect this is an ia32-only option, but since it's possible
that it's used on ia64 as well, this tests for both.  By similar logic,
the AMD (768) RNG support is only asked for on ia32 and x86-64.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/char/Config.in 1.19 vs edited =====
--- 1.19/drivers/char/Config.in	Fri Mar 29 07:49:29 2002
+++ edited/drivers/char/Config.in	Wed Apr  3 07:52:57 2002
@@ -217,8 +217,12 @@
    tristate 'NetWinder flash support' CONFIG_NWFLASH
 fi
 
-dep_tristate 'AMD 768 Random Number Generator support' CONFIG_AMD_RNG $CONFIG_PCI
-dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_X86_64" = "y" ]; then
+   dep_tristate 'AMD 768 Random Number Generator support' CONFIG_AMD_RNG $CONFIG_PCI
+fi
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
+   dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
+fi
 tristate '/dev/nvram support' CONFIG_NVRAM
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
