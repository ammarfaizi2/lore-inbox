Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSCYBoS>; Sun, 24 Mar 2002 20:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310913AbSCYBn7>; Sun, 24 Mar 2002 20:43:59 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:61865 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S310436AbSCYBnt>;
	Sun, 24 Mar 2002 20:43:49 -0500
Date: Mon, 25 Mar 2002 12:43:18 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 04:07:31PM +0100, Danijel Schiavuzzi wrote:

> > In the meantime, I'd probably suggest a patch which looks for
> > clears only bit 7 of Rx55 if an 8363 and an 8365 is found.  I'll
> > whip one up later today.
> 
> Yes, should implement some autodetection to detect VT8365 and clear only bit 
> 7 and include it in the kernel *as soon as possible* (I don't have any kernel 
> programming experience, so don't ask me to do so, although it should be 
> something trivial ;))

I've had a quick look at the pci-pc.c file which handles the PCI
fixups, but I can't see of a way to say "if this chip is detected
_and_ that chip is detected, modify this bit in the first chip."
It's possible, but not without some real ugly hackery.

Assuming that _only_ the integrated KT133+KM133 chipset uses the
VT8365 PCI ID (0x8305), it'd be easy to make a special-case patch
for it.  My only worry is that other chipsets (like the 'normal'
KT133 without the KM133) use the same PCI ID; we should avoid
modifying the fix for the other chipsets, if possible.

Can somebody with a KT133/KT133A do a "lspci -n" and grep for
'8305'?  If it doesn't appear, I'll send off my patch.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
