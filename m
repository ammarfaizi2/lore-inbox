Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVHQJyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVHQJyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVHQJyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:54:25 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:47250 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id S1751028AbVHQJyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:54:24 -0400
Message-ID: <20050817095423.625.qmail@thales.mathematik.uni-ulm.de>
Date: Wed, 17 Aug 2005 11:54:23 +0200
From: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Undefined behaviour with get_cpu_vendor
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Your Patch at (URL wrapped)

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; \
		a=commit;h=99c6e60afff8a7bc6121aeb847dab27c556cf0c9

introduced an additional Parameter (int early) to get_cpu_vendor.
However, the same function is called in arch/i386/kernel/apic.c (via
an explicit extern declaration that doesn't have the new early parameter.

I don't know if this can cause actual problems but I think something like
the patch below is needed for correctness.

   regards    Christian

--- arch/i386/kernel/apic.c     2005-03-26 04:28:38.000000000 +0100
+++ arch/i386/kernel/apic.c.new 2005-08-17 11:54:48.070499352 +0200
@@ -703,14 +703,14 @@
 static int __init detect_init_APIC (void)
 {
        u32 h, l, features;
-       extern void get_cpu_vendor(struct cpuinfo_x86*);
+       extern void get_cpu_vendor(struct cpuinfo_x86*, int);
 
        /* Disabled by kernel option? */
        if (enable_local_apic < 0)
                return -1;
 
        /* Workaround for us being called before identify_cpu(). */
-       get_cpu_vendor(&boot_cpu_data);
+       get_cpu_vendor(&boot_cpu_data, 1);
 
        switch (boot_cpu_data.x86_vendor) {
        case X86_VENDOR_AMD:


-- 
THAT'S ALL FOLKS!
