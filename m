Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTFRI4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265120AbTFRI4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:56:34 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8464 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265116AbTFRI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:56:32 -0400
Date: Wed, 18 Jun 2003 02:11:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 x86-generic missing enable_apic_mode()
Message-Id: <20030618021116.2321e632.akpm@digeo.com>
In-Reply-To: <20030618084452.GD23037@wotan.suse.de>
References: <200306180827.h5I8Rtl27217@freya.yggdrasil.com>
	<20030618084452.GD23037@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 09:10:29.0507 (UTC) FILETIME=[76B00D30:01C33579]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> It should be enough to add it to the genapic structure in
>  asm-i386/genapic.h and also to the APIC_INIT macro in the same file.

Works for me.

>  (assuming that it is properly defined for default,bigsmp,summit) 

Seems to be.


diff -puN include/asm-i386/mach-generic/mach_apic.h~mach-generic-build-fix include/asm-i386/mach-generic/mach_apic.h
--- 25/include/asm-i386/mach-generic/mach_apic.h~mach-generic-build-fix	2003-06-18 02:06:07.000000000 -0700
+++ 25-akpm/include/asm-i386/mach-generic/mach_apic.h	2003-06-18 02:06:07.000000000 -0700
@@ -25,5 +25,6 @@
 #define check_phys_apicid_present (genapic->check_phys_apicid_present)
 #define check_apicid_used (genapic->check_apicid_used)
 #define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
+#define enable_apic_mode (genapic->enable_apic_mode)
 
 #endif /* __ASM_MACH_APIC_H */
diff -puN include/asm-i386/genapic.h~mach-generic-build-fix include/asm-i386/genapic.h
--- 25/include/asm-i386/genapic.h~mach-generic-build-fix	2003-06-18 02:06:07.000000000 -0700
+++ 25-akpm/include/asm-i386/genapic.h	2003-06-18 02:06:07.000000000 -0700
@@ -43,6 +43,7 @@ struct genapic { 
 			   struct mpc_config_translation *t); 
 	void (*setup_portio_remap)(void); 
 	int (*check_phys_apicid_present)(int boot_cpu_physical_apicid);
+	void (*enable_apic_mode)(void);
 
 	/* mpparse */
 	void (*mpc_oem_bus_info)(struct mpc_config_bus *, char *, 
@@ -101,6 +102,7 @@ struct genapic { 
 	APICFUNC(send_IPI_mask), \
 	APICFUNC(send_IPI_allbutself), \
 	APICFUNC(send_IPI_all), \
+	APICFUNC(enable_apic_mode), \
 	}
 
 extern struct genapic *genapic;

_

