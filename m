Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTAIDLq>; Wed, 8 Jan 2003 22:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAIDLp>; Wed, 8 Jan 2003 22:11:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:5829 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261426AbTAIDLo>;
	Wed, 8 Jan 2003 22:11:44 -0500
Message-ID: <3E1CEA70.CE486C4D@digeo.com>
Date: Wed, 08 Jan 2003 19:20:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] OProfile Pentium IV support
References: <20030109000035.GA53798@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2003 03:20:19.0653 (UTC) FILETIME=[09BEBF50:01C2B78E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> This is a compile-tested-only port of Graydon Hoare's driver. Please
> give it a test and report back.

Below is a fix to make the kernel build when it is configured for
something other than a p4.

> http://www.movement.uklinux.net/oprofile-0.5cvs.tar.gz

$./configure
 ...
checking for ld... ld
checking for kernel OProfile support... no
checking for kernel version... 2.5.54
configure: error: Unsupported kernel version




 arch/i386/oprofile/Makefile  |    3 ++-
 arch/i386/oprofile/nmi_int.c |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux-hype/arch/i386/oprofile/Makefile~op4-fix	Wed Jan  8 19:12:38 2003
+++ linux-hype-akpm/arch/i386/oprofile/Makefile	Wed Jan  8 19:12:38 2003
@@ -7,4 +7,5 @@ DRIVER_OBJS = $(addprefix ../../../drive
 
 oprofile-y				:= $(DRIVER_OBJS) init.o timer_int.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
-					   op_model_ppro.o op_model_p4.o
+					   op_model_ppro.o
+oprofile-$(CONFIG_MPENTIUM4)		+= op_model_p4.o
--- linux-hype/arch/i386/oprofile/nmi_int.c~op4-fix	Wed Jan  8 19:12:38 2003
+++ linux-hype-akpm/arch/i386/oprofile/nmi_int.c	Wed Jan  8 19:12:38 2003
@@ -215,7 +215,7 @@ struct oprofile_operations nmi_ops = {
 };
  
 
-#ifndef CONFIG_X86_64
+#if !defined(CONFIG_X86_64) && defined(CONFIG_MPENTIUM4)
 
 static int __init p4_init(enum oprofile_cpu * cpu)
 {
@@ -263,7 +263,7 @@ static int __init ppro_init(enum oprofil
 	return 1;
 }
 
-#endif /* CONFIG_X86_64 */
+#endif
  
 int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
 {
@@ -282,7 +282,7 @@ int __init nmi_init(struct oprofile_oper
 			*cpu = OPROFILE_CPU_ATHLON;
 			break;
  
-#ifndef CONFIG_X86_64
+#if !defined(CONFIG_X86_64) && defined(CONFIG_MPENTIUM4)
 		case X86_VENDOR_INTEL:
 			switch (family) {
 				/* Pentium IV */
@@ -301,7 +301,7 @@ int __init nmi_init(struct oprofile_oper
 					return 0;
 			}
 			break;
-#endif /* CONFIG_X86_64 */
+#endif
 
 		default:
 			return 0;

_
