Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270312AbRHIRxR>; Thu, 9 Aug 2001 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRHIRxI>; Thu, 9 Aug 2001 13:53:08 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:21523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270312AbRHIRww>; Thu, 9 Aug 2001 13:52:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Setting up MTRRs for 4096MB RAM
Date: 9 Aug 2001 10:53:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kuils$q67$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0108091306550.18150-100000@willow.commerce.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0108091306550.18150-100000@willow.commerce.uk.net>
By author:    Corin Hartland-Swann <cdhs@commerce.uk.net>
In newsgroup: linux.dev.kernel
> 
> I am trying to set up a machine using the Tyan Tiger LE motherboard, and
> ServerWorks III LE chipset to use 4096MB RAM. I'm using kernel 2.4.7 with
> CONFIG_HIGHMEM4G.
> 
> I know that I have to set the MTRR's up to extend the cacheable memory
> area, but can't work out how to set it up.
> 
> I tried the following:
> 
>   # echo "disable=1" >| /proc/mtrr
>   # echo "disable=0" >| /proc/mtrr
>   # echo "base=0x0 size=0xFFFFFFFF type=write-back" >| /proc/mtrr
>   mtrr: size and base must be multiples of 4 kiB
>   mtrr: size: 0xffffffff  base: 0x0
> 
> Which doesn't make any sense. So I tried for 3G RAM:
> 
>   # echo "base=0x0 size=0xC0000000 type=write-back" >| /proc/mtrr
>   mtrr: base(0x0000) is not aligned on a size(0xc0000000) boundary
> 
> And then for 2G RAM:
> 
>   # echo "base=0x0 size=0x80000000 type=write-back" >| /proc/mtrr
> 
> Which works perfectly. What gives?
> 

Intel MTRRs have to be a multiple of 2, so you'd need 2 MTRRs if you
wanted to cover 3 GB.  0x80000000 is a multiple of 2; 0xC0000000
isn't, and 0xFFFFFFFF definitely isn't, although 0x100000000 is.

I'm surprised you didn't see that very pattern in your own responses:
you are entering the full size in the working case, but then subtract
1 in the 4 GB case.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
