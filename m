Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTDIEzi (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTDIEzi (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:55:38 -0400
Received: from cs-ats40.donpac.ru ([217.107.128.161]:8964 "EHLO pazke")
	by vger.kernel.org with ESMTP id S262742AbTDIEzf (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 00:55:35 -0400
Date: Wed, 9 Apr 2003 09:07:11 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix visws breakage in 2.5.67
Message-ID: <20030409050711.GA24420@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

someone broke visws again :(

This patch fixes it by adding '#ifdef CONFIG_X86_IO_APIC'
around call to setup_ioapic_dest() in smp_cpus_done().

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-ioapic-2.5.67"

diff -urN -X /usr/share/dontdiff linux-2.5.67.vanilla/arch/i386/kernel/smpboot.c linux-2.5.67/arch/i386/kernel/smpboot.c
--- linux-2.5.67.vanilla/arch/i386/kernel/smpboot.c	Wed Apr  9 19:43:46 2003
+++ linux-2.5.67/arch/i386/kernel/smpboot.c	Wed Apr  9 19:16:46 2003
@@ -1155,7 +1155,9 @@
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest(TARGET_CPUS);
+#endif
 	zap_low_mappings();
 }
 

--fUYQa+Pmc3FrFX/N--
