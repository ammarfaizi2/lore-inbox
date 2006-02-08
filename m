Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWBHCIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWBHCIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWBHCIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:08:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030438AbWBHCIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:08:34 -0500
Date: Wed, 8 Feb 2006 03:08:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Keith Owens <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060208020832.GK3524@stusta.de>
References: <20060208011938.GJ3524@stusta.de> <200602080140.k181eDg20764@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080140.k181eDg20764@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 05:40:13PM -0800, Chen, Kenneth W wrote:
> Adrian Bunk wrote on Tuesday, February 07, 2006 5:20 PM
> > You could ask the same question for NUMA:
> > Select generic system type does not mean NUMA systems are only choice I 
> > can have. What's wrong with having an option that works just fine?
> 
> Please read more ia64 arch specific code ...
> 
> CONFIG_IA64_GENERIC is a platform type choice, you can have platform
> type of DIG, HPZX1, SGI SN2, or all of the above.  DIG platform depends
> on ACPI, thus need ACPI on.  SGI altix is a numa box, thus, need NUMA
> on.  NEC, Fujitsu build numa machines with ACPI SRAT table, thus, need
> ACPI_NUMA on.  When you build a kernel to boot on all platforms, you
> have no choice but to turn on all of the above.  Processor type and SMP
> is different from platform type.  It does not have any dependency on
> platform type.  They are orthogonal choice.

This is interesting, considering that e.g. IA64_SGI_SN2=y, NUMA=n or 
IA64_DIG=y, ACPI=n are currently allowed configurations.

> > Keith said IA64_GENERIC should select all the options required in
> > order to run on all the IA64 platforms out there.
>                           ^^^^^^^^^^^^^^
> > This is what my patch does.
> 
> You patch does more than what you described and is wrong.  Selecting
> platform type should not be tied into selecting SMP nor should it tied

This was what Keith wanted.

It seems everyone thinks I am wrong, but when I'm implementing what one 
person suggests, other people say that what I am doing is wrong.

> with processor type, nor should it tied with ARCH_FLATMEM_ENABLE.  All
> of them are orthogonal and independent.

1. NUMA on ia64 currently depends on !FLATMEM.
2. IA64_GENERIC currently select's NUMA.
3. You say IA64_GENERIC should not be tied with ARCH_FLATMEM_ENABLE.

It's impossible to fulfill all three of them.

My initial approach to fix them was to remove the select's from 
IA64_GENERIC, therefore removing 2., but this patch was not accepted.

This patch adds more select's to IA64_GENERIC, therefore removing 3., 
but you disagree with it.

The last choice it to remove the dependency of NUMA on !FLATMEM...  ;-)

> Theoretically and maybe academically interesting, I should be able to
> build a kernel that boots on all UP platforms, with your patch, that
> is not possible.

Theoretically and maybe academically interesting, I should be able to 
build a kernel that boots on all non-NUMA platforms, currently, that is 
not possible.

> - Ken

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

