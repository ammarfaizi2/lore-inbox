Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279808AbRKAV7t>; Thu, 1 Nov 2001 16:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279805AbRKAV7k>; Thu, 1 Nov 2001 16:59:40 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:40570 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S279802AbRKAV70>; Thu, 1 Nov 2001 16:59:26 -0500
Date: Thu, 1 Nov 2001 22:59:57 +0100
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Cc: urban@teststation.com, jgarzik@mandrakesoft.com
Subject: Re: 2.4.14-3 via-rhine lockup
Message-ID: <20011101225957.G679@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sent the following message a few days ago but I didn't see it on LKML.
Did it reach you? Anyway here it is again.

On Sun, Oct 28, 2001 at 10:32:46AM +0100, Urban Widmark wrote:
> 
> How do you generate the heavy load? (what is heavy)

I rip a CD with abcde + distmp3. Ie. my workstation (with the via-rhine
card creates the WAV files on an NFS volume and distributes the jobs of
converting them to OGG format between 6 other machines. The results are
stored ans postprocessed on the NFS volume again.

So the network load is quite high (CPU load > 3). But the NFS is not the
problem, because it also happens without using the NFS volume.

> What hardware do you have? via-rhine chip model? (dmesg/lspci -n)

AMD K6/2-400 on an ASUS P2A-B, 256 MB RAM (since I use KDE, it uses all
the RAM and 40 MB swap ;-), Matrox G450, SB Live with Alsa drivers (the
problem also occurs without the sound drivers), one IDE disk (IBM, 8 GB)
and two IDE CD-ROMs.

lspci:

00:00.0 Class 0600: 10b9:1541 (rev 04)
00:01.0 Class 0604: 10b9:5243 (rev 04)
00:02.0 Class 0c03: 10b9:5237 (rev 03)
00:03.0 Class 0680: 10b9:7101
00:07.0 Class 0601: 10b9:1533 (rev c3)
00:09.0 Class 0401: 1102:0002 (rev 08)
00:09.1 Class 0980: 1102:7002 (rev 08)
00:0a.0 Class 0200: 1106:3043 (rev 06)
00:0f.0 Class 0101: 10b9:5229 (rev c1)
01:00.0 Class 0300: 102b:0525 (rev 82)


via-diag -aaeemm before lockup:

via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3043 Rhine adapter at 0xd000.
Station address 00:40:05:a4:3d:84.
Tx enabled, Rx enabled, half-duplex (0x085a).
Receive  mode is 0x6c: Normal unicast and hashed multicast.
Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3043 Rhine chip registers at 0xd000
0x000: a4054000 206c843d 0000085a 4eff0000 80000000 00000000 03c1e090 03c1e1d0
0x020: 80000400 00000600 0c96c810 03c1e0a0 80000000 00000600 0b3d6010 03c1e0b0
0x040: 00000000 00e080a2 064c4e00 03c1e1e0 00000000 00e080a2 064c4e00 03c1e1e0
0x060: 0faa5858 064c4862 00000000 00061008 782d0100 00000080 00070000 00000000
No interrupt sources are pending (0000).
Access to the EEPROM has been disabled (0x80).
Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 40 05 a4 3d 84 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 07 00 73 73
MII PHY found at address 8, status 0x782d.
MII PHY #8 transceiver registers:
3000 782d 0181 b800 05e1 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0640 4088 6800 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000.
MII PHY #8 transceiver registers:
3000 782d 0181 b800 05e1 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0640 4088 6800 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000.
Basic mode control register 0x3000: Auto-negotiation enabled.
Basic mode status register 0x782d ... 782d.
Link status: established.
Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
Able to perform Auto-negotiation, negotiation complete.
Vendor ID is 00:60:6e:--:--:--, model 0 rev. 0.
Vendor/Part: Davicom DM9101.
I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
Advertising no additional info pages.
IEEE 802.3 CSMA/CD protocol.
Link partner capability is 0000:.
Negotiation did not complete.
Davicom vendor specific registers: 0x0640 0x4088 0x6800.
11:34:42.1074316  Baseline value of MII BMSR (basic mode status register) is 782d.


via-diag -aaeemm after lockup:

I couldn't get the output into a file but if necessary I'll try again.


> With debug=7, surely you get lots of other messages too ... ?

Yes, I didn't think they're useful... Anyway, here's an example with
debug=6:

Oct 28 18:50:49 mandel kernel: eth0: VIA Rhine monitor tick, status 0000.
Oct 28 18:50:51 mandel kernel: eth0: Transmit frame #2859171 queued in slot 2.
Oct 28 18:50:51 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:51 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:52 mandel kernel: eth0: Transmit frame #2859172 queued in slot 3.
Oct 28 18:50:52 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:52 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:52 mandel kernel: eth0: Transmit frame #2859173 queued in slot 4.
Oct 28 18:50:52 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:52 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:53 mandel kernel: eth0: Transmit frame #2859174 queued in slot 5.
Oct 28 18:50:53 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:53 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:53 mandel kernel: eth0: Transmit frame #2859175 queued in slot 6.
Oct 28 18:50:53 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:53 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:54 mandel kernel: eth0: Transmit frame #2859176 queued in slot 7.
Oct 28 18:50:54 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:50:54 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:50:59 mandel kernel: eth0: VIA Rhine monitor tick, status 0000.
Oct 28 18:51:09 mandel kernel: eth0: VIA Rhine monitor tick, status 0000.
Oct 28 18:51:13 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:13 mandel kernel:  In via_rhine_rx(), entry 2 status 00409700.
Oct 28 18:51:13 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:13 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:13 mandel kernel: eth0: Transmit frame #2859177 queued in slot 8.
Oct 28 18:51:13 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:13 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:14 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:14 mandel kernel:  In via_rhine_rx(), entry 3 status 00409700.
Oct 28 18:51:14 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:14 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:14 mandel kernel: eth0: Transmit frame #2859178 queued in slot 9.
Oct 28 18:51:14 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:14 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:15 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:15 mandel kernel:  In via_rhine_rx(), entry 4 status 00409700.
Oct 28 18:51:15 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:15 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:15 mandel kernel: eth0: Transmit frame #2859179 queued in slot 10.
Oct 28 18:51:15 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:15 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:17 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:17 mandel kernel:  In via_rhine_rx(), entry 5 status 00409700.
Oct 28 18:51:17 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:17 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:17 mandel kernel: eth0: Transmit frame #2859180 queued in slot 11.
Oct 28 18:51:17 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:17 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:18 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:18 mandel kernel:  In via_rhine_rx(), entry 6 status 00409700.
Oct 28 18:51:18 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:18 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:18 mandel kernel: eth0: Transmit frame #2859181 queued in slot 12.
Oct 28 18:51:18 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:18 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:19 mandel kernel: eth0: VIA Rhine monitor tick, status 0000.
Oct 28 18:51:19 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:19 mandel kernel:  In via_rhine_rx(), entry 7 status 00409700.
Oct 28 18:51:19 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:19 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:19 mandel kernel: eth0: Transmit frame #2859182 queued in slot 13.
Oct 28 18:51:19 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:19 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:20 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:20 mandel kernel:  In via_rhine_rx(), entry 8 status 00409700.
Oct 28 18:51:20 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:20 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:20 mandel kernel: eth0: Transmit frame #2859183 queued in slot 14.
Oct 28 18:51:20 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:20 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:21 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:21 mandel kernel:  In via_rhine_rx(), entry 9 status 00409700.
Oct 28 18:51:21 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:21 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:21 mandel kernel: eth0: Transmit frame #2859184 queued in slot 15.
Oct 28 18:51:21 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:21 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:22 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:22 mandel kernel:  In via_rhine_rx(), entry 10 status 00409700.
Oct 28 18:51:22 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:22 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:22 mandel kernel: eth0: Transmit frame #2859185 queued in slot 0.
Oct 28 18:51:22 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:22 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:24 mandel kernel: eth0: Interrupt, status 0001.
Oct 28 18:51:24 mandel kernel:  In via_rhine_rx(), entry 11 status 00409700.
Oct 28 18:51:24 mandel kernel:   via_rhine_rx() status is 00409700.
Oct 28 18:51:24 mandel kernel: eth0: exiting interrupt, status=0x0000.
Oct 28 18:51:24 mandel kernel: eth0: Transmit frame #2859186 queued in slot 1.
Oct 28 18:51:24 mandel kernel: eth0: Interrupt, status 0002.
Oct 28 18:51:24 mandel kernel: eth0: exiting interrupt, status=0x0000.


> After it stops working, do you still get log messages from it?
> Including via_rhine_rx()?

Yes, the above output is from the non-working state.

Thanks a lot,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
