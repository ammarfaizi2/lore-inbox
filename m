Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVIMGe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVIMGe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIMGe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:34:27 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:25014 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S932370AbVIMGe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:34:26 -0400
Date: Tue, 13 Sep 2005 02:28:07 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: more fallout from ATI Xpress timer workaround (was: Linux
 2.6.14-rc1)
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0509130219330.9693@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

More fallout from the change mentioned above.

  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.init.text+0xd3a): In function 
`parse_cmdline_early':
: undefined reference to `disable_timer_pin_1'
arch/i386/kernel/built-in.o(.init.text+0xd3f): In function 
`parse_cmdline_early':
: undefined reference to `disable_timer_pin_1'
arch/i386/kernel/built-in.o(.init.text+0xd49): In function 
`parse_cmdline_early':
: undefined reference to `disable_timer_pin_1'
make: *** [.tmp_vmlinux1] Error 1

This gets the kernel built:

disable_timer_pin_1 needs IO-APIC, not just local APIC.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.14-rc1/arch/i386/kernel/setup.c~	2005-09-13 01:36:07.000000000 -0400
+++ linux-2.6.14-rc1/arch/i386/kernel/setup.c	2005-09-13 02:23:42.000000000 -0400
@@ -848,9 +848,7 @@
 #ifdef CONFIG_X86_IO_APIC
 		else if (!memcmp(from, "acpi_skip_timer_override", 24))
 			acpi_skip_timer_override = 1;
-#endif
 
-#ifdef CONFIG_X86_LOCAL_APIC
 		if (!memcmp(from, "disable_timer_pin_1", 19))
 			disable_timer_pin_1 = 1;
 		if (!memcmp(from, "enable_timer_pin_1", 18))
@@ -859,7 +857,7 @@
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
-#endif /* CONFIG_X86_LOCAL_APIC */
+#endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_X86_LOCAL_APIC

-- 
". . . tell 'em we use Linux." -- Dave Chappelle

