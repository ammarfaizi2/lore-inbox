Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVDLTfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVDLTfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDLTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:34:28 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:230 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262445AbVDLSJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:09:52 -0400
Date: Tue, 12 Apr 2005 11:03:01 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Franco \"Sensei\"" <senseiwa@tin.it>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
In-Reply-To: <425C03D6.2070107@tin.it>
Message-ID: <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
 <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it>
 <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Franco "Sensei" wrote:

> Date: Tue, 12 Apr 2005 12:22:30 -0500
> From: Franco "Sensei" <senseiwa@tin.it>
> To: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
> Subject: Re: [INFO] Kernel strict versioning
> 
> Krzysztof Halasa wrote:
>> It isn't enough. The same compiler and the same .config - yes. But that
>> means you'd have no progress within, say, 2.6. Only bug fixes.
>> There _is_ a tree like that - 2.6.11.Xs are only bugfixes.
>
> Ok, this adds a new information. Let me explain what I understand now.
>
> When a new component is added to the kernel, let's say support for a new file 
> system, a .config entry is created (CONFIG_MYFS=y|m). Why is this entry 
> breaking compatibility? I mean, symbols still remains the same. The addition 
> of symbols is not a breaking point.

some config changes are additions, some redefine things.

you are mistakeing the .config file for a symbol table.

for example if you compile a kernel with SMP=y you get different code then 
if you compile with SMP=n

if you have the same kernel version on identical machines, but with the 
SMP option different on the two different machines you cannot use the same 
module binary on both of them.

>> But remember that changing a single config option may make your kernel
>> incompatible. You can't avoid that without making the kernel suboptimal
>> for most situations - basically you'd have to disable non-SMP builds,
>> disable (or permanently enable) 4KB pages etc.
>
> What about making extensive use of modules? If everything (acceptable) is 
> built on modules, can you still have abi, can you still change modules and 
> api implementation without breaking anything? What are the requisites to abi?

you would have an ABI for that kernel image, compiled with those options, 
and with that compiler. if you change any of those things then your 
modules won't work (you have a different ABI

> I'm really curious about it. How abi can be made actual, and how would it be 
> if we had a completely modular kernel (not micro, but something alike, 
> modular in kernel-space, not in user-space).

what you are missing is that nobody has any interest in supporting a 
kernel ABI, even within a single kernel version. there are just too many 
advantages to changeing fundamantal things in the kernel depending on the 
config options.

>> If you make a proprietary closed-sourse system (with kernel modules), you
>> probably have to make the system suboptimal. But with open source there
>> is a better alternative.
>
> No, I wouldn't. Closed source is out of discussion. Optimal kernel, even in 
> open source can be achieved.
>
>> Asking for one modules dir only is similar to asking for only one
>> /boot/vmlinuz-2.6 kernel file.
>
> Quite the same, yes. You can still have different kernels of course! By the 
> way, another stupid curiosity is why /lib/modules instead of /boot? Because 
> boot can be a partition and not be mounted? The same thing for /lib (crazy, 
> but you can do it). I would expect a kernel and all its parts all in one 
> place, not different locations...

I don't know why the default location for the modules, but again you are 
assuming that you CAN have a single vmlinuz-2.6 kernel file for all 
machines of a given arch.

you can't.

there are just too many config options that change the internals of the 
kernel (locking, function call formats, CPU type optmizations, etc) for 
you to just have one.

>> First, each 2.6.X would have to be binary-compatible with itself.
>
> That's the only point for me. I wouldn't make 2.6 and 2.8 kernels binary 
> compatibles.

but 2.6.11.7 is not nessasarily binary compatable with 2.6.11.7, let alone 
something drasticly different (say 2.6.11.6)

David Lang

> -- 
> Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
>       <icqnum:241572242>
>       <yahoo!:sensei_sen>
>       <msn-id:sensei_sen@hotmail.com>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
