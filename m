Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVJZNMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVJZNMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVJZNMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:12:00 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:4587 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751489AbVJZNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:12:00 -0400
Date: Wed, 26 Oct 2005 15:11:57 +0200
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sander@humilis.net, Avuton Olrich <avuton@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
Message-ID: <20051026131157.GA12963@favonius>
Reply-To: sander@humilis.net
References: <20051024014838.0dd491bb.akpm@osdl.org> <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com> <1130265540.25191.55.camel@localhost.localdomain> <20051026074824.GA7121@favonius> <1130324989.25191.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130324989.25191.78.camel@localhost.localdomain>
X-Uptime: 14:49:18 up 81 days, 13 min, 39 users,  load average: 1.25, 1.92, 2.16
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Mer, 2005-10-26 at 09:48 +0200, Sander wrote:
> > Stupid question: should EDAC work on a Via Epia board? Because I see the
> > "Detected Parity Error" messages too (and a lot of them), but figured
> > that the option is just 'not an option' :-)
> 
> The PCI parity check should work on every correctly built PCI card and
> bridge. 
> 
> > If it should work I'll be happy to send the error and lspci if that
> > helps.
> 
> Please do. I'm trying to find the common items that cause spurious pci
> errors

Via Epia MII 10000, kernel 2.6.14-rc4-mm1:

$ grep EDAC .config
# EDAC - error detection and reporting (RAS)
CONFIG_EDAC=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y


[42949380.590000] Freeing unused kernel memory: 168k freed
[42949381.350000] PCI- Detected Parity Error on 0000:00:01.0 0000:00:01.0
[42949382.350000] PCI- Detected Parity Error on 0000:00:01.0 0000:00:01.0
[42949383.350000] PCI- Detected Parity Error on 0000:00:01.0 0000:00:01.0
[42949384.350000] PCI- Detected Parity Error on 0000:00:01.0 0000:00:01.0

etc


lspci -vxx:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e7000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 23 31 06 00 30 22 00 00 00 06 00 08 00 00
10: 08 00 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e0000000-e3ffffff
	Capabilities: [80] Power Management version 2
00: 06 11 91 b0 07 01 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: 00 e4 f0 e5 00 e0 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

0000:00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at e742b000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 40000000-41fff000 (prefetchable)
	Memory window 1: 42000000-43fff000 (prefetchable)
	I/O window 0: 00001000-00001fff
	I/O window 1: 00002000-00002fff
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 20 82 00
10: 00 b0 42 e7 dc 00 00 02 00 02 05 b0 00 00 00 40
20: 00 f0 ff 41 00 00 00 42 00 f0 ff 43 00 10 00 00
30: fc 1f 00 00 00 20 00 00 fc 2f 00 00 05 01 80 07
40: 06 11 01 aa 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 12
	Memory at e7423000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 44000000-45fff000 (prefetchable)
	Memory window 1: 46000000-47fff000 (prefetchable)
	I/O window 0: 00003000-00003fff
	I/O window 1: 00004000-00004fff
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 20 82 00
10: 00 30 42 e7 dc 00 00 02 00 06 09 b0 00 00 00 44
20: 00 f0 ff 45 00 00 00 46 00 f0 ff 47 00 30 00 00
30: fc 3f 00 00 00 40 00 00 fc 4f 00 00 0c 02 80 07
40: 06 11 01 aa 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 80 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 80 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c4 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 02 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 80 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 80 00 00 00 00 00 00 00 07 03 00 00

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at e7428000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
00: 06 11 04 31 07 00 10 02 82 20 03 0c 08 20 00 00
10: 00 80 42 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 77 31 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at cc00 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 06 11 01 aa
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=256]
	Memory at e7429000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
00: 06 11 65 30 07 00 10 02 74 00 00 02 08 20 00 00
10: 01 d4 00 00 00 90 42 e7 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 02 01
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 03 08

0000:00:14.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
	Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
	Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 12
	I/O ports at d800 [size=64]
	I/O ports at dc00 [size=16]
	I/O ports at e000 [size=128]
	Memory at e742a000 (32-bit, non-prefetchable) [size=4K]
	Memory at e7400000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 48000000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 2
00: 5a 10 18 33 07 00 30 02 02 00 80 01 90 60 00 00
10: 01 d8 00 00 01 dc 00 00 01 e0 00 00 00 a0 42 e7
20: 00 00 40 e7 00 00 00 00 00 00 00 00 5a 10 18 33
30: 00 00 00 00 60 00 00 00 00 00 00 00 0c 01 04 12

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics (rev 03) (prog-if 00 [VGA])
	Subsystem: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at e5000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0
00: 06 11 22 31 07 00 30 02 03 00 00 03 00 20 00 00
10: 08 00 00 e0 00 00 00 e4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 22 31
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 02 00
