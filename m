Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRJNPoG>; Sun, 14 Oct 2001 11:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275573AbRJNPn5>; Sun, 14 Oct 2001 11:43:57 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:640 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S275568AbRJNPnw>;
	Sun, 14 Oct 2001 11:43:52 -0400
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200110141544.f9EFiGN01608@meduna.org>
Subject: USB stability - possibly printer related
To: linux-kernel@vger.kernel.org
Date: Sun, 14 Oct 2001 17:44:16 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to ask whether anyone is using USB printer
support in recent kernels and with what results.


I had quite bad crashes on my fresh Mandrake 8.1 installation,
one of them was so bad that it brought the filesystem into
a FUBAR state - I had to reinstall. I strongly suspect the
USB part of the kernel to be responsible for this.

My hardware:
Abit BP6 motherboard, 2 x Celeron, 512 MB RAM, IBM DJNA-371350
disk on the classic controller, IBM IC35L040AVER07-0 disk on the
HPT 366 controller, root USB hub on the 440BX chipset,
"noname" USB hub, HP PSC 750 printer/scanner/copier connected
to the hub, no other switched-on USB devices at the time
of my experiments (otherwise I have Compaq iPAQ PocketPC
and HP 315 digital camera; the camera works quite OK under
Linux with usb-storage).

Before anyone suspects the hardware: I have _zero_ problems with
the HPT 366 (I have my /home there, doing compiles there etc),
I don't have APIC problems more often than is "normal" on the BP6
(one in several days) and just to be sure I checked memory with
memtest86 and disk drives with the vendor tools. The machine
dual boots with W2K, which also run reliably - I have both system
and data on the disk on the HPT. I am using the newest BIOS
available for the mobo.

Incidentally the W2K also has problems with the printer and
I must switch all the devices on in the correct order, otherwise
I get bluescreen, but this is probably due to a crappy HP driver
and I don't think that it is relevant for Linux problems.

The filesystems are ext2 and I am using the hpoj OfficeJet
software included in the Mandrake distribution to communicate
with the printer.


Unfortunately the problems are not 100% reproducible - sometimes
it works, sometimes it does not. Some datapoints collected so far:

- The most frequent symptom is a lockup - I send something
  to the printer, it prints a few lines and then the machine
  locks up - no mouse reaction etc. SysRq does work, but
  despite sync - unmount - boot sequence I get some fs problems
  on the subsequent reboot.

- I have problems with both Mandrake's kernel (heavily patched
  2.4.8) and vanilla 2.4.12

- It does not matter whether I use uhci or usb-uhci

- It does not seem to be a SMP issue (or at least not only a SMP
  issue), uniprocessor kernel also did have problems

- The worst crash had another symptoms shortly before - a few Oopsen
  in processes completely unrelated to printing (unfortunately
  the Oops data were lost after the fs exitus :-() and messages
  stating that some processes cannot be started.

- I got a corruption of the files that were surely _not_
  opened for writing.

- At least one another person on a local mailing list got
  very similar problem - loaded USB modules, got a lockup and lost
  sd_mod and /usr/bin/kdeinit - this time not with a printer, but
  using usb-storage (which needs sd_mod)


I am an experienced Linux user and I am willing to test suggested
patches etc (just allow some delays, I usually have time for Linux
on weekends only). I am however no kernel guru and I am afraid
I cannot help in active searching for the bug in the code myself.

I already posted to the linux-usb mailing list, but got no response.
I reported the problem also on the Mandrake Bugzilla - the 8.1
is probably the first distribution that brings the USB printing
very close to the user (in another distros it requires more action
and a knowledgeable person to set up a USB printing). If there
are more cases like mine, this can harm Linux in general :-(


A related question: As I stated before also files that were not
written to, but were opened short before the lockup, got corrupted.
This was not my experience with Linux and ext2 before, actually
I found the ext2 quite resistant to corruptions resulting from the
lockups - whether induced by experimenting with some drivers, or
a few powerfails. Now I had one crash destroying the filesystem
and at least one another requiring manual fsck. Is this quite normal
(and my good experience was a statistical deviation), or does this
also suggest a memory corruption occuring somewhere? I don't quite
get how a r/o file can get corrupted in the case of lockup - yes,
the inode is modified because of atime update, but the new
data either are written, or do not make it to the disk - both
cases should not cause a corruption.

Please, Cc: replies to me - I read l-k irregularly.


Regards
-- 
                                 Stano

