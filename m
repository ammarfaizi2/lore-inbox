Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbRBWLAw>; Fri, 23 Feb 2001 06:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130049AbRBWLAn>; Fri, 23 Feb 2001 06:00:43 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:34442 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129535AbRBWLAa>; Fri, 23 Feb 2001 06:00:30 -0500
Date: Fri, 23 Feb 2001 11:01:05 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Phil Smith <phil@masternode.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: CS4232 sound questions
In-Reply-To: <20010222200002.A451@gezr.masternode.net>
Message-ID: <Pine.LNX.4.21.0102231049230.3433-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

...maybe it is a bit off-topic here, sorry guys! Phil, you better asked
this Q on comp.os.linux.hardware / setup / whatever, am I right?

I got this card working fine with 2.4.x. Currently configured as modules,
I even managed to get them to autoload. Looks like you (also) are using
OSS. So, will try to recap main points of my configuration (that box is
at home): 

in .config sound, OSS, CS4232, OPL3 - all as modules (to produce sound.o,
soundcore.o, cs4232.0, ad1848.o, uart401.o, opl3.o - I think)

Although in .config I DO have PnP enabled, I am still running isapnp on
startup (perhaps I don't need to do that, do I?)

in modules.conf
alias char-major-14 cs4232
pre-install cs4232 modprobe "-k" sound
post-install cs4232 modprobe "-k" opl3
options cs4232 ... (IO, dma, IRQ,...)

I think, this is it. May be I confused something above - but you should be
able to guess what I meant:-) If not - I'll send you the exact
config. lines from home.

HTH
Guennadi

On Thu, 22 Feb 2001, Phil Smith wrote:

> I have come to the pont of having to mail this list in search of a greater
> understanding of what I could possibably be doing wrong in reguards to 
> enabling my sound card.  Under 2.2.X I was able to include the cards 
> configuration during the config, yes, I understand that this has changed
> in opt for other methods.  These methods though are very strange and 
> somewhat unclear in the current documentation set.  I have tried several
> possible built-in and modular configs with the results being the same, below 
> I will include information that may or may not be what is necessary to get 
> possible solutions to this, but odd or exact suggestions will be greatly 
> appreciated.  Thank you,  Phil Smith
>  
> The mother board is a pr440fx intel board.
> Dual ppro 200 cpus
> Linux version 2.4.1 (root@gezr) (gcc version 2.95.3 20010125 (prerelease)) #8 SMP Thu Feb 22 17:44:42 CST 2001
> 
> dmesg information concerning the card
> 
> PCI->APIC IRQ transform: (B0,I17,P0) -> 18
> Limiting direct PCI/PCI transfers.
> Activating ISA DMA hang workarounds.
> isapnp: Scanning for Pnp cards...
> isapnp: Card 'CS4236B Audio'
> isapnp: 1 Plug & Play card detected total
> 
> ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
> YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
> 
> 
> 
> 
> lilo config line  (kernel boot parameter?)
> append="cs4232=0x534,5,0,3,0x330,9"
> 
> 14 sound       shows in /proc/devices
> 
> 
> initial lines from /proc/isapnp   (all sound card coresponding devices
> show as "not active"  activation can be achieved via isapnptools and
> no sound working from that):
> 
> Card 1 'CSC0b35:CS4236B Audio' PnP version 1.0 Product version 0.1
>   Logical device 0 'CSC0000:WSS/SB'
>       Device is not active
>       Resources 0
>       Priority preferred
>       Port 0x534-0x534, align 0x3, size 0x4, 16-bit address decoding
> 
> 
> P.S. I perfer to not use modules for sound, that may be odd, I'm not sure 
> about that, but I see no reason why what I have chosen to use, not to work, 
> I can only hope that I have missed an important note somewhere and a simple 
> answer will raise its head.  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


