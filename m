Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUI0Pbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUI0Pbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUI0Pbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:31:40 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:32200 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S266366AbUI0Pb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:31:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: lkml@lpbproductions.com
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 11:31:27 -0400
User-Agent: KMail/1.7
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net> <200409270706.21661.lkml@lpbproductions.com>
In-Reply-To: <200409270706.21661.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271131.27329.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.74.116] at Mon, 27 Sep 2004 10:31:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 10:06, Matt Heler wrote:
>I can confirm the same problem here.

So I not alone, thats comforting (I think)

I just woke up, and I think the next test compile will be done without 
the pre-emptable bkl turned on.  That was the only diff in the config 
I saw when my script ran a make oldconfig, and it defaulted to a Y so 
I accepted it when it ran.

Half an hour later (mount had to e2fsck a couple BIG partitions) 

Ok, that fixed it and I'm running on it now.

That was the checkbox to make the big-kernel-lock pre-emptable that I 
unchecked in a "make xconfig".

So I guess that particular patch still needs help.

I also took this back to the lkml for others to be made aware.  But I 
wonder whats so odd about our two systems, so far, we are the only 
ones to be effected, so lets compare notes:

AMD Athlon 2800xp, biostar N7-NCD-Pro motherboard with an nforce2 
chipset, and using the forcedeth driver for eth0.  A gigabyte of 
DDR400 rated ram running in DDR333 dual channel mode, the 2800xp 
Athlon can't handle the DDR400 fsb correctly. No acpi is enabled, and 
apm only for shutdown control & rtc handling.

>On Sunday 26 September 2004 9:53 pm, Gene Heskett wrote:
>> On Sunday 26 September 2004 21:10, Andrew Morton wrote:
>> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6
>> >.9- rc2/2.6.9-rc2-mm4/
>> >
>> >- ppc64 builds are busted due to breakage in bk-pci.patch
>> >
>> >- sparc64 builds are busted too.  Also due to pci problems.
>> >
>> >- Various updates to various things.  In particular, a kswapd
>> > artifact which could cause too much swapout was fixed.
>> >
>> >- I shall be offline for most of this week.
>>
>> The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:
>>
>> Checking 'hlt' instruction... OK.
>> -----
>> 2.6.9-rc2-mm4 hangs here, and never gets to the next line
>> -----
>> NET: Registered protocol family 16
>>
>> So I assume something in the next line hangs it. Sysrq-t has no
>> repsonse, must use the hardware reset button.
>>
>> Ideas?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
