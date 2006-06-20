Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWFTVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFTVRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWFTVRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:17:24 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:26674 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751100AbWFTVRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:17:23 -0400
Date: Tue, 20 Jun 2006 14:17:23 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060620211723.GA28016@hexapodia.org>
References: <20060615162859.GA1520@hexapodia.org> <20060617100327.e752b89a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060617100327.e752b89a.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 10:03:27AM -0700, Andrew Morton wrote:
> > The PCMCIA slot on my Thinkpad X40 stopped working sometime between
> > 2.6.17-rc4-mm3 and 2.6.17-rc5-mm3, and is still not working as of
> > 2.6.17-rc6-mm2.
[snip]
> > -Probing IDE interface ide2...
> > -hde: CF Card, CFA DISK drive
> > -PM: Adding info for No Bus:ide2
> > -hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
> > +ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
> > +ide2: ports already in use, skipping probe
> > +ide2: I/O resource 0xF8A8A01E-0xF8A8A01E not free.
> > +ide2: ports already in use, skipping probe
> > +ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
> > +ide2: ports already in use, skipping probe
> 
> hm.   I don't know who to blame for this yet ;)
> 
> The contents of /proc/ioports on both kernels might be useful.  Let's see
> which device+driver is already using those ports, and whether the older
> kenrel uses the same addresses.

In further testing, -rc6 is fine while -rc6-mm2 fails.

Under 2.6.17-rc6 (after having inserted and removed the card, but that
doesn't seem to make much difference) I have

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
15e0-15ef : motherboard
1600-167f : motherboard
1680-169f : motherboard
1800-1807 : 0000:00:02.0
1810-181f : 0000:00:1f.1
  1810-1817 : ide0
  1818-181f : ide1
1820-183f : 0000:00:1d.0
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.1
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.2
  1860-187f : uhci_hcd
1880-189f : 0000:00:1f.3
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel 82801DB-ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel 82801DB-ICH4
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem
3000-7fff : PCI Bus #02
  3000-30ff : PCI CardBus #03
  3400-34ff : PCI CardBus #03
  7000-703f : 0000:02:01.0
    7000-703f : e1000

The diff between -rc6 and -rc6-mm2 shows that they have the same ioport
assignment (there's only a textual diff due to ACPI string changes).

I've put just about everything you could want to know about the two
kernels at
http://web.hexapodia.org/~adi/bobble/bobble_2.6.17-rc6_20060620093733/
and
http://web.hexapodia.org/~adi/bobble/bobble_2.6.17-rc6-mm2_20060620094254/

-andy
