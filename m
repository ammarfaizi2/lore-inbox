Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbWLTCrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWLTCrS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWLTCrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:47:18 -0500
Received: from mail.enter.net ([216.193.128.40]:17645 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964810AbWLTCrR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:47:17 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: tony mancill <tony@mancill.com>
Subject: Re: [Alsa-devel] HDA Intel sound driver fails on Acer notebook
Date: Tue, 19 Dec 2006 21:47:12 -0500
User-Agent: KMail/1.9.5
Cc: Takashi Iwai <tiwai@suse.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200612030233_MC3-1-D3BB-DE9@compuserve.com> <s5hfybcfbz8.wl%tiwai@suse.de> <45889687.5050609@mancill.com>
In-Reply-To: <45889687.5050609@mancill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200612192147.12670.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 20:48, tony mancill wrote:
> FWIW, using pci=noacpi seems to break the USB controller on this laptop.
> I get "device not accepting address xx, error -110.

Strange. I'm using an Acer Aspire 1640Z and the sound works perfectly. Of 
course Kubuntu was the only distro I could find that did OOB, but that's 
besides the point. In a quick look through /etc on my laptop I wasn't able to 
see how they do this. But after doing a quick check on Google the reports 
vary from this being a patched bug in ALSA to being easily solved by ensuring 
that the needed sound modules are loaded in the proper order.

An alternate solution to this is to load the snd-hda-intel module with the 
parameter "model=laptop"

> In addition, neither the onboard nor the wireless NIC work anymore with
> this option.  For the onboard, you see that the link is up, but then
> get "NETDEV WATCHDOG: eth0: transmit timed out."
>
> acpi=off is worse - the boot hangs trying to load acpi/thermal.ko.

>From personal experience I can say that ACPI is needed for Acer notebooks with 
the centrino chipset to function properly.

> I've tested with both 1.0.13 and and 1.0.14rc1.  I don't get exactly
> the same kernel logging (I'm using a Debian 2.6.18 kernel), but kern.log
> contains:

I had the same problem when I tried Debian on this laptop. I don't recommend 
it for laptops, since there are several common pieces of hardware found on 
laptops that need firmware not shipped by Debian. This includes the ipw2200 
firmware - which most Acer laptops need, because they ship with that wireless 
card.

> Dec 19 17:39:43 maus kernel: : hda_codec: invalid dep_range_val 0:7fff
> Dec 19 17:39:43 maus kernel: ALSA
> /home/tony/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:216: hda_codec:
> invalid dep_range_val 0:7fff Dec 19 17:39:43 maus last message repeated 279
> times
> Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0xd
> Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0x9
> Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0xd
> Dec 19 17:39:43 maus last message repeated 20 times
> Dec 19 17:39:43 maus kernel: hda_codec: num_steps = 0 for NID=0x9
>
> Thanks in advance for any assistance.  I hope you enjoyed your
> vacation.
>
> Thanks,
> tony
>
> Takashi Iwai wrote:
> > Hi,
> >
> > sorry for the late reply since I've been on vacation.
> >
> > At Sun, 3 Dec 2006 02:30:34 -0500,
> >
> > Chuck Ebbert wrote:
> >> The HDA Intel sound driver still fails to load on my Acer Aspire 5102
> >> notebook (Turion64 X2, ATI chipset):
> >>
> >> Here is the PCI info while running x86_64.  I tried i386 and x86_64 and
> >> it fails on both:
> >>
> >> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
> >>         Subsystem: Acer Incorporated [ALI] Unknown device 009f
> >>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> >> ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B-
> >> ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
> >> 64, Cache Line Size 08
> >>         Interrupt: pin ? routed to IRQ 16
> >>         Region 0: Memory at c0000000 (64-bit, non-prefetchable)
> >> [size=16K] Capabilities: [50] Power Management version 2
> >>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> >> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0
> >> PME-
> >>         Capabilities: [60] Message Signalled Interrupts: 64bit+
> >> Queue=0/0 Enable- Address: 0000000000000000  Data: 0000
> >> 00: 02 10 7b 43 06 00 10 04 01 00 03 04 08 40 00 00
> >> 10: 04 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
> >> 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 9f 00
> >> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 00 00 00
> >> 40: 00 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
> >> 50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
> >> 60: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>
> >> On i386 I get this after doing
> >>         insmod snd-hda-codec.ko ;  insmod snd-hda-intel.ko
> >>
> >> Dec  1 17:38:29 ac kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16
> >> (level, low) -> IRQ 18 Dec  1 17:38:29 ac kernel: codec_mask = 0xb
> >> Dec  1 17:38:30 ac kernel: hda_codec: PCI 1025:9f, codec config 5 is
> >> selected Dec  1 17:38:31 ac kernel: hda_intel: azx_get_response timeout,
> >> switching to polling mode... Dec  1 17:38:32 ac kernel: hda_intel:
> >> azx_get_response timeout, switching to single_cmd mode...
> >
> > These messages are scary.  It means that the communication between the
> > controller chip and the codec chip doesn't work, usually incorrect IRQ
> > handling, and often due to broken BIOS or ACPI support.  Any change if
> > you pass pci=noacpi or acpi=off boot option?
> >
> > Anyway, you can try alsa-git patch in mm tree.  It's a better support
> > code for Acer laptops, and this might work slightly differently.
> >
> >
> > Takashi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
