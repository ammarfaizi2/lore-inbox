Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWBBWlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWBBWlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWBBWlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:41:40 -0500
Received: from mx1.suse.de ([195.135.220.2]:7599 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932384AbWBBWlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:41:39 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>
Date: Fri, 3 Feb 2006 09:41:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17378.35472.866942.506796@cse.unsw.edu.au>
Cc: kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules
 at least)
In-Reply-To: message from Andrew Morton on Thursday February 2
References: <200602021314_MC3-1-B765-7FAF@compuserve.com>
	<20060202135205.08d91b76.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 2, akpm@osdl.org wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > In-Reply-To: <17377.24090.486443.865483@cse.unsw.edu.au>
> > 
> > On Thu, 2 Feb 2006 at 12:19:22 +1100, Neil Brown wrote:
> > 
> > > My guess is there is there is something wrong with the 'alternative'
> > > stuff which strips out the lock prefix, but I couldn't see anything
> > > obviously wrong.  The CPUs don't have FEATURE_UP (see below) so it
> > > cannot possibly be removing the 'lock' prefix... but it certainly acts
> > > like it is.
> > 
> > Look closer:
> > 
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> > > constant_tsc pni monitor ds_cpl cid xtpr
> >   ^^^^^^^^^^^^
> > 
> > SMP alternatives is re-using the constant_tsc X86 feature bit.
> > 
> > --- 2.6.16-rc1-mm4-386.orig/include/asm-i386/cpufeature.h
> > +++ 2.6.16-rc1-mm4-386/include/asm-i386/cpufeature.h
> > @@ -71,7 +71,7 @@
> >  #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
> >  #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
> >  
> > -#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
> > +#define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
> >  
> >  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> >  #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
> 
> Darn, how did you spot that?

I can't say how he found the needle in the haystack, but I can confirm
that it fixes the problem.  I'm running -mm4 quite successfully with
this patch now.

Thanks!

Thinks.. maybe this typo would have been harder if the columns lined
up better, like this:
> >  #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
> >  #define X86_FEATURE_CONSTANT_TSC   (3*32+ 8) /* TSC ticks at a constant rate */
> >  
> > -#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
> > +#define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */


NeilBrown
