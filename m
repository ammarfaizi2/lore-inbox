Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbRCECqt>; Sun, 4 Mar 2001 21:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbRCECqj>; Sun, 4 Mar 2001 21:46:39 -0500
Received: from trna.ximian.com ([63.140.225.254]:61712 "EHLO trna.ximian.com")
	by vger.kernel.org with ESMTP id <S130607AbRCECq0>;
	Sun, 4 Mar 2001 21:46:26 -0500
Date: Sun, 4 Mar 2001 21:46:19 -0500 (EST)
From: Ettore Perazzoli <ettore@ximian.com>
To: linux-kernel@vger.kernel.org
cc: ettore@ximian.com
Subject: Interesting fs corruption story
Message-ID: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have been telling this story to a few people, and nobody seems to have a
clue about what is going on...  Alan suggested me to post a description of
the problem to this list, so this is what I am doing.

So, I had a Dell Inspiron 5000 which worked great for a while.  It was
running a more-or-less stock Red Hat 6.1 with the stock kernel from
it.  At some point, the hard drive in that machine was broken so I had to
buy a new one.  The new drive was an IBM Travelstar 20G.

I installed a Debian system on it, with a reiserfs root partition, which
was the only partition besides an ext2 /boot partition.  Everything seemed
to work fine, but after a while I started getting massive metadata
corruption on it.  Whenever I did an apt-get dist-upgrade, something weird
happened, such as files that couldn't be stat()ed nor unlink()ed and
directories that would make the kernel oops nicely if written to.

I could never figure out what was wrong with it.  The reiserfs people
seemed to have no clue about what was going there.

In the meantime, I got a new machine.  An IBM Thinkpad T21, which is now
my main machine.  After the previous experience, I decided to not trust
reiserfs this time, so I installed using ext2.  Again, I installed Debian
Woody.  I needed to rebuild the kernel myself as I needed the soundcard to
work, and the stock Debian one didn't even seem to have APM working, so I
installed the 2.2.18 source from Debian, configured it, and
compiled/installed using make-kpkg and dpkg.

Unfortunately, after importing 15k mail messages or so into Gnus (which is
a pretty disk-intensive activity -- I use nnml so every mail goes into a
separate file) and apt-get upgrading a couple of times, I started getting
file system corruption again.  /tmp/.X0-lock was turned into a weird file
with abnormal length and couldn't be removed, so I tried to manually force
a fsck and this resulted in a lot of problems being reported, and
lost+found getting 656 files into it.  (Some of which are files from the
Gnus mail repository, and other seem to come from TeX.)

So, this looks pretty interesting to me.  I got these metadata corruption
problems (no data corruption that I know of) on two different machines
with different hardware and different file systems.  Maybe it's a kernel
bug?

Another interesting thing is that both machines use a Travelstar 20G
drive.  Maybe the drive's firmware is to blame, but I know at least two
more people that are using that same drive on Thinkpads for quite a long
time and have had no problems at all with it.  (Using both XFS and ext2.)

Some system information: (I don't have the Ispiron at hand anymore, so I
can only be detailed about the Thinkpad)

milkplus:~# /sbin/lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 09)00:03.1 Serial controller: Xircom: Unknown device 000c
00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev
13)

milkplus:~# dmesg | grep hda
    ide0: BM-DMA at 0x1850-0x1857, BIOS settings: hda:DMA, hdb:pio
hda: IBM-DJSA-220, ATA DISK drive
hda: IBM-DJSA-220, 19077MB w/1874kB Cache, CHS=2584/240/63, UDMA
 hda: hda1 hda3 < hda5 hda6 > hda4

milkplus:~# hdparm /dev/hda
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2584/240/63, sectors = 39070080, start = 0

Any idea?  What am I doing wrong?

Thanks in advance,

-- 
Ettore
(I am not subscribed to the list, so please reply to my own address too.)

