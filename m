Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288957AbSAISWq>; Wed, 9 Jan 2002 13:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288961AbSAISWi>; Wed, 9 Jan 2002 13:22:38 -0500
Received: from fysh.org ([212.47.68.126]:32522 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S288957AbSAISW0>;
	Wed, 9 Jan 2002 13:22:26 -0500
Date: Wed, 9 Jan 2002 18:22:24 +0000
From: Athanasius <Athanasius@gurus.tf>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Athlon XP 1600+ and _mmx_memcpy symbol in modules
Message-ID: <20020109182224.GI15688@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just upraded from my old PII-400 system to an Athlon XP 1600+
based system so changed from "Pentium-Pro/Celeron/Pentium-II"
(CONFIG_M686) to "Athlon/Duron/K7" (CONFIG_MK7).  In doing so I suddenly
saw a LOT of problems with modules and the symbol _mmx_memcpy being
undefined.

  I finally kludged/fixed this by changing line 121 of
arch/i386/kernel/i386_ksyms.c from:

EXPORT_SYMBOL(_mmx_memcpy);

into:

EXPORT_SYMBOL_NOVERS(_mmx_memcpy);

That's on a vanilla 2.4.17 source tree.

Patch:

--- linux-2.4.17/arch/i386/kernel/i386_ksyms.c  Tue Nov 13 17:13:20 2001
+++ linux-2.4.17-athlon/arch/i386/kernel/i386_ksyms.c   Wed Jan  9 17:32:19 2002
@@ -118,7 +118,7 @@
 #endif
 
 #ifdef CONFIG_X86_USE_3DNOW
-EXPORT_SYMBOL(_mmx_memcpy);
+EXPORT_SYMBOL_NOVERS(_mmx_memcpy);
 EXPORT_SYMBOL(mmx_clear_page);
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
-- 
- Athanasius = Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
