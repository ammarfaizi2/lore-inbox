Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278236AbRJML4Q>; Sat, 13 Oct 2001 07:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJML4H>; Sat, 13 Oct 2001 07:56:07 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:6022 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S276857AbRJMLzw>; Sat, 13 Oct 2001 07:55:52 -0400
Date: Sat, 13 Oct 2001 12:57:33 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Pentium IV cacheline size.
Message-ID: <20011013125733.A10917@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we're using a L1_CACHE_SHIFT value of 7
for Pentium 4, which equates to 128 byte cache lines.
Curious, I dumped the info on the only P4 I could find,
and noticed they were 64 byte.
Upon checking the documentation, they're 64 byte there too. 
Is this just a thinko on someones part, or was there a
rationale behind this that I've not realised ?

If it is wrong, patch below sets it back to 64 bytes.

regards,

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/config.in linux-dj/arch/i386/config.in
--- linux/arch/i386/config.in	Fri Oct 12 16:29:57 2001
+++ linux-dj/arch/i386/config.in	Sat Oct 13 12:40:19 2001
@@ -108,7 +108,7 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
