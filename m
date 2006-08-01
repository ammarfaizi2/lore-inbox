Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWHAJpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWHAJpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWHAJpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:45:13 -0400
Received: from ip-160-218-140-54.eurotel.cz ([160.218.140.54]:8362 "EHLO
	host0.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S1161018AbWHAJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:45:11 -0400
Date: Tue, 1 Aug 2006 11:43:51 +0200
From: Jan Kratochvil <lace@jankratochvil.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060801094351.GA25944@host0.dyn.jankratochvil.net>
References: <20060707143519.GB13097@host0.dyn.jankratochvil.net> <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com> <20060731202520.GB11790@in.ibm.com> <20060731210050.GC11790@in.ibm.com> <m18xm9425s.fsf@ebiederm.dsl.xmission.com> <20060801042528.GA19157@host0.dyn.jankratochvil.net> <m1bqr43jqv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqr43jqv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 11:09:28 +0200, Eric W. Biederman wrote:
> Jan Kratochvil <lace@jankratochvil.net> writes:
...
> > i386 had alignment requirement:
> > 	/* current_thread_info()&co. are 8192-alignment fixed (for the initial
> > stack). */
> > 	#if CONFIG_PHYSICAL_START & 0x1FFF
> > 	#error "CONFIG_PHYSICAL_START must be 2*PAGE_SIZE (0x2000) aligned!"
> > 	#endif
> > as IIRC those i386 2MB/4MB pages must be (apparently) 2MB/4MB aligned in the
> > virtual address space but their physical target address can be arbitrary.
> 
> I know you can't use huge pages if your physical address is not
> properly aligned.   Which can be a performance impact if nothing else.
> Not something I want to encourage in a general purpose kernel. 

So you rather crash than running in that unmeasurably lower performance?

IIRC those 2MB/4MB pages performance "gain" is still present (in my patch)
even if the kernel location is not 2MB/4MB aligned because the i386 2MB/4MB
pagetable entries can have arbitrary physical memory target address.
But maybe I lie here, sorry, I really do not remember it much.
(It 100% worked with the "full performance" if aligned and it "worked" if
unaligned but I do not remember if it worked "full performance" if unaligned.)

...
> I'm not terribly comfortable with the 8K alignment number as we only
> tell the linker we need 4K alignment.

Yes, it should be fixed there so that the stacks get allocated 8KB-aligned not
depending on the kernel code position at all.  That means allocating the
initial stack by code and not relying on its autoallocation by the linker.
There would remain the 4KB alignment requirement due to the physical target
address of the pagetable entries.

...
> > ( I did not check your patches as they are locked in that useless GIT anyway. )
> ( As opposed to the unuseable CVS I presume :)

Yes, it has the same unusability as CVS, just it looses the feature of being
the standard.  I assume some CVS flamewar already occured some time ago.


Regards,
Lace
