Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSJOANW>; Mon, 14 Oct 2002 20:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJOANW>; Mon, 14 Oct 2002 20:13:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37798 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262184AbSJOANV>; Mon, 14 Oct 2002 20:13:21 -0400
Date: Mon, 14 Oct 2002 17:17:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [4/5]
Message-ID: <2004392754.1034615823@[10.10.2.3]>
In-Reply-To: <2001880782.1034613312@[10.10.2.3]>
References: <2001880782.1034613312@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just changes summit_check to be called mptable_machine_detect 
to keep people happy.

M.

diff -urpN -X /home/fletch/.diff.exclude subarch-5/arch/i386/kernel/mpparse.c subarch-6/arch/i386/kernel/mpparse.c
--- subarch-5/arch/i386/kernel/mpparse.c	Mon Oct 14 17:02:46 2002
+++ subarch-6/arch/i386/kernel/mpparse.c	Mon Oct 14 17:08:23 2002
@@ -394,7 +394,7 @@ static int __init smp_read_mpc(struct mp
 	str[12]=0;
 	printk("Product ID: %s ",str);
 
-	summit_check(oem, str);
+	mptable_machine_detect(oem, str);
 
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
diff -urpN -X /home/fletch/.diff.exclude subarch-5/arch/i386/mach-generic/mach_apic.h subarch-6/arch/i386/mach-generic/mach_apic.h
--- subarch-5/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 17:02:46 2002
+++ subarch-6/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 17:09:00 2002
@@ -20,7
+20,7 @@ static inline unsigned long calculate_ld
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
-static inline void summit_check(char *oem, char *productid) 
+static inline void mptable_machine_detect(char *oem, char *productid) 
 {
 }
 
diff -urpN -X /home/fletch/.diff.exclude subarch-5/arch/i386/mach-summit/mach_apic.h subarch-6/arch/i386/mach-summit/mach_apic.h
--- subarch-5/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 17:02:46 2002
+++ subarch-6/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 17:09:19 2002
@@ -26,7 +26,7 @@ static inline unsigned long calculate_ld
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
-static inline void
summit_check(char *oem, char *productid)
+static inline void mptable_machine_detect(char *oem, char *productid)
 {
 	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
 		x86_summit = 1;

