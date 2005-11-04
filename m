Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVKDRlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKDRlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKDRlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:41:08 -0500
Received: from www.eclis.ch ([144.85.15.72]:1196 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1750754AbVKDRlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:41:06 -0500
Message-ID: <436B9D2F.5050503@eclis.ch>
Date: Fri, 04 Nov 2005 18:41:03 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: john stultz <johnstul@us.ibm.com>, "Brown, Len" <len.brown@intel.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, macro@linux-mips.org,
       linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com> <1131077233.27168.627.camel@cog.beaverton.ibm.com> <436B8EDD.5050703@eclis.ch>
In-Reply-To: <436B8EDD.5050703@eclis.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Christian de Rivaz a écrit :

> Well, I finally get evidence that my mainboard is a "K7N2 Delta-ILSR" 
> not a "K7N2 Delta-L" (from the shipping package, the invoice, and online 
> review of the two motherboards). So the BIOS version 7.4 is a valid one. 
> I updated the BIOS to the version 7.8. Now the drift is low and ntpd 
> happy (me too), all that without the "noapic" option.
> 
> Strange is that the kernel log is almost the same but this little 
> difference:
> 
> --- kernel 2.6.14 BIOS V7.4
> +++ kernel 2.6.14 BIOS V7.8
>  talla kernel:   Normal zone: 225280 pages, LIFO batch:31
>  talla kernel:   HighMem zone: 294896 pages, LIFO batch:31
>  talla kernel: DMI 2.3 present.
> -talla kernel: ACPI: RSDP (v000 Nvidia                                ) 
> @ 0x000f73b0
> +talla kernel: ACPI: RSDP (v000 Nvidia                                ) 
> @ 0x000f73d0
>  talla kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
> 0x00000000) @ 0x7fff3000
>  talla kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
> 0x00000000) @ 0x7fff3040
> -talla kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
> 0x00000000) @ 0x7fff7780
> +talla kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
> 0x00000000) @ 0x7fff77c0
>  talla kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 
> 0x0100000e) @ 0x00000000
>  talla kernel: ACPI: PM-Timer IO Port: 0x4008
>  talla kernel: ACPI: Local APIC address 0xfee00000
> 
> The following message is still here:
> 
> talla kernel: ENABLING IO-APIC IRQs
> talla kernel: ..TIMER: vector=0x31 pin1=0 pin2=-1
> 
> But all work fine with the latest BIOS.
> 
> For me the issue is solved. A lot of thanks to all peoples that helped 
> to this thread with special mention for John Stultz. I hope that the 
> others that have the same problem can solve it the same way.

Just to show how well is the 2.6.14 with the latest BIOS, here is the 
drift according to the John Stultz python script:

04 Nov 17:45:23         offset: 1.7e-05         drift: 3.0 ppm
04 Nov 17:46:24         offset: 2e-05   drift: 0.0967741935484 ppm
04 Nov 17:47:24         offset: 2.7e-05         drift: 0.106557377049 ppm
04 Nov 17:48:24         offset: 4.8e-05         drift: 0.186813186813 ppm
04 Nov 17:49:24         offset: 6.5e-05         drift: 0.210743801653 ppm
04 Nov 17:50:24         offset: 9.4e-05         drift: 0.264900662252 ppm
04 Nov 17:51:24         offset: 0.000122        drift: 0.298342541436 ppm
04 Nov 17:52:24         offset: 0.000168        drift: 0.364928909953 ppm
04 Nov 17:53:25         offset: 0.0002  drift: 0.385093167702 ppm
04 Nov 17:54:25         offset: 0.000266        drift: 0.46408839779 ppm
04 Nov 17:55:25         offset: 0.000305        drift: 0.482587064677 ppm
04 Nov 17:56:25         offset: 0.000356        drift: 0.515837104072 ppm
04 Nov 17:57:25         offset: 0.000415        drift: 0.554633471646 ppm
04 Nov 17:58:25         offset: 0.000475        drift: 0.588761174968 ppm
04 Nov 17:59:25         offset: 0.000555        drift: 0.641755634638 ppm
04 Nov 18:00:25         offset: 0.000624        drift: 0.675526024363 ppm
04 Nov 18:01:25         offset: 0.000711        drift: 0.723779854621 ppm
04 Nov 18:02:26         offset: 0.00079         drift: 0.7578125 ppm
04 Nov 18:03:26         offset: 0.000868        drift: 0.787822878229 ppm
04 Nov 18:04:26         offset: 0.000954        drift: 0.821678321678 ppm
04 Nov 18:05:26         offset: 0.001029        drift: 0.843023255814 ppm
04 Nov 18:06:26         offset: 0.001114        drift: 0.870253164557 ppm
04 Nov 18:07:26         offset: 0.001196        drift: 0.892749244713 ppm
04 Nov 18:08:26         offset: 0.001274        drift: 0.910404624277 ppm
04 Nov 18:09:26         offset: 0.00136         drift: 0.932132963989 ppm
04 Nov 18:10:26         offset: 0.001445        drift: 0.951462765957 ppm
04 Nov 18:11:27         offset: 0.001537        drift: 0.973162939297 ppm
04 Nov 18:12:27         offset: 0.001627        drift: 0.992615384615 ppm

It's very very low, far more that with 2.6.9 kernel and old BIOS. MSI 
have obviousely fixed a timer issus in the BIOS, but this is not show in 
the BIOS history.

-- 
Jean-Christian de Rivaz
