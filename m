Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTILUJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTILUJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:09:15 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:47098 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261885AbTILUJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:09:01 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Martin Schlemmer <azarah@gentoo.org>
To: Andi Kleen <ak@suse.de>
Cc: bunk@fs.tum.de, jgarzik@pobox.com, ebiederm@xmission.com, akpm@osdl.org,
       richard.brunner@amd.com, LKML <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030912213016.47a4e5de.ak@suse.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	 <20030911012708.GD3134@wotan.suse.de>
	 <20030910184414.7850be57.akpm@osdl.org>
	 <20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com>
	 <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com>
	 <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
	 <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com>
	 <20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de>
	 <1063393505.3371.207.camel@workshop.saharacpt.lan>
	 <20030912213016.47a4e5de.ak@suse.de>
Content-Type: text/plain
Message-Id: <1063396734.3371.226.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 21:58:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 21:30, Andi Kleen wrote:
> On Fri, 12 Sep 2003 21:05:06 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:

> Ok, so how many instructions was added by this ?  Or is it
> 
> None at all, Mr Inquisitor. It is all patched at early boot time.
> 

Thanks :P

> > Ok, so maybe my opinion about X86_GENERIC is not as intended, but
> > then IMHO, it should be 'fixed'.  I could not care less if my kernel
>
> X86_GENERIC has nothing to do with all this. All it does is 
> to always force the cache line padding to 128 byte. 
> 

Ok, thanks

>  
> > I have long wondered if everything in arch/i386/kernel/cpu/ is
> > really linked in 
> 
> It is (in MTRR drivers etc.), but the resulting overhead is small.
> 
> Really, when you want to save code size you should look elsewhere. All the 
> CPU support code is pretty lean and in many cases is __init code anyways
> (= is discarded after boot time) 
> 
> I can offer my old bloat-o-meter tool (ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter)


I am not really bothered about code size, as I tried (?) to say.

>  
> > This is just me, but why then don't we then just drop the specific
> > arch selection, and just have generics instead of pulling a sock
> > over the user's eyes ?
> 
> It is doing a lot of optimizations for the specific CPU. For example
> it tells gcc to compile for that CPU which can make a big difference (P4 prefers
> very different code compared to P3 or Athlon). Or it sets the paddings correctly
> for the CPU, which can make a very big difference in .text size. So when you
> select CONFIG_MPENTIUM4 you will get a kernel that will perform optimally for P4.
> 

> Then 2.6 added SSE1 prefetch support which made the P4 kernel not boot on
> anything that didn't support SSE1 (like older Athlon before XP). I fixed
> that then with dynamically patching the prefetches. The overhead at runtime
> is zero because it is patched at boot, the .text overhead for the patch 
> tables is minimal.
> 

Ok, thanks.

> So basically the 2.6 alternative() stuff just restored the 2.4 de-facto situation 
> in 2.6, and improved it slightly because the Athlon kernel also now works everywhere.
> 
> I think it's useful to keep kernels booting everywhere, it makes it a lot easier
> to test a single kernel on multiple systems.
> 

Yes, given.  I just don't think most people know or look at it the
same.  I for one usually just try not to add anything not needed
at the cost of some minor speed regression, as things many times
especially in a big project sometimes tends to get out of hand,
as all those minor regressions added is one big regression.  I do
however admit that I will be a bit out of my league trying to
judge in this case, but it still would be interesting ....

I however will not keep this up if you guys say its is fine.
Two things however does still does bother:

1)  What will it look like after being put through some benchmarks
just to verify.  I may however just need to get to bed early for
a change =)

2)  Will it be that difficult to also patch it in at boot like
the rest.  Once again it might just be paranoia from my side 8)


Thanks for the more in depth info.

Regards,

-- 
Martin Schlemmer


