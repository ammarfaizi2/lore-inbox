Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267169AbUBSANW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267172AbUBSANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:13:22 -0500
Received: from fmr06.intel.com ([134.134.136.7]:20696 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267169AbUBSANT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:13:19 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: kernel/microcode.c error from new 64bit code
Date: Wed, 18 Feb 2004 16:12:58 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA20C0@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel/microcode.c error from new 64bit code
Thread-Index: AcP2e4Kie/cibOvvS5iP7CkgUMup1AAAUPiA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Stephen Hemminger" <shemminger@osdl.org>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Feb 2004 00:12:59.0371 (UTC) FILETIME=[21BA53B0:01C3F67D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Linus Torvalds
>Sent: Wednesday, February 18, 2004 3:08 PM
>To: Stephen Hemminger
>Cc: ak@suse.de; linux-kernel@vger.kernel.org
>Subject: Re: kernel/microcode.c error from new 64bit code
>
>
>
>On Wed, 18 Feb 2004, Stephen Hemminger wrote:
>>
>> In the mad rush to put in Intel 64 bit support, did anyone make sure
and
>not
>> break the 32 bit build?
>
>Heh. Somebody has the driver enabled ;).
>
>How about this patch?
>
>		Linus
>
>---
>===== arch/i386/kernel/microcode.c 1.24 vs edited =====
>--- 1.24/arch/i386/kernel/microcode.c	Tue Feb 17 18:14:37 2004
>+++ edited/arch/i386/kernel/microcode.c	Wed Feb 18 15:05:38 2004
>@@ -371,8 +371,9 @@
> 	spin_lock_irqsave(&microcode_update_lock, flags);
>
> 	/* write microcode via MSR 0x79 */
>-	wrmsr(MSR_IA32_UCODE_WRITE, (u64)(uci->mc->bits),
>-	      (u64)(uci->mc->bits) >> 32);
>+	wrmsr(MSR_IA32_UCODE_WRITE,
>+		(unsigned long) uci->mc->bits,
>+		(unsigned long) uci->mc->bits >> 16 >> 16);
> 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
>
> 	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
