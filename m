Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132937AbQLHVfo>; Fri, 8 Dec 2000 16:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132870AbQLHVff>; Fri, 8 Dec 2000 16:35:35 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:2287 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S132883AbQLHVfa>;
	Fri, 8 Dec 2000 16:35:30 -0500
Date: Fri, 8 Dec 2000 16:09:47 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus
Message-ID: <Pine.LNX.4.10.10012081558000.797-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
> Clayton Weaver wrote: 
>>> 
>> Shouldn't the setting of the CSR0 value for x86 switch between normal 
>> (0x01A08000) and cautious (0x01A04800) based on some notion of 
>> what generation of pci bus is installed rather than what cpu the kernel 
>> is compiled for? 

No, you misunderstand the reason for that code.  It's not based on the PCI
bus version.  It's to work-around a specific bug in the Intel chipset
used on 486 PCI motherboards such as the Asus SP3 and SP3G.

The best way to check for this buggy chipset was to check for a 486
processor.  There are very few 486 chips on non-buggy motherboards, and the
performance impact of shorter PCI bursts is minimal given the slow speed of
the 486.

>> That's one thing that bothered me about the method that the .90 driver 
>> used. It worked for me, of course, cool, but when I thought about putting 

I put the check in the old drivers because the SP3 was a common motherboard
"way back in the old days".  The check was removed becaues the kernel
changes and removed the variable that held the processor architecture.

>> If the pci bus level is 2.0, it makes sense to use the cautious CSR0 
>> setting, for the same reasons that the .90 tulip.c in 2.0.38 does, and if 
>> the pci level is 2.1, you aren't taking any chances with 0x01A08000 that 
>> the driver doesn't take now. The pci driver, initialized before any 
>> pci devices, appears to know whether you have a pci 2.0 or pci 2.1 bus, so 
>> why not use that information instead of cpu generation? 
>
>A good suggestion, too... Some other hardware behaves differently 
>based on PCI bus version, it would be nice for the driver to notice that 
>and enable (or disable) advanced features. To blindly assume is just a 
>PCI bus lockup waiting to happen... 

Just in case you didn't catch it: this is not a PCI v2.0 vs. v2.1 issue.
The older Tulips work great with PCI v2.0 and v2.1.  The bug is with longer
bursts and a specific i486 chipset/motherboard.


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
