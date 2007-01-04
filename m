Return-Path: <linux-kernel-owner+w=401wt.eu-S1750964AbXADTR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXADTR2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXADTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:17:28 -0500
Received: from mga07.intel.com ([143.182.124.22]:8994 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbXADTR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:17:27 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 14:17:26 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,239,1165219200"; 
   d="diff'?scan'208"; a="165267554:sNHT24886036"
Message-ID: <459D5079.70605@linux.intel.com>
Date: Thu, 04 Jan 2007 22:07:37 +0300
From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de>
In-Reply-To: <45999C47.40204@rrz.uni-koeln.de>
Content-Type: multipart/mixed;
 boundary="------------010109000209040408080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109000209040408080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Berthold Cogel wrote:
> Adrian Bunk schrieb:
>   
>> On Tue, Dec 26, 2006 at 01:15:38AM +0100, Berthold Cogel wrote:
>>
>>     
>>> Hello!
>>>       
>> Hi Berthold!
>>
>>     
>>> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
>>> with linux-2.6.20-rc kernels. The system reboots instead.
>>> I've checked linux-2.6.19.1 with an almost identical .config file
>>> (differences because of new or changed options). For pre 2.6.20 kernels
>>> shutdown works for my computer.
>>> ...
>>>       
>> Thanks for your report.
>>
>> Please send:
>> - the .config for 2.6.20-rc2
>> - the output of "dmesg -s 1000000" with 2.6.20-rc2
>> - the output of "dmesg -s 1000000" with 2.6.19
>>
>>     
>>> Regards,
>>>
>>> Berthold Cogel
>>>       
>> cu
>> Adrian
>>
>>     
>
> Hello Adrian,
>
> I've attached the informations you requested.
>
> In additon to the poweroff problem I see a lot of messages with
> linux-2.6.20-rc2 that I do not see with linux-2.6.20-rc1:
>
> kernel: ACPI: EC: evaluating _Q80
> kernel: ACPI: EC: evaluating _Q81
> kernel: ACPI: EC: evaluating _Q09
> kernel: ACPI: EC: evaluating _Q20
>
> I'm running Debian testing/unstable with 'homemade' kernels. The laptop
> is one of those using the Smart Battery System.
>
>
> Berthold
>   
Well, I see a lot of differences not related to ACPI...
20c3
Processor caps differ...
< CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 
00000180 00000000 00000000
---
 > CPU: After all inits, caps: afe9f9bf 00000000 00000000 00002040 
00000180 00000000 00000000

Prefetch for PCMCIA differ
68,69c52,53
<   PREFETCH window: 50000000-51ffffff
<   MEM window: 54000000-55ffffff
---
 >   PREFETCH window: 50000000-53ffffff
 >   MEM window: 58000000-5bffffff
73c57
<   PREFETCH window: 50000000-52ffffff
---
 >   PREFETCH window: 50000000-55ffffff

This one is new as well...
168a156
 > Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06

Berthold,
Could you please check if disabling PCMCIA changes situation?

Regards,
    Alex.



--------------010109000209040408080209
Content-Type: text/x-patch;
 name="dmesg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.diff"

1,18c1
< e entries: 4096 (order: 12, 16384 bytes)
< Console: colour VGA+ 80x25
< Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
< Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
< Memory: 1035160k/1047424k available (1690k kernel code, 11716k reserved, 575k data, 176k init, 129920k highmem)
< virtual kernel memory layout:
<     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
<     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
<     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
<     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
<       .init : 0xc033a000 - 0xc0366000   ( 176 kB)
<       .data : 0xc02a6982 - 0xc03368d0   ( 575 kB)
<       .text : 0xc0100000 - 0xc02a6982   (1690 kB)
< Checking if this processor honours the WP bit even in supervisor mode... Ok.
< Calibrating delay using timer specific routine.. 3199.22 BogoMIPS (lpj=6398450)
< Mount-cache hash table entries: 512
< CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
< CPU: L1 I cache: 32K, L1 D cache: 32K
---
> he: 32K
20c3
< CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
---
> CPU: After all inits, caps: afe9f9bf 00000000 00000000 00002040 00000180 00000000 00000000
38d20
< PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
40a23,24
> PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
68,69c52,53
<   PREFETCH window: 50000000-51ffffff
<   MEM window: 54000000-55ffffff
---
>   PREFETCH window: 50000000-53ffffff
>   MEM window: 58000000-5bffffff
73c57
<   PREFETCH window: 50000000-52ffffff
---
>   PREFETCH window: 50000000-55ffffff
110a95
> ACPI: EC: evaluating _Q80
117a103
> 
141c127
< device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
---
> device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
145a132
> input: AT Translated Set 2 keyboard as /class/input/input0
149,150c136
< Freeing unused kernel memory: 176k freed
< input: AT Translated Set 2 keyboard as /class/input/input0
---
> Freeing unused kernel memory: 168k freed
152c138,139
< Real Time Clock Driver v1.12ac
---
> ACPI: EC: evaluating _Q09
> ACPI: EC: evaluating _Q80
156d142
< input: PC Speaker as /class/input/input1
161a148,149
> ACPI: EC: evaluating _Q81
> input: PC Speaker as /class/input/input1
166d153
< ieee1394: Initialized config rom entry `ip1394'
168a156
> Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
172,174c160
< pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x52ffffff
< ACPI: PCI Interrupt 0000:02:06.2[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
< ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d020a000-d020a7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
---
> pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x55ffffff
177,178c163,164
< irda_init()
< NET: Registered protocol family 23
---
> ieee1394: Initialized config rom entry `ip1394'
> ACPI: PCI Interrupt 0000:02:06.2[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
188,189c174,175
< hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
< Uniform CD-ROM driver Revision: 3.20
---
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d020a000-d020a7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> Real Time Clock Driver v1.12ac
198a185,188
> irda_init()
> NET: Registered protocol family 23
> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
225,227d214
< IrDA: Registered device irda0
< nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
< ACPI: PCI Interrupt 0000:02:06.3[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
229a217,218
> IrDA: Registered device irda0
> nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
234c223,224
< intel8x0_measure_ac97_clock: measured 54163 usecs
---
> ACPI: EC: evaluating _Q80
> intel8x0_measure_ac97_clock: measured 54154 usecs
235a226
> ACPI: PCI Interrupt 0000:02:06.3[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
237a229
> Adding 1951856k swap on /dev/hda10.  Priority:-1 extents:1 across:1951856k
244d235
< Adding 1951856k swap on /dev/hda10.  Priority:-1 extents:1 across:1951856k
245a237
> ACPI: EC: evaluating _Q81
250d241
< acpi-cpufreq: CPU0 - ACPI performance management activated.
260c251
< ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kdmprq
---
> ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kdmprq
266a258
> ACPI: EC: evaluating _Q80
281a274
> ACPI: EC: evaluating _Q81
284a278
> ACPI: EC: evaluating _Q80
285a280,289
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
286a291
> input: Power Button (FF) as /class/input/input4
287a293
> input: Lid Switch as /class/input/input5
288a295
> input: Sleep Button (CM) as /class/input/input6
296c303,312
< ACPI: Thermal Zone [THRM] (56 C)
---
> ACPI: Thermal Zone [THRM] (52 C)
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q81
308a325
> [drm] Initialized drm 1.1.0 20060810
312d328
< [drm] Initialized drm 1.0.1 20051102
314,317d329
< mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
< mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
< mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
< mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
323a336,344
> ACPI: EC: evaluating _Q09
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20
> ACPI: EC: evaluating _Q20

--------------010109000209040408080209--
