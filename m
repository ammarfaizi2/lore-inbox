Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUBHAuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUBHAuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:50:03 -0500
Received: from data.idl.com.au ([203.32.82.9]:14574 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S261595AbUBHAt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:49:59 -0500
From: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Newsgroups: linux.kernel
References: <1mtPj-7oQ-3@gated-at.bofh.it> <1mwNn-1xb-27@gated-at.bofh.it>
Organization: Mullen Automotive Engineering
Date: Sun, 8 Feb 2004 11:45:18 +1100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402081145.19027.athol_SPIT_SPAM@idl.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> On Sat, Feb 07, 2004 at 05:00:18PM +1100, Athol Mullen wrote:
(Don't CC.  I read lkml via linux.kernel newsgroup.)

>> After looking through the Intel specs for the ICH5, I discovered that they 
>> specify that the BIOS is supposed to initialise bit flags for the presence 
>> of 80-core ribbon for each drive.

> that could explain why I recently discovered that a 2.4.25-rc1 on a
> supermicro MB with ICH5 was limiting hda and hdb to 30 MB/s at UDMA33 while
> an old 2.4.20 + many patches including IDE gave me about 64 MB/s at UDMA100.

Before I modified eighty_ninty_three(), it returning 0 caused the _indicated_ 
mode to drop to UDMA33.  Check in /proc/ide/piix to see what mode the driver 
tells you.  IIRC (could be wrong), dmesg and hdparm both believe it to be in 
UDMA33 while the init code and /proc/ide/piix both showed it as UDMA5.

I'm starting to wonder if my ICH5 _is_ actually running UDMA5...  It's doing 
21MB/s, which I've been blaming on the old 30G Quantum, whereas the ICH4 with 
a 120G drive is doing 56MB/s...  I think I checked the bit flags in 
/proc/ide/ide0/config and it showed up as UDMA5.

>> I'm not certain exactly how this would be implemented, but I'd like to see 
>> eighty_ninty_three() check for chipset-specific detection code, and use the 
>> existing word93 validation otherwise.

>> I have written and tested code for the intel ICH chipsets, but can't post a 
>> patch until I know where to stick it.  :-)

> well, why not in piix:piix_ratemask() around line 315 ?

I could put it there, but I was actually intending to use it to also return a 
value properly for eighty_ninty_three(), and figured that it would need to be 
a separate routine - I expect that the module structure needs to change, and 
that's where I'm not sure - it could affect _all_ ide drivers.  There might 
be others that have their own specific detection code, and what I'm looking 
to do is establish the framework for that.

Yes, there was a fairly stupid stuff-up on my part in my previous message - my 
business .sig wasn't supposed to get tacked on after my usenet .sig...  It 
_was_ a spam-free email address.  :-(

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.


