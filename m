Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312394AbSCURTG>; Thu, 21 Mar 2002 12:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312396AbSCURS4>; Thu, 21 Mar 2002 12:18:56 -0500
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:2575 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S312394AbSCURSx>; Thu, 21 Mar 2002 12:18:53 -0500
From: nicholas black <dank@trellisinc.com>
To: linux-kernel@vger.kernel.org
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: sis 5591 ide in 2.4.19-pre3 consumes souls
In-Reply-To: <3C9A0C22.3090702@inet6.fr>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20020321171851.A0D29A3C21@fancypants.trellisinc.com>
Date: Thu, 21 Mar 2002 12:18:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C9A0C22.3090702@inet6.fr> you wrote:
> There's definitely a problem with some UDMA 33 chipsets. I'll ask SiS 
> for 5591 chipset info RSN and look into this as soon as I find some time.

i look forward to it :).  in light of this problem (i've recieved mail from
one michal dorocinski echoing this behavior and referencing an -ac patch; i've
asked him to mail it here), will this driver stay in .19 for the time being?

> Could you send us the output of "lspci -vxxx" with 2.4.18-jl11 and boot 
> logs of 2.4.19-pre3-jl11 please ?

i shall do as much tonight, when i'm at the machine.

> Did you "make oldconfig" on the 2.4.19-pre3-jl11 sources with the your 
> old 2.4.18-jl11 .config or made a new config from scratch ?

of course; i don't have time for the latter :).  i just recreated this, and
here were applicable questions from oldconfig, and my responses:

no to auto-geometry resizing support
no to ide taskfile access
no to force enable legacy hosts to dma
no to dma only
no to noop elevator

the previous setup enabled generic pci ide chipsets, sharing of pci ide
interrupts, generic pci bus-master, use dma by default, and sis5513.  nothing
else regarding ide chipset support/bugfixes is enabled.

> If so assuming you didn't modify your source trees could you send us the 
> result of :
> diff <2.4.18-jl11_tree>/.config <2.4.19-pre3-jl11_tree>/.config | grep  
> "^. CONFIG"

using said simulated .configs:

[ouzo](1) $ diff linux-2.4.18/.config linux-2.4.19-pre3/.config | grep "^.
CONFIG"
> CONFIG_X86_MCE=y
< CONFIG_PACKET_MMAP_FILTER=y
< CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_ADMA=y
[ouzo](0) $

one other perhaps relevant piece of information:  this is not the finest hard
drive in the world; some months ago i broke off the grounding 40 pin.  that
line of the ide cable is now spliced off, and wrapped around a screw :).

-- 
nicholas black (dank@trellisinc.com)
"c has types for a reason.  c++ improved the type system for a reason.  perl
 and php programs have run-time failures for a reason." - lkml
