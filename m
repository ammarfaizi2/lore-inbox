Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKDQkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKDQkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKDQkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:40:04 -0500
Received: from www.eclis.ch ([144.85.15.72]:1961 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1750712AbVKDQkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:40:01 -0500
Message-ID: <436B8EDD.5050703@eclis.ch>
Date: Fri, 04 Nov 2005 17:39:57 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, macro@linux-mips.org,
       linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com> <1131077233.27168.627.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131077233.27168.627.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> On Thu, 2005-11-03 at 22:44 -0500, Brown, Len wrote:
> 
>>NFORCE2 on an ACPI-enabled kernel should automatically invoke
>>the acpi_skip_timer_override BIOS workaround -- as
>>the NFORCE family of chip-sets have the timer interrupt
>>attached to pin-0, but some of them shipped with
>>a bogus BIOS over-ride telling Linux the timer is on pin-2.
>>
>>This issue is quite old -- google NFORCE2 and acpi_skip_timer_override.
>>IIR there are whole web-sites with NFORCE2
>>workarounds provided by its dedicated fans...
> 
> 
> Thanks for the info, Len. Although its odd that the Jean-Christian's
> issue appears to show up around the time the fix you mention shows up. 
> 
> Regardless, Jean-Chistian has some sever BIOS problems, so until those
> are resolved, I suggest he use the workaround (noapic) and ping us if
> the issue persists once he arrives at a supportable configuration.

Well, I finally get evidence that my mainboard is a "K7N2 Delta-ILSR" 
not a "K7N2 Delta-L" (from the shipping package, the invoice, and online 
review of the two motherboards). So the BIOS version 7.4 is a valid one. 
I updated the BIOS to the version 7.8. Now the drift is low and ntpd 
happy (me too), all that without the "noapic" option.

Strange is that the kernel log is almost the same but this little 
difference:

--- kernel 2.6.14 BIOS V7.4
+++ kernel 2.6.14 BIOS V7.8
  talla kernel:   Normal zone: 225280 pages, LIFO batch:31
  talla kernel:   HighMem zone: 294896 pages, LIFO batch:31
  talla kernel: DMI 2.3 present.
-talla kernel: ACPI: RSDP (v000 Nvidia                                ) 
@ 0x000f73b0
+talla kernel: ACPI: RSDP (v000 Nvidia                                ) 
@ 0x000f73d0
  talla kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x7fff3000
  talla kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x7fff3040
-talla kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x7fff7780
+talla kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x7fff77c0
  talla kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 
0x0100000e) @ 0x00000000
  talla kernel: ACPI: PM-Timer IO Port: 0x4008
  talla kernel: ACPI: Local APIC address 0xfee00000

The following message is still here:

talla kernel: ENABLING IO-APIC IRQs
talla kernel: ..TIMER: vector=0x31 pin1=0 pin2=-1

But all work fine with the latest BIOS.

For me the issue is solved. A lot of thanks to all peoples that helped 
to this thread with special mention for John Stultz. I hope that the 
others that have the same problem can solve it the same way.

Best regards,
-- 
Jean-Christian de Rivaz
