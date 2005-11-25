Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVKYFJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVKYFJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVKYFJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:09:13 -0500
Received: from magic.adaptec.com ([216.52.22.17]:20610 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751406AbVKYFJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:09:12 -0500
Date: Fri, 25 Nov 2005 10:45:56 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why does insmod _not_ check for symbol redefinition ??
In-Reply-To: <c216304e0511242042h30fccd74ic2b1d5b237e2afc0@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0511251029150.18002-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Nov 2005 05:09:09.0920 (UTC) FILETIME=[5E3DAA00:01C5F17E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did'nt get any response to this one, so sending it again.

Can any of the module subsystem authors tell, why they have decided to 
allow loading a kernel module having an EXPORTed symbol with the same name 
as an EXPORTed  symbol in kernel proper. The safest thing would be to 
disallow  module loading in this case, giving a "Symbol redefinition" 
error.
	Allowing the module load will lead to overriding kernel functions
which will affect modules loaded in future, that reference those 
functions. Overall, it can have bad effects of varying severity.

Thanx,
Tomar

> 
> All,
>      Let me start by saying that, if we have compiled functionality
> X as a built-in part of kernel, and then if we try to load X compiled
> as a module, we get _bad_ results, varying from weird behaviour to
> upfront crashes.
>         The question is : Why does insmod not check for redefinition
> of symbols and hence disallow module loading in such cases ?
> 
> For the records, the kernel version I'm using is some flavour of
> 2.6.9.
> 
>         I understand that this is a very basic thing and the kernel
> module subsystem authors would have thought about it and if it behaves
> this way, it would more likely be a feature. I am keenly interested
> in knowing the rationale behind it.
> 
>         On my setup, SCSI midlayer was compiled as part of kernel proper
> and then the initrd tried to load scsi_mod.ko as a module also (which was
> present in initrd as I accidently used a wrong initrd). I would expect
> this to result in insmod failure due to redefinition of various
> functions already exported by the SCSI mid-layer (which is part of
> kernel proper).
>         What actually happened is that the scsi_mod.ko module got loaded
> and its init_module() function was called, which apart from lot of other
> things, called kmem_cache_create() to create a slab cache. Since the slab
> cache with the same name was already present (the first one was created
> when the SCSI midlayer init function was called as part of kernel proper
> initialization), this triggered a BUG.
>        When I checked for the exported SCSI midlayer symbols in
> /proc/kallsyms I saw duplicate symbols for all the SCSI midlayer symbols,
> one in the kernel text segment 0xcXXXXXXX and the other in the module
> text segment (this one was 0xeXXXXXXX).
>         I tried this with other components (ext3, jbd, e1000 etc) and the
> results were the same; the module gets loaded on top of the builtin
> functionality resulting in multiple definitions of the EXPORTed symbols.
> I've tried the same thing on 2.4.20 kernel with _same_ results.
> Since we see the same behaviour with different kernels, it is not specific
> to a particular kernel.
> 
> 
> Thanx,
> Tomar
> 
> 
> 
> 
> -- "Theory is when you know something, but it doesn't work.
>     Practice is when something works, but you don't know why.
>     Programmers combine theory and practice: Nothing works
>     and they don't know why ..."
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- "Theory is when you know something, but it doesn't work.
    Practice is when something works, but you don't know why.
    Programmers combine theory and practice: Nothing works 
    and they don't know why ..."

