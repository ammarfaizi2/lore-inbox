Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWBBVuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWBBVuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWBBVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:50:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932309AbWBBVuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:50:54 -0500
Date: Thu, 2 Feb 2006 13:52:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: neilb@suse.de, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules
 at least)
Message-Id: <20060202135205.08d91b76.akpm@osdl.org>
In-Reply-To: <200602021314_MC3-1-B765-7FAF@compuserve.com>
References: <200602021314_MC3-1-B765-7FAF@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> In-Reply-To: <17377.24090.486443.865483@cse.unsw.edu.au>
> 
> On Thu, 2 Feb 2006 at 12:19:22 +1100, Neil Brown wrote:
> 
> > My guess is there is there is something wrong with the 'alternative'
> > stuff which strips out the lock prefix, but I couldn't see anything
> > obviously wrong.  The CPUs don't have FEATURE_UP (see below) so it
> > cannot possibly be removing the 'lock' prefix... but it certainly acts
> > like it is.
> 
> Look closer:
> 
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> > constant_tsc pni monitor ds_cpl cid xtpr
>   ^^^^^^^^^^^^
> 
> SMP alternatives is re-using the constant_tsc X86 feature bit.
> 
> --- 2.6.16-rc1-mm4-386.orig/include/asm-i386/cpufeature.h
> +++ 2.6.16-rc1-mm4-386/include/asm-i386/cpufeature.h
> @@ -71,7 +71,7 @@
>  #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
>  #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
>  
> -#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
> +#define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
>  #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */

Darn, how did you spot that?

Should `feature_up' appear in /proc/cpuinfo?
