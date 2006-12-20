Return-Path: <linux-kernel-owner+w=401wt.eu-S964779AbWLTCRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWLTCRG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWLTCRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:17:06 -0500
Received: from dorf.mancill.com ([207.162.210.177]:42027 "EHLO
	dorf.mancill.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964779AbWLTCRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:17:05 -0500
X-Greylist: delayed 1628 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 21:17:04 EST
Message-ID: <45889687.5050609@mancill.com>
Date: Tue, 19 Dec 2006 17:48:55 -0800
From: tony mancill <tony@mancill.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] HDA Intel sound driver fails on Acer notebook
References: <200612030233_MC3-1-D3BB-DE9@compuserve.com> <s5hfybcfbz8.wl%tiwai@suse.de>
In-Reply-To: <s5hfybcfbz8.wl%tiwai@suse.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, using pci=noacpi seems to break the USB controller on this laptop.  
I get "device not accepting address xx, error -110.

In addition, neither the onboard nor the wireless NIC work anymore with
this option.  For the onboard, you see that the link is up, but then
get "NETDEV WATCHDOG: eth0: transmit timed out."

acpi=off is worse - the boot hangs trying to load acpi/thermal.ko.

I've tested with both 1.0.13 and and 1.0.14rc1.  I don't get exactly
the same kernel logging (I'm using a Debian 2.6.18 kernel), but kern.log
contains:

Dec 19 17:39:43 maus kernel: : hda_codec: invalid dep_range_val 0:7fff
Dec 19 17:39:43 maus kernel: ALSA /home/tony/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 19 17:39:43 maus last message repeated 279 times
Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0xd
Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0x9
Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0xd
Dec 19 17:39:43 maus last message repeated 20 times
Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0x9

Thanks in advance for any assistance.  I hope you enjoyed your
vacation.

Thanks,
tony

Takashi Iwai wrote:
> Hi,
> 
> sorry for the late reply since I've been on vacation.
> 
> At Sun, 3 Dec 2006 02:30:34 -0500,
> Chuck Ebbert wrote:
>> The HDA Intel sound driver still fails to load on my Acer Aspire 5102
>> notebook (Turion64 X2, ATI chipset):
>>
>> Here is the PCI info while running x86_64.  I tried i386 and x86_64 and it fails
>> on both:
>>
>> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
>>         Subsystem: Acer Incorporated [ALI] Unknown device 009f
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64, Cache Line Size 08
>>         Interrupt: pin ? routed to IRQ 16
>>         Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: [50] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>> 00: 02 10 7b 43 06 00 10 04 01 00 03 04 08 40 00 00
>> 10: 04 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 9f 00
>> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 00 00 00
>> 40: 00 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> On i386 I get this after doing
>>         insmod snd-hda-codec.ko ;  insmod snd-hda-intel.ko
>>
>> Dec  1 17:38:29 ac kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 18
>> Dec  1 17:38:29 ac kernel: codec_mask = 0xb
>> Dec  1 17:38:30 ac kernel: hda_codec: PCI 1025:9f, codec config 5 is selected
>> Dec  1 17:38:31 ac kernel: hda_intel: azx_get_response timeout, switching to polling mode...
>> Dec  1 17:38:32 ac kernel: hda_intel: azx_get_response timeout, switching to single_cmd mode...
> 
> These messages are scary.  It means that the communication between the
> controller chip and the codec chip doesn't work, usually incorrect IRQ
> handling, and often due to broken BIOS or ACPI support.  Any change if
> you pass pci=noacpi or acpi=off boot option?
> 
> Anyway, you can try alsa-git patch in mm tree.  It's a better support
> code for Acer laptops, and this might work slightly differently.
> 
> 
> Takashi
