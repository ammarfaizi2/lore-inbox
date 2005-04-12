Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVDLWuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVDLWuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVDLWrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:47:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20751 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262586AbVDLWn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:43:58 -0400
Date: Wed, 13 Apr 2005 00:43:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Franco Sensei <senseiwa@tin.it>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050412224357.GE3631@stusta.de>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C03D6.2070107@tin.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 12:22:30PM -0500, Franco Sensei wrote:
> Krzysztof Halasa wrote:
> >It isn't enough. The same compiler and the same .config - yes. But that
> >means you'd have no progress within, say, 2.6. Only bug fixes.
> >There _is_ a tree like that - 2.6.11.Xs are only bugfixes.
> 
> Ok, this adds a new information. Let me explain what I understand now.
> 
> When a new component is added to the kernel, let's say support for a new 
> file system, a .config entry is created (CONFIG_MYFS=y|m). Why is this 
> entry breaking compatibility? I mean, symbols still remains the same. 
> The addition of symbols is not a breaking point.

That's clear.

You said you've read Documentation/stable_api_nonsense.txt .
Please read the USB example in this document as an example when even API 
compatibility was a problem.

> >But remember that changing a single config option may make your kernel
> >incompatible. You can't avoid that without making the kernel suboptimal
> >for most situations - basically you'd have to disable non-SMP builds,
> >disable (or permanently enable) 4KB pages etc.
> 
> What about making extensive use of modules? If everything (acceptable) 
> is built on modules, can you still have abi, can you still change 
> modules and api implementation without breaking anything? What are the 
> requisites to abi?
>...

If you upgrade your kernel, you'll also upgrade the modules shipped with 
the kernel.

-> it doesn't matter whether the code shipped with the kernel is 
   compiled static or modular

> >If you make a proprietary closed-sourse system (with kernel modules), you
> >probably have to make the system suboptimal. But with open source there
> >is a better alternative.
> 
> No, I wouldn't. Closed source is out of discussion. Optimal kernel, even 
> in open source can be achieved.
>...

What's an "optimal kernel"?

In a closed-sourse system, there's usually the OS plus API+ABI for 
driver writers and the drivers are often shipped with the hardware.
Therefore API+ABI compatibility is required.

In an open source system, it's usually more common that all drivers are 
shipped with the kernel. Therefore, there isn't such a big need for 
API+ABI compatibility since you can change all modules using an API when 
changing an API. And ABI compatibility isn't required because you can 
recompile the modules every time you recompile the kernel.

ABI compatibility between kernel versions costs the following:
- space for all users of the kernel
- speed of the kernel
- much extra work and checking when doing any changes

Nobody claims API+ABI compatibility was technically impossible in the 
Linux kernel. It's simply a consensus among the kernel developers that 
the small advantages of ABI compatibility are not worth the costs.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

