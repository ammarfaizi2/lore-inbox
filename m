Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSDEBcY>; Thu, 4 Apr 2002 20:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSDEBcP>; Thu, 4 Apr 2002 20:32:15 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:41370 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S310654AbSDEBcD>;
	Thu, 4 Apr 2002 20:32:03 -0500
Date: Fri, 5 Apr 2002 11:31:56 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nilmoni Deb <ndeb@ece.cmu.edu>
Subject: Re: Summary of KL133/KM133 problems w/2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Nilmoni Deb <ndeb@ece.cmu.edu>
In-Reply-To: <1017915759.167695.7510.nullmailer@bozar.algorithm.com.au> <Pine.LNX.3.96L.1020404133004.7594B-100000@d-alg.ece.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Message-Id: <1017970316.478570.13925.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:23:31PM -0500, Nilmoni Deb wrote:

> 	I just now discovered from http://www.viaarena.com/?PageID=70
> that:
> 
> KM133 => VT8365 northbridge _always_
> KL133 => VT8361 northbridge _OR_ VT8364 northbridge

Ah!  Thanks for that ... viaarena.com should be definitive
(since it's an official site), and might solve the whole "my
motherboard has a VT836[1234567890xdeadbeef]" game for those
K?133 chipsets.

> Now (from kernel 2.4.18) linux-2.4.18/arch/i386/kernel/pci-pc.c has these
> comment lines:
> 
>   * VIA 8363,8622,8361 Northbridges: 
>   * - bits 5, 6, 7 at offset 0x55 need to be turned off 
> 
> It appears that ur patch doesnot affect chipsets with VT8361 northbridge.
> 
> Basically, ur patch is applicable for all KM133 (VT8365) chipsets.
> But should it apply only to those KL133 chipsets with VT8364
> northbridge or to KL133 chipsets with VT8361 northbridge too ?

The patch should apply to all KL133 chipsets; from what you've
said, that appears to be the VT8361 and VT8364.

The KM133 (VT8365) is a less clear.  From what I understand, it
has an integrated video card (ProSavage), but it also has an AGP
slot so that you can use your own video card if you like.  We
_may_ want to clear bit 5 if we're not using the integrated
ProSavage.  The only way to confirm this is to find somebody who
has a KM133 who is using an external video card, and see what the
Windows VIA drivers do.  Any volunteers?

In general though, I think we should apply the same behaviour to
the KM133 that we're using for the KL133 -- leave bit 5 alone,
and don't clear it.  All the VT836?s seem to have issues with
touching bit 5, anyway, with or without the integrated ProSavage.

> So, besides the issue of renaming two macros, this patch needs to decide
> which (or all) of the two types of KL133 chipsets is to be targeted.

The northbridge chipsets are already correctly detected (revision
IDs 0x81/0x84).  I'm taking a guess that the VT8365 is revision
ID 0x84, and either the VT8361 or VT8364 is revision ID 0x81, but
I don't know which one.  I'm not sure if finding out what's what
is that important (other than being a pedant with the macro
names), since we haven't hit anybody yet who has a KL133 with a
northbridge that is not a revision of 0x81.

In a nutshell, it's just the macro names and comments which need
to be clarified.  (Not that they're any less important.)  Thanks
for pointing out the disparity :).


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
