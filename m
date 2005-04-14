Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVDNSDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDNSDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDNSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:03:10 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:64693 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261580AbVDNSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:02:08 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Franco \"Sensei\"" <senseiwa@tin.it>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Date: Thu, 14 Apr 2005 10:57:47 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [INFO] Kernel strict versioning
In-Reply-To: <425E9FE2.6090102@tin.it>
Message-ID: <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
 <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it>
 <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it>
 <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005, Franco "Sensei" wrote:

> Date: Thu, 14 Apr 2005 11:52:50 -0500
> From: Franco "Sensei" <senseiwa@tin.it>
> To: David Lang <dlang@digitalinsight.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
>     linux-kernel@vger.kernel.org
> Subject: Re: [INFO] Kernel strict versioning
> 
> David Lang wrote:
>> some config changes are additions, some redefine things.
>> 
>> you are mistakeing the .config file for a symbol table.
>
> No I'm not confusing. As long as the .config has an influence on the 
> makefiles I get different symbols names.
>
>> for example if you compile a kernel with SMP=y you get different code then 
>> if you compile with SMP=n
>> 
>> if you have the same kernel version on identical machines, but with the SMP 
>> option different on the two different machines you cannot use the same 
>> module binary on both of them.
>
> Of course, but It's cleare that machines with SMP are different from a simple 
> mono-cpu.
>
> It's not an issue talking about smp vs. not-smp. Let's talk about a machine: 
> it's useless arguing about Cray while I'm talking about a simple environment.
>
> Every kernel has always the distinction about smp. So it's not a big problem.

there are at least a half dozen options besides SMP that have similar 
effects.

>> you would have an ABI for that kernel image, compiled with those options, 
>> and with that compiler. if you change any of those things then your modules 
>> won't work (you have a different ABI
>
> Of course, as I stated, it's a distro's care to use the same gcc and same 
> switches....

Ok, now you are talking a distro, not linux itself. different subject, 
belongs on different lists (and by the way distros already tend to do this 
type of thing)

>> what you are missing is that nobody has any interest in supporting a kernel 
>> ABI, even within a single kernel version. there are just too many 
>> advantages to changeing fundamantal things in the kernel depending on the 
>> config options.
>
> An advantage is the total freedom about the code. Ok, I know. But as long as 
> the kernel grows, in size and in its use, something more should be 
> considered. ABI is a step forward companies and people like me in handling 
> linux easily. API and data structure stability should be something in mind, 
> since breaking compatibility from 2.6.8 to 2.6.8.1 causes big troubles to 
> anyone who's mantaining many machines. And if you are in big environments, 
> you probably use modules which are not in vanilla, and will never be, like 
> OpenAFS.
>
> Finding a bug in the kernel source and patching it, must be a careful step, 
> because if I have to mantain 100 machines, and I know that applying the patch 
> will result in a broken kernel modules, I'm not happy with it. I must go 
> manually on each machine, apply the patch, recompile the modules... Makes me 
> think about NOT applying the patch.

first off, if you can deploy a new kernel across 100 machines you can 
deploy new modules along with it.

second, if you are applying the patch and know that it doesn't affect 
anything that the modules use you don't have to recompile the modules, but 
if you want to be safe becouse you don't know what the patch affects then 
you replace the modules as well (for all you know the patch affects just a 
module, not the base kernel.

>> I don't know why the default location for the modules, but again you are 
>> assuming that you CAN have a single vmlinuz-2.6 kernel file for all 
>> machines of a given arch.
>> 
>> you can't.
>
> I think we can. Freedom in developing source code is not necessarily stealing 
> bricks from someone's feet :)
>
>> there are just too many config options that change the internals of the 
>> kernel (locking, function call formats, CPU type optmizations, etc) for you 
>> to just have one.
>
> Source compatibility is there. Now, you're talking about issues which are not 
> your buisness: a binary distribution must take care of how the kernel it's 
> compiled. As long as it uses the same gcc and switches, it's ok.
>
> Practically, if suse has kernel-2.6.A and kernel-modules-2.6.A it knows how 
> they're compiled, and they work everywhere. Of course, it has also 
> kernel-2.6.A-SMP and its modules.
>
> When 2.6.B is released, using ABI will just result in another compilation, 
> creating the kernel with additions and patches, and distributing them. 
> Modules .A should work on .B, like I do with OpenAFS, Every kernel update 
> shouldn't break the magic :)

again you are talking about what a distro chooses to do, go ahead and do 
this if you want, but it has no relevance to the kernel mailing list.

This will be my last message on this subject, hopefully you will let this 
die or take the conversation to the mailing lists of the distros that you 
choose to use.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
