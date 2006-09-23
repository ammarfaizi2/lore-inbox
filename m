Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWIWL2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWIWL2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWIWL2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:28:33 -0400
Received: from main.gmane.org ([80.91.229.2]:44690 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750730AbWIWL2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:28:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Matthieu CASTET" <castet.matthieu@free.fr>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 11:28:05 +0000 (UTC)
Message-ID: <ef35o5$vo4$1@sea.gmane.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	<200609230218.36894.arnd@arndb.de>
	<8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: pan 0.113 (0.113 is one of Nakata's favorites)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Sep 2006 02:50:02 -0400, Mike Frysinger wrote:


>> It would be nice if you could use a generic way to pass this partition data
>> to the kernel from the mtd medium, instead of hardcoding it here.
> 
> i often wish for such things myself :)
> 
> unfortunately, the boot loader we utilize (u-boot) isnt exactly
> friendly to the idea of managing flash partitions like redboot, and
> what we have here is the current standard method for defining flash
> partitions with mtd
> 

humm you could use cmdlinepart [1] and pass the partition as a kernel
string with uboot.

That's what we are doing and it works perfectly.


>> > +/* Clock and System Control (0xFFC0 0400-0xFFC0 07FF) */
>> > +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
>> > +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
>> > +#define bfin_read_PLL_STAT()                 bfin_read16(PLL_STAT)
>> (and 700 more of these)
>>
>> What's the point, are you getting paid by lines of code? Just use
>> the registers directly!
> 
> in our last submission we were doing exactly that ... and we were told
> to switch to a function style method of reading/writing memory mapped
> registers
hum, IRRC in your last submission you used volatile to read/write register.
Some people told you that volatile are evil and you should use a function
to read them.

But there no need to these defines. Just use bfin_read16(register_name) in
your code.

For an example look at arch/mips/au1000/common/usbdev.c for a driver using
memory mapped register.
Also you could use standard function like readl/writel if there no special
constraint (on the example a special function is needed because
readl/writel do some byteswapping on that platform (need for external
device), that is not need for memory mapped register).


Hope it will help you to improve your code.

Matthieu


[1]
see drivers/mtd/cmdlinepart.c for more information.
For example 
1 NOR Flash with 2 partitions, 1 NAND with one
 edb7312-nor:256k(ARMboot)ro,-(root);edb7312-nand:-(home)

