Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTHVCXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTHVCXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:23:48 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:41952 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262987AbTHVCXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:23:47 -0400
Subject: [PATCH2] Pentium Pro - sysenter - doublefault
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Mikael Pettersson <mikpe@csd.uu.se>, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16197.14968.235907.128727@gargle.gargle.HOWL>
References: <1061498486.3072.308.camel@new.localdomain>
	 <16197.14968.235907.128727@gargle.gargle.HOWL>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1061518685.1054.41.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Aug 2003 22:18:05 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 17:32, Mikael Pettersson wrote:
>  > The logic above is exactly what Intel says to do in "IA-32 IntelÂ®
>  > Architecture Software Developer's Manual, Volume 2: Instruction Set
>  > Reference" on page 3-767.  It also says that sysenter was added to the
>  > Pentium II.
> 
> I double-checked AP-485 (24161823.pdf, the "real" reference to CPUID),
> and it says (section 3.4) that SEP is unsupported when the signature
> as a whole is less that 0x633. This means all PPros, and PII Model 3s
> with steppings less than 3.
> 

Hi Dave, Everyone,

This make sense. Here is Mikael's suggested code as a patch.

Dave, I picked your name from the maintainers list.  Please 
feed this patch up the chain.


Jim Houston - Concurrent Computer Corp. 


diff -urN linux-2.6.0-test3.orig/arch/i386/kernel/cpu/intel.c
linux-2.6.0-test3.new/arch/i386/kernel/cpu/intel.c
--- linux-2.6.0-test3.orig/arch/i386/kernel/cpu/intel.c	2003-08-20
10:30:14.000000000 -0400
+++ linux-2.6.0-test3.new/arch/i386/kernel/cpu/intel.c	2003-08-21
21:34:40.000000000 -0400
@@ -246,7 +246,8 @@
 	}
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
-	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
+	if ( c->x86 == 6 && ((c->x86_model < 3) ||
+				(c->x86_model == 3 && c->x86_mask < 3)))
 		clear_bit(X86_FEATURE_SEP, c->x86_capability);
 	
 	/* Names for the Pentium II/Celeron processors 




