Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSERWJV>; Sat, 18 May 2002 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313925AbSERWJU>; Sat, 18 May 2002 18:09:20 -0400
Received: from laclinux.com ([216.254.39.66]:52649 "EHLO laclinux.com")
	by vger.kernel.org with ESMTP id <S313563AbSERWJT>;
	Sat, 18 May 2002 18:09:19 -0400
Date: Sat, 18 May 2002 16:09:24 -0600
From: G Sandine <lkml@laclinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ide cd/dvd with 2.4.19-pre8
Message-ID: <20020518160924.D4322@laclinux.com>
In-Reply-To: <Pine.LNX.4.10.10205180238160.774-100000@master.linux-ide.org> <yw1xoffdhbl3.fsf@gladiusit.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 02:42:00PM +0200, Måns Rullgård wrote:
> Is there any way to use the disk in udma5? Can there be compatibility
> problems with the disk?

I have recently been struggling with similar issues.  My troubles seem
for one thing to be related to VIA chipset problems, mentioned at
  
 http://www.tecchannel.de/hardware/817/index.html
  
With various kernels (and IDE patch versions), I see the errors you see,
and switching the kernel and/or IDE patch version makes the problem go away
(e.g. 2.4.19-pre5-ac3 is good for Promise controllers with hard disks).
Mainly, I only see the errors you report if I use both master and slave in
the primary channel on the Promise card; no troubles (except too slow)
if I use primary channel only on the Promise card, and I can do whatever
in the secondary channel (none, master, master + slave, slave).  This
holds for PDC20269 ATA 133 cards and Maxtor ATA 133 drives, or PDC2026x
ATA 100 cards and various ATA 100 drives.
  
Here are a few chipsets and what I have seen them do (all using
2.4.19-pre5-ac3 because it eliminates the errors during boot):
  
1. VIA VT8233CD south bridge (VIA KT266A chipset), ATA 100 devices
   and ATA 133 devices hanging off ATA 100 and ATA 133 Promise cards
   (respectively) are reported at udma2 by hdparm.  This is a PC2100
   AMD board.
  
2. VIA VT8233A south bridge (VIA KT333 chipset), ATA 100 devices and
   ATA 133 devices hanging off of the Promise cards are reported at
   udma5 and udma6 (respectively) by hdparm.  This is a PC2700 AMD
   board.  ATA 100 and ATA 133 devices run as they should (udma5 and
   udma6) using the onboard ATA 133 IDE (by the VT8233A chip).

3. AMD 766 south bridge (AMD 760MP chipset), ATA 133 devices are reported
   at udma6 by hdparm when hanging off of the ATA 133 Promise controller.
   This is a PC2100 AMD board.

Disk benchmarks by bonnie++ have verified that the disks are running in
modes reported by hdparm in each case.

Item 1. is particularly troubling.  I have found many references to the
tecChannel article, but I know of no solutions.
