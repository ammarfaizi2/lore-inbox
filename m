Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTAGUbh>; Tue, 7 Jan 2003 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGUbg>; Tue, 7 Jan 2003 15:31:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30413 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267497AbTAGUbU>; Tue, 7 Jan 2003 15:31:20 -0500
Date: Tue, 07 Jan 2003 12:17:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/7) create generalised apic_to_node mapping
Message-ID: <593020000.1041970628@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/mach_apic.h 01-apicid_to_node/include/asm-i386/mach-default/mach_apic.h
--- 00-virgin/include/asm-i386/mach-default/mach_apic.h	Thu Jan  2 22:05:15 2003
+++ 01-apicid_to_node/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:24:35 2003
@@ -53,6 +53,11 @@ static inline int multi_timer_check(int
 	return 0;
 }

+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	return  mps_cpu;
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-numaq/mach_apic.h 01-apicid_to_node/include/asm-i386/mach-numaq/mach_apic.h
--- 00-virgin/include/asm-i386/mach-numaq/mach_apic.h	Thu Jan  2 22:05:15 2003
+++ 01-apicid_to_node/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:24:35 2003
@@ -47,14 +47,14 @@ static inline int generate_logical_apici
 	return ( (quad << 4) + (phys_apicid ? phys_apicid << 1 : 1) );
 }

-static inline int apicid_to_quad(int logical_apicid)
+static inline int apicid_to_node(int logical_apicid)
 {
 	return (logical_apicid >> 4);
 }

 static inline unsigned long apicid_to_cpu_present(int logical_apicid)
 {
-	return ( (logical_apicid&0xf) << (4*apicid_to_quad(logical_apicid)) );
+	return ( (logical_apicid&0xf) << (4*apicid_to_node(logical_apicid)) );
 }

 static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-summit/mach_apic.h 01-apicid_to_node/include/asm-i386/mach-summit/mach_apic.h
--- 00-virgin/include/asm-i386/mach-summit/mach_apic.h	Thu Jan  2 22:05:15 2003
+++ 01-apicid_to_node/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:24:35 2003
@@ -32,6 +32,11 @@ static inline void clustered_apic_check(
 		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
 }

+static inline int apicid_to_node(int logical_apicid)
+{
+	return (logical_apicid >> 5);          /* 2 clusterids per CEC */
+}
+
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if (x86_summit)

