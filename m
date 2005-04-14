Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVDNUh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDNUh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDNUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:37:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57826 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261539AbVDNUgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:36:18 -0400
Message-Id: <200504142034.j3EKYqmS005113@laptop11.inf.utfsm.cl>
To: Sensei <senseiwa@tin.it>
cc: David Lang <dlang@digitalinsight.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning 
In-Reply-To: Message from "Franco \"Sensei\"" <senseiwa@tin.it> 
   of "Thu, 14 Apr 2005 11:52:50 EST." <425E9FE2.6090102@tin.it> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 14 Apr 2005 16:34:52 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 14 Apr 2005 16:34:51 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Franco \"Sensei\"" <senseiwa@tin.it> said:
> David Lang wrote:
> > some config changes are additions, some redefine things.
> > 
> > you are mistakeing the .config file for a symbol table.

> No I'm not confusing. As long as the .config has an influence on the 
> makefiles I get different symbols names.

Nope.

> > for example if you compile a kernel with SMP=y you get different code 
> > then if you compile with SMP=n
> > 
> > if you have the same kernel version on identical machines, but with the 
> > SMP option different on the two different machines you cannot use the 
> > same module binary on both of them.

> Of course, but It's cleare that machines with SMP are different from a 
> simple mono-cpu.

And kernels compiled with one compiler are different than those compiled
with another. And if you have preemption they are different. Don't forget
about clasic i386 vs i486 vs ... vs i686 (spinlocks generate different
code!). Then let's consider memory split: 2/2, 3/1, 3.5/0.5, ... Now throw
in assorted debugging options. On some architectures you have several
possible (reasonable!) page sizes.

> It's not an issue talking about smp vs. not-smp. Let's talk about a 
> machine: it's useless arguing about Cray while I'm talking about a 
> simple environment.

Define "simple environment". Even Red Hat (they are /very/ interested in a
single kernel image, as it cuts down testing and bug tracking etc!) ships
half a dozen different kernels, tailored for different configurations. And
you'll find external modules (like for NTFS) compiled separately for each
of them.

> Every kernel has always the distinction about smp. So it's not a big 
> problem.

And it has distinctions on dozens of other configuration options too.

[...]

> Finding a bug in the kernel source and patching it, must be a careful 
> step, because if I have to mantain 100 machines, and I know that 
> applying the patch will result in a broken kernel modules, I'm not happy 
> with it. I must go manually on each machine, apply the patch, recompile 
> the modules... Makes me think about NOT applying the patch.

Or having /your/ standard kernel on all 100 machines, compile once and copy
around. No need for /me/ to run your exact same configuration.

[...]

> Source compatibility is there.

Sort of.

>                                Now, you're talking about issues which 
> are not your buisness: a binary distribution must take care of how the
> kernel it's compiled. As long as it uses the same gcc and switches, it's
> ok.

Yes, it is their bussiness.

> Practically, if suse has kernel-2.6.A and kernel-modules-2.6.A it knows 
> how they're compiled, and they work everywhere. Of course, it has also 
> kernel-2.6.A-SMP and its modules.

And A doesn't have some options I'd like, and others you loathe.

> When 2.6.B is released, using ABI will just result in another 
> compilation,

Right.

>              creating the kernel with additions and patches, and 
> distributing them. Modules .A should work on .B,

Iff nothing changes. That isn't usually the case.

>                                                  like I do with OpenAFS, 
> Every kernel update shouldn't break the magic :)

The problem is that giving that guarantee costs developer time and
flexibility. The gain (given that source for recompilation is freely
available) is so minuscule that the consensus is that it just isn't worth
any extra hassle /at all/.

> > but 2.6.11.7 is not nessasarily binary compatable with 2.6.11.7, let 
> > alone something drasticly different (say 2.6.11.6)

> Sure, because it's not designed to be so.

And the decision to design thusly is completely conscicious, it is not a
random "it just turned out this way by mistake".

> I just see advantages on ABI, and I think it's not bad talking about it...

I see many disadvantages to ABI, and it wouldn't be bad to look at them too.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
