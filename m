Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVDNUQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDNUQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDNUQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:16:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50692 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261491AbVDNUP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:15:29 -0400
Date: Thu, 14 Apr 2005 22:15:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Franco Sensei <senseiwa@tin.it>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050414201527.GD3628@stusta.de>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <20050412224357.GE3631@stusta.de> <425EAAF9.8060506@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425EAAF9.8060506@tin.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 12:40:09PM -0500, Franco Sensei wrote:
> Adrian Bunk wrote:
> >>When a new component is added to the kernel, let's say support for a new 
> >>file system, a .config entry is created (CONFIG_MYFS=y|m). Why is this 
> >>entry breaking compatibility? I mean, symbols still remains the same. 
> >>The addition of symbols is not a breaking point.
> >
> >That's clear.
> >
> >You said you've read Documentation/stable_api_nonsense.txt .
> >Please read the USB example in this document as an example when even API 
> >compatibility was a problem.
> 
> The example says that the usb layer changed from synchronous to 
> asynchronous and changed the data model. I'd say changing drastically is 
> a big issue. I'd say it would be a change from 2.4 to 2.6 series. It 
> does not mean that in a year we have to stick with the same version, in 
> a year things can change drastically and so should be the version.

Linux kernel development is working different.

Getting changes quickly to the users is considered more important than 
API or even ABI compatibility.

> I see one big thing: developement should be careful about who uses the 
> kernel and not caring about it alone, since it's not something useful by 
> itself :)

Offering improvements and new drivers to the users quickly is one way to 
care about the users.

I do not claim to agree with all details of kernel development - but 
that's how it works.

> >If you upgrade your kernel, you'll also upgrade the modules shipped with 
> >the kernel.
> 
> Yes! You said it yourself: shipped with the kernel. The world does not 
> rely only on the kernel. I have to administer a department, and I use 
> other modules that won't be in the kernel, such as afs.

If you upgrade the kernel, simply get a version of your external modules 
that support your new kernel, compile them against the new kernel, and 
ship the external modules as part of the rollout of the new kernel.

>...
> >In an open source system, it's usually more common that all drivers are 
> >shipped with the kernel. Therefore, there isn't such a big need for 
> >API+ABI compatibility since you can change all modules using an API when 
> >changing an API. And ABI compatibility isn't required because you can 
> >recompile the modules every time you recompile the kernel.
> 
> That's not entirely true. Kernel does not have all the modules someone 
> can use, and I made an example with my own department. The kernel should 
> make the machine work, providing means to operate the hardware. So, in 
> no case one can imagine having every single driver on this earth built 
> in the kernel...

Kernel development is based on the fact that all drivers should be 
shipped with the kernel.

If you buy hardware where no open source driver exists (often because 
the hardware manufacturer doesn't publish the hardware specifications) 
that's your problem.

> >ABI compatibility between kernel versions costs the following:
> >- space for all users of the kernel
> 
> I don't understand. Space of what?

Space for the code behind all the obsolete interfaces.

> >- speed of the kernel
> 
> Mmh... why should it be? Optimizing the kernel is possible, speeding it 
> up, without affecting ABI. Adding new components can't affect speed as 
> long as it won't affect it wihout ABI (adding parts does of course 
> affect the speed, but it's not different from ABI to non-ABI).

There are optimizations that are not possible without breaking 
compatibility.

Documentation/stable_api_nonsense.txt contains examples.

> >- much extra work and checking when doing any changes
> 
> Of course! You're developing a kernel to be used by other people! It's 
> quite... straightforward to be really careful about changes.
>...

You can't care about everything.

What you propose has both advantages and disadvantages for users of the 
kernel. It's general consensus among the kernel developers that the 
advantages are not worth the disadvantages.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

