Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSKVPIj>; Fri, 22 Nov 2002 10:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSKVPIj>; Fri, 22 Nov 2002 10:08:39 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:10727 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264939AbSKVPIi>; Fri, 22 Nov 2002 10:08:38 -0500
Date: Fri, 22 Nov 2002 08:15:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND x 2] Don't ask about "Enhanced Real Time Clock Support" on some archs
Message-ID: <20021122151543.GO779@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds an explicit no list of arches who do not want
to have the "Enhanced Real Time Clock Support" RTC driver asked.  This
adds PPC32 (who for a long time had their own 'generic' RTC driver, and
then have adopted the genrtc driver) and PARISC (who have always used
the genrtc driver).

The problem is that on some archs there is no hope of this driver
working, and having it compiled into the kernel can cause many different
problems.  On the other hand, there are some arches for whom that driver
does work, on some platforms.  So having an explicit yes list would
result in some rather ugly statements.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/char/Kconfig 1.1 vs edited =====
--- 1.1/drivers/char/Kconfig	Tue Oct 29 18:16:55 2002
+++ edited/drivers/char/Kconfig	Wed Nov 13 07:56:39 2002
@@ -1053,6 +1053,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
+	depends on !PPC32 && !PARISC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
