Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRHWRuc>; Thu, 23 Aug 2001 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHWRuV>; Thu, 23 Aug 2001 13:50:21 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:21262 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S269257AbRHWRuL>;
	Thu, 23 Aug 2001 13:50:11 -0400
Date: Thu, 23 Aug 2001 11:50:24 -0600
From: Val Henson <val@nmt.edu>
To: "Victoria W." <wicki@terror.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart.o and intel i810-chipset
Message-ID: <20010823115024.L16829@boardwalk>
In-Reply-To: <Pine.LNX.4.10.10108210734370.27906-100000@csb.terror.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10108210734370.27906-100000@csb.terror.de>; from wicki@terror.de on Tue, Aug 21, 2001 at 07:59:43AM +0200
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you do figure out what's wrong, you might want to add your
solution to Toby Russell's i810 howto:

http://www.linuxdoc.org/HOWTO/i810-HOWTO/

-VAL

On Tue, Aug 21, 2001 at 07:59:43AM +0200, Victoria W. wrote:
> hi all,
> 
> since 2 weeks I can't get the agpgrat-module working on my
> intel-i810-chipset:
> 
> 00:00.0 Host bridge: Intel Corporation: Unknown device 7124 (rev 03)
> 00:01.0 VGA compatible controller: Intel Corporation: Unknown device 7125
> (rev 03)
> 
> I can't find the reason of the initial-error while loading agpgart.
> ("no supported devices found"). I made some tests and changes to
> the module-source but I need some background-information and don't know
> where to find them.
> 
> In the driver, there is no case-statement for 
> "PCI_DEVICE_ID_INTEL_810_E_1" like the
> one for "PCI_DEVICE_ID_INTEL_810_E_0" but the one for "810_E_0" searches
> for "PCI_DEVICE_ID_INTEL_810_E_1".
> 
>                 case PCI_DEVICE_ID_INTEL_810_E_0:
>                         i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
>                                              PCI_DEVICE_ID_INTEL_810_E_1,
>                                                    NULL);
> 
> I copied this to a new case-statement:
> 
>         case PCI_DEVICE_ID_INTEL_810_E_1:
>         .....   
>         return intel_i810_setup(i810_dev);
> 
> but on loading of the module I get a kernel-oops in
> 
>       if ((INREG32(intel_i810_private.registers, I810_DRAM_CTL)
>            & I810_DRAM_ROW_0) == I810_DRAM_ROW_0_SDRAM) {
>         ....
> 
> 
> Do you have any hints for me?
> I have no experience in kernel-driver development but I'll try to get the
> driver working. 
> Can you tell me, where to find some other usefull information? (I have the
> intel-datasheets, but I'm not shure, if it is a chipset-problem, a bug
> or just a typo in the driver).
> Is here anybody who has an i810-chipset with a working agpgart-driver?
> Please send me an "lspci-listing" an the messages while loading the
> driver. I want to find out the difference to my chipset.
> 
> Thank you in advance
> 
> best regards
> wicki
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
