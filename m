Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313633AbSDYRRy>; Thu, 25 Apr 2002 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSDYRRy>; Thu, 25 Apr 2002 13:17:54 -0400
Received: from twin.jikos.cz ([217.11.237.146]:36100 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S313633AbSDYRRx>;
	Thu, 25 Apr 2002 13:17:53 -0400
Date: Thu, 25 Apr 2002 19:15:08 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: cjtsai@ali.com.tw, <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: IDE DMA problem on ALi chipset
Message-ID: <Pine.LNX.4.44.0204251900210.1090-100000@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing quite heavy problems with DMA on IDE disks on one older 
piece of hardware. Output from /proc/pci attached at the end of mail.

If I don't turn off DMA on all IDE disks, after quite a short while after 
bootup (commonly during run of /sbin/init), I get many error messages of 
all kinds (some programs segfault, for example), and after bootup my 
console gets filled (cca 1 message per minute, not under heavy disk 
access) with such messages:

init_special_inode: bogus imode(0)

(imode followed by different numbers, but 0 is the most common).

Tried on kernel 2.4.9 from RedHat (there I get SeekError messages, instead
of those mentioned above), 2.4.16, 2.4.18, I've heard that it happens to
someone even with 2.4.19-pre7, but I haven't tested it myself yet.

After I again boot with DMA turned off, fsck complains a lot (orphaned 
inodes, orphaned linked lists, bad file attributes, etc.), after repairing 
some of the files fsck mentioned are lost forever, /lost+found is filled 
with many entries, etc).

Here is complete /proc/pci from that computer

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 5).
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 1).
      Master Capable.  No bursts.  Min Gnt=7.
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 195).
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 193).
      IRQ 14.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  16, function  0:
    Ethernet controller: Hewlett-Packard Company J2585B (rev 0).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=32.
      I/O at 0xde00 [0xdeff].
      Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffffff].

I've searched archives of LKML, but didn't find any solution. Thnaks in 
advance for your replies.

-- 
JiKos.


