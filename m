Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264230AbTICTDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTICTB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:01:57 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:14490 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S264348AbTICS6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:58:35 -0400
Date: Wed, 3 Sep 2003 20:58:31 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030903185831.GG1446@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <200309031850.14925.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:53:01PM +0100, James Clark wrote:
> Following my initial post yesterday please find attached my proposal for a 
> binary 'plugin' interface:

Plugin? Ugly word. Let's say modules instead. And modules ARE implemented
now with proper interface, so what are we talking about?
 
> This is not an attempt to have a Microkernel, or any move away from GNU/OSS 
> software. I believe that sometimes the ultimate goals of stability and 

I can't follow. So you assumed that microkernel can't be implemented in
open source environment? Let's check out Hurd (btw, afaik Hurd is a collection
of 'server processes' running on the top of the Mach microkernel).

> portability get lost in the debate on OSS and desire to allow anyone to 
> contribute. It is worth remembering that for every Kernel hacker there must 

? Anyone can write a kernel module even now, I don't see the problem
here.

> be 1000's of plain users. I believe this proposal would lead to better 
> software and more people using it.
> 
> Proposal
> -----------
> 1. Implement binary kernel 'plugin' interface

binary? You can't. For being precise: you can't do it with keeping
performance in mind. Newer major kernel releases use more or less
different kind of structures, algorithms, etc. There are SMP systems
and UP and so on. For maximum performance, kernel module SHOULD be
compiled from source with target configuration keeping in mind and
matching with kernel's configuration of course.

Sure, you can create a 'glue' layer between the actual kernel module
API and something you're calling 'binary interface', but it will be
a performance bottleneck, also this would make kernel larger in memory.
You will end at a situation where win NT also sucks: several abstracion
layers should be implemented which wastes performance just "translating"
things between software and/or hardware resources, while it can be possible
to do this directly. Sure, direct method breaks compatibility, eg you can't
load easily a 2.0.x kernel modules into 2.6.0-testX kernel, but exactly
this is the why where you're not limited by the bad meaning of compatibility
just for wasting several percent of your resources to keep everything 
working with VERY obsolated binary-only drivers ...

> 2. Over time remove most existing kernel 'drivers' to use new interface - This 
> is NOT a Microkernel.

I can't understand, let's say:

A) "Over time remove most existing kernel 'drivers' to use new interface"
B) "This is NOT a Microkernel"

I can't see any logical relationship between A and B, so I don't understand
this sentence at all.

> 3. Design 'plugin' interface to be extensible as possible and then rarely 
> remove support from interface. Extending interface is fine but should be done 
> in a considered way to avoid interface bloat. Suggest interface supports 
> dependant 'plugins'

So if someone 'invents' a brand-new algorithm for Linux you SHOULD keep
the binary interface the same, where you can gain (let's say) 1000% of
performance with reconstructing the module interface as well? Ehhh. Or
you should keep up an 'abstraction layer' to translate between 'good-old-braken'
API and the real "internal" kernel API? It would be HORRIBLE, SLOW, HUGE,
and UNSTABLE. This reminds me m$ win at the first sight ;-)

> 4. Allow 'plugins' to be bypassed at boot - perhaps a minimal 'known good' 
> list
> 5. Ultimately, even FS 'plugins' could be created although IPL would be 
> required to load these. 
> 6. Code for Kernel, Interface and 'plugins' would still be GPL. This would not 
> prevent the 'tainted' system idea. 

? Please, say only ONE advantage of this binary plugins thing then!
Because I don't see even ONE, just disadvantages, I've described.

> 
> Expected Outcomes
> ------------------------
> 
> 1. Make Linux easier to use
> 2. The ability to replace even very core Kernel components without a restart.

Modules. It's only a question to modularize the current kernel even more,
not something 'we need some very different model'. But this question would
lead to the fact that you can't modularize at this 'brutal' way, since
between versions of Linux, core changes can be done as well. So to do this
either you need to a very-complex-and-almost-imposible-to-implement
'translator' which would save internal stage of the whole system, and
loads it to the probably very different new data structures, or linux
should keep binary compatibility between versions with slow, huge, and
unstable 'glue' layers, hiding internal things from other parts.

> 3. Allow faulty 'plugins' to be fixed/replaced in isolation. No other system 
> impact.
> 4. 'Plugins' could create their own interfaces as load time. This would remove 
> the need to pre-populate /dev. 

??

> 5. Remove need for joe soap user to often recompile Kernel.

User should not recompile the kernel even now. I have several 'windows-style'
friends using Linux without even know the meaning of 'kernel' at all.

> 6. Remove link between specific module versions and Kernel versions.

You CAN'T do this, I've described. Sure, you can, but there would be
only disadvantages.

> 7. Reduce need for major Kernel releases. Allow effort to concentrate on 
> improving Kernel not maintaining ever increasing Kernel source that includes 
> support for the 'Kitchen Sink'
> 8. Make core Kernel more stable. Less releases and less changes mean less 
> bugs. It would be easy to identify offending 'plugin' by simply starting up 
> the Kernel with it disabled.
> 9. Remove need for modules to be maintained in sync with each Kernel thus 
> freeing 'module' developers to add improved features or work on new projects.

So again, you can't gain the maximum of your hardware because the complexity
of that 'binary API' would be something like a low bandwidth network
between two supercomputers, eg with creating a single on-time binary API,
you can't gain the maxmimum of new invents later without breaking it.


 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- Gábor (larta'H)
