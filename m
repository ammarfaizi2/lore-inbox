Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDEQlq>; Fri, 5 Apr 2002 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313074AbSDEQlh>; Fri, 5 Apr 2002 11:41:37 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:59543 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313075AbSDEQlU>; Fri, 5 Apr 2002 11:41:20 -0500
Date: Fri, 5 Apr 2002 18:40:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Chris Wilson <chris@jakdaw.org>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: P4/i845 Strange clock drifting
In-Reply-To: <20020405160146.34075997.chris@jakdaw.org>
Message-ID: <Pine.GSO.3.96.1020405183405.25048E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Chris Wilson wrote:

> No local APIC present or hardware disabled

 Thanks for the report.  According to docs the following patch should
help.  Not tested at all but trivial enough to work out of the box.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.18-p4-upapic-0
diff -up --recursive --new-file linux-2.4.18.macro/arch/i386/kernel/apic.c linux-2.4.18/arch/i386/kernel/apic.c
--- linux-2.4.18.macro/arch/i386/kernel/apic.c	2002-03-01 14:48:39.000000000 +0000
+++ linux-2.4.18/arch/i386/kernel/apic.c	2002-04-05 16:38:11.000000000 +0000
@@ -598,7 +598,7 @@ static int __init detect_init_APIC (void
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+		    boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -610,7 +610,8 @@ static int __init detect_init_APIC (void
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 and AMD K7 (Model > 1).
+		 * software for Intel P6, Intel P4 and AMD K7
+		 * (Model > 1).
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {

