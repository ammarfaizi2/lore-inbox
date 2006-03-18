Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWCROBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWCROBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCROBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:01:42 -0500
Received: from main.gmane.org ([80.91.229.2]:36485 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750769AbWCROBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:01:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sat, 18 Mar 2006 16:01:24 +0200
Message-ID: <dvh3rb$ui8$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.48.167
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> I didn't do anything else.  Check that your chipset has the same PCI
> ID that the patch is for.
> 

Indeed, the problem is here. If I use 
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,     PCI_ANY_ID,    
asus_hides_ac97_lpc );

(see the PCI_ANY_ID) instead of 
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,   PCI_DEVICE_ID_VIA_8237,
asus_hides_ac97_lpc );

(and remove the check "if (likely(!asus_hides_ac97)) return;")
it works. I cannot see the output about enabling the device in "dmesg | grep
PCI", but lspci shows the audio and modem device.
And it works both with the 2.6.13 suse and 2.6.15 vanilla kernel.

I managed to hang the machine completely with skype, altough before that a
quick test showed that the device works, as I could hear the music. Maybe
it's the same problem you've experienced.

Can you tell me how can I find the real device ID for my chipset? It
*should* be the same one as the original writer of the patch wrote (he also
had an ASUS A8V Deluxe as I understood), but the experience tells it is
not.
My lspci output is:
00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890
South]
00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak
378/SATA 378) (rev 02)
00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit
Ethernet Controller (rev 13)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
07)
00:0e.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem
Controller (rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500]
(rev a1)

Thanks,
Andras

-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


