Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTLMFw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 00:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLMFw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 00:52:59 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:29351 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S264456AbTLMFwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 00:52:47 -0500
Date: Fri, 12 Dec 2003 23:04:46 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ross Dickson <ross@datscreative.com.au>
Cc: AMartin@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031213060446.GA1424@tesore.local>
References: <200312131516.51777.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312131516.51777.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 03:16:51PM +1000, Ross Dickson wrote:
> I wonder about the "voodoo" because my apic ack delay patch was developed
> without knowledge of the C1 disconnect bit and reports I have received so far
> are that the hard lockups go away when using it independent of the state of the 
> disconnect bit. Apparently the bit was on in my test systems. 
> 
> Ian Kumlien pointed out the linkage with the northbridge timing signals 
> to the CPU to do with the connect disconnect handshake 

This is what the item help for C1 Disconnect in my BIOS said:
 "Force En/Disabled
  or Auto mode:
  C17 IGP/SPP NB A03
  C18D SPP NB A01 (C01)
  enabled C1 disconnect
  otherwise disabled it"

I was thinking NB referred to northbridge.  SPP is the type of NForce chip.  IGP would be a graphics chip(?), though this board don't have that.

So yes, we do have at least some relationship with the northbridge and disconnect.  This BIOS update probably addressed that, and the BIOS changelog is just a summary.

> so I now wonder just how
> programmable the nforce2 northbridge is? Is it a bit fpga'ish in that they may be
> using the bios boot to alter the handshake timing enough to accomplish what
> the ack delay does but like it should be - transparent to the OS?

Probably.  That's what I'm thinking too now.

> 
> Of course they -the makers- have access to knowledge we don't so it could be 
> something completely different that they are doing!
> 
> In short I agree with the suggestion that the new bios options do more behind
> the scenes than what the athcool and disconnect patches do. 

That's why I'm trying to contact shuttle.

> 
> I am pretty sure that I read somewhere that when the epox boards 
> were first released the epox 8rda bios started out with it (the disconnect bit) off
> then the 8rga+ came out with it on by default? So back then people were wanting
> to turn it on in the 8rda to lower their CPU temperature - now some want it off
> in search of stability? 

Ah, that reminds me.  The very first day I ran this board last week, I was very worried on how high the system temperature was getting -- above 40 deg C.  CPU was getting up to 49 deg C.  Not that it was locking up because of temperature - it would on a cold-boot - but that I was experiencing lock ups and higher than normal temperatures which indicates to me now on how poorly it's thermal management was operating then.  Now with the new patches, and ultimately, BIOS update, system temperature is about 35 deg C, which aint too bad =)

> Back then under win.... some experienced lockups depending
> on which IDE driver was used and which state the bit was in!

Good point!  I was reading some message boards discussing nforce2s yesterday.  And they pretty much unaminiously said, don't use NForce IDE driver, use windows provided IDE driver, because the NForce IDE _locks up_.  So windows does have the same problem after all.  I wouldn't know because I don't have windows... but you can find this same issue everywhere then.

> 
> Out of interest has anyone seen new disconnect bit options in the Pheonix bios or
> only in the award bios?

I have an award bios.

> 
> Finally I have done some more work and found that the ack delay patch on my
> system is about 13 apic timer counts, about half that required to write a byte 
> directly outb(0x00, 0x378) to the printer port at 28 apic timer counts. 
> So the ack delay is about twice as quick as writing a single EOI to the 8259 in
> XTPIC mode provided the 8259 accesses are not souped up under the hood.
> In other words whilst it is a timing hit it is not much of one and it won't be
> needed once this is all fixed by the respective manufacturers -lets hope they
> can do it on the hardware we have already bought.
> 
> Regards
> Ross Dickson
> 
> 

Good work.  Lets hope the hardware manufacturers come through.

Jesse
