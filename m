Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSHZGAj>; Mon, 26 Aug 2002 02:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSHZGAj>; Mon, 26 Aug 2002 02:00:39 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:51073 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317833AbSHZGAi>; Mon, 26 Aug 2002 02:00:38 -0400
Date: Mon, 26 Aug 2002 08:21:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] focus processor bit reserved on P4
Message-ID: <Pine.LNX.4.44.0208260813530.10068-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is just to comply with the recommendations as stated on p304 of 
vol3 ie reserved bit should be cleared.

Index: linux-2.5.31/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.31/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.31/arch/i386/kernel/apic.c	24 Aug 2002 21:05:08 -0000	1.1.1.1
+++ linux-2.5.31/arch/i386/kernel/apic.c	25 Aug 2002 21:05:06 -0000
@@ -258,7 +258,10 @@
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_VECTOR_MASK;
 	value |= APIC_SPIV_APIC_ENABLED;
-	value |= APIC_SPIV_FOCUS_DISABLED;
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 15))
+		value &= ~APIC_SPIV_FOCUS_DISABLED;
+	else
+		value |= APIC_SPIV_FOCUS_DISABLED;
 	value |= SPURIOUS_APIC_VECTOR;
 	apic_write_around(APIC_SPIV, value);
 

-- 
function.linuxpower.ca

