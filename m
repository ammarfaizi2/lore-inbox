Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRFKMUU>; Mon, 11 Jun 2001 08:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRFKMUA>; Mon, 11 Jun 2001 08:20:00 -0400
Received: from ns.caldera.de ([212.34.180.1]:2025 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261410AbRFKMT4>;
	Mon, 11 Jun 2001 08:19:56 -0400
Date: Mon, 11 Jun 2001 14:19:18 +0200
Message-Id: <200106111219.f5BCJI430936@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: joerg@hydrops.han.de (Joerg Ahrens)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_modify_ldt extension (default_ldt)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <m158sRu-0009RiC@hydrops.han.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

In article <m158sRu-0009RiC@hydrops.han.de> you wrote:
> Hi,
>
> I am trying to integrate binfmt_xout.c into kernel 2.4 as part of the 
> linux-abi project (formerly known as iBCS). For old Xenix 286 binaries the 
> lcall7 gate needs to part of the LDT.
>
> In kernels 2.0 sys_modify_ldt(0,...) used to return the default_ldt (with 
> lcall7 gate) if there were no segments set up. This behaviour changed in 
> kernels 2.2 . As a result of a discussion with Linus, David Bruce wrote a 
> patch for binfmt_xout.c tweaking with gdt and current->tss.ldt to get the
> address of default_ldt. This patch does not work any more with kernels 2.4
> as tss vanished from task_struct. 
>
> I do see 4 ways to cope with this problem:
>
> a) extend sys_modify_ldt with a function to retrieve the default_ldt. I did 
>    this for testing (see attached diff for arch/i386/kernel/ldt.c ).

Looks sane to me.

> b) do some work an Davids patch but this is kind of magic for me :-)
>    (see attached default_ldt patch)
>
> c) loose the option to compile binfmt_xout (and the rest of linux-abi) as 
>    module and simply use the symbol default_ldt. I dint't try that.

As the linux-abi maintainer I do not think that's a good idea..

> d) Forget about those old fashioned 286 binaries. This option will make some
>    linux users feel sad, as they run these progs for their daily business.

If possible at all I'll vote for having 286 support.

I'll integrate the patch into the linux-abi tree if you also send me the
other changes (mostly binfmt_xout.c changes I suppose).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
