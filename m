Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbTILTPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTILTPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:15:21 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:36346 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261834AbTILTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:15:12 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Martin Schlemmer <azarah@gentoo.org>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, jgarzik@pobox.com, ebiederm@xmission.com,
       akpm@osdl.org, richard.brunner@amd.com,
       LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
In-Reply-To: <20030912202851.3529e7e7.ak@suse.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	 <20030911012708.GD3134@wotan.suse.de>
	 <20030910184414.7850be57.akpm@osdl.org>
	 <20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com>
	 <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com>
	 <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
	 <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com>
	 <20030912182216.GK27368@fs.tum.de>  <20030912202851.3529e7e7.ak@suse.de>
Content-Type: text/plain
Message-Id: <1063393505.3371.207.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 21:05:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 20:28, Andi Kleen wrote:
> On Fri, 12 Sep 2003 20:22:16 +0200
> Adrian Bunk <bunk@fs.tum.de> wrote:
> 
> 
> > 
> > But even CONFIG_X86_GENERIC doesn't do what you expect. A kernel 
> > compiled for Athlon wouldn't run on a Pentium 4 even with 
> > CONFIG_X86_GENERIC.
> 
> It does. Just try it.
> 
> > 
> > Quoting arch/i386/Kconfig in -test5:
> > 
> > <--  snip  -->
> > 
> > config X86_USE_3DNOW
> >         bool
> >         depends on MCYRIXIII || MK7
> >         default y
> 
> That's obsolete and could be removed. All 3dnow! code is dynamically patched depending on the CPUID.
> 

Ok, so how many instructions was added by this ?  Or is it
just in the init code ?  What else just add 'just another
one or two instructions' to common paths because of this?

Which ever way, the point I and some of the others (besides the
additional one from the embedded guys) want to make, is if I
select the CPU to be Pentium4, it means I want a kernel that is
optimised for my P4, without extra crap that I do not need.  Sure,
its an extra instruction here, two there, etc - but when will it
be too much ?  Is this not maybe the fabled 'slight slowdown' that
so many  people complain about from round the 2.5.[67]'s ?

Ok, so maybe my opinion about X86_GENERIC is not as intended, but
then IMHO, it should be 'fixed'.  I could not care less if my kernel
only boot just on my box, never mind on another P4 - I just want
the most optimised on possible.  Sure, some guys want a more generic
kernel - get X86_GENERIC to work for them.  Same for distro's.

I have long wondered if everything in arch/i386/kernel/cpu/ is
really linked in (meaning with no #ifdef as it now looks to be
at a quick peek), or if it was just easier to link them all,
but have non generic stuff (amd/cyrix/whatever specific code)
filtered by ifdef's.

This is just me, but why then don't we then just drop the specific
arch selection, and just have generics instead of pulling a sock
over the user's eyes ?


Thanks,

-- 
Martin Schlemmer


