Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbUBGJRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUBGJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:17:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42254 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266754AbUBGJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:17:01 -0500
Date: Sat, 7 Feb 2004 10:15:39 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Message-ID: <20040207091539.GB29363@alpha.home.local>
References: <200402071658.43992.athol_SPIT_SPAM@OUTidl.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402071658.43992.athol_SPIT_SPAM@OUTidl.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 05:00:18PM +1100, Athol Mullen wrote:
> (Don't CC.  I read lkml via linux.kernel newsgroup.)

(sorry, it was easier to hit 'g' in mutt...)

> Specific to parallel IDE with UDMA.  Relates to code that is the same from 
> 2.4.22 to 2.6.1.
> 
> After looking through the Intel specs for the ICH5, I discovered that they 
> specify that the BIOS is supposed to initialise bit flags for the presence of 
> 80-core ribbon for each drive.  According to Intel, the OS is supposed to 
> rely upon those flags in preference to the word-93 bit.  This appears to 
> cover all ICH chipsets capable of UDMA modes that require 80-core cabling, 
> and works on both the ICH4 and ICH5 I have here.

that could explain why I recently discovered that a 2.4.25-rc1 on a supermicro
MB with ICH5 was limiting hda and hdb to 30 MB/s at UDMA33 while an old 2.4.20
+ many patches including IDE gave me about 64 MB/s at UDMA100.

I can hack piix_ratemask() to test if the limit goes away.

> I'm not certain exactly how this would be implemented, but I'd like to see 
> eighty_ninty_three() check for chipset-specific detection code, and use the 
> existing word93 validation otherwise.
> 
> I have written and tested code for the intel ICH chipsets, but can't post a 
> patch until I know where to stick it.  :-)

well, why not in piix:piix_ratemask() around line 315 ?

Cheers,
Willy

