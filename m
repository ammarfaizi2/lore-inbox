Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTCPAGU>; Sat, 15 Mar 2003 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbTCPAGU>; Sat, 15 Mar 2003 19:06:20 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:22400 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261764AbTCPAGS>; Sat, 15 Mar 2003 19:06:18 -0500
Date: Sun, 16 Mar 2003 09:16:22 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Complete support PC-9800 for 2.5.64-ac4 (0/11) summary
Message-ID: <20030316001622.GA1061@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.64-ac4.

Thanks for many advices and merging.
PC-9800 works fine with this patchset.
I put archived patchset URL bellow.
http://downloads.sourceforge.jp/linux98/2638/linux98-2.5.64-ac4.patch.tar.bz2

Comments and test reports are wellcome.

Description:
 o console.patch (1/11)
   PC98 Standard console support (without japanese kanji character).

 drivers/video/console/Kconfig  |   14 ++
 drivers/char/Makefile          |    4 
 drivers/char/vt.c              |   63 +++++++--
 drivers/char/console_macros.h  |    4 
 drivers/char/console_pc9800.h  |   14 ++
 drivers/char/consolemap.c      |   58 ++++++++-
 drivers/char/pc9800.uni        |  260 +++++++++++++++++++++++++++++++++++++++++
 drivers/char/vt_ioctl.c        |   19 ++
 include/linux/console.h        |   11 +
 include/linux/console_struct.h |   13 +-
 include/linux/tty.h            |    4 
 include/linux/vt.h             |    1 
 include/linux/vt_buffer.h      |    4 
 13 files changed, 450 insertions(+), 19 deletions(-)

 o core-misc.patch (2/11)
   Small patches for PC98 support core.

 include/asm-i386/io.h     |    6 ++++++
 include/asm-i386/irq.h    |    4 ++++
 include/asm-i386/pc9800.h |   27 +++++++++++++++++++++++++++
 include/linux/kernel.h    |    6 ++++++
 4 files changed, 43 insertions(+)

 o dma.patch (3/11)
   DMA support for PC98.

 include/asm-i386/dma.h         |    7 +
 include/asm-i386/pc9800_dma.h  |  238 +++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/scatterlist.h |    6 +
 kernel/dma.c                   |    3 
 4 files changed, 254 insertions(+)

 o ide.patch (4/11)
   PC98 standard IDE I/F support.

 drivers/ide/ide-disk.c  |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide.c       |    9 +++++-
 drivers/ide/ide-probe.c |   16 +++++++++--
 include/linux/hdreg.h   |   19 +++++++++++++
 4 files changed, 107 insertions(+), 4 deletions(-)

 o kanji.patch (5/11)
   japanese kanji character support for PC98 console.

 drivers/char/console_macros.h  |   10 +
 drivers/char/vt.c              |  393 +++++++++++++++++++++++++++++++++++------
 drivers/video/console/Kconfig  |    4 
 include/linux/console_struct.h |   12 +
 include/linux/consolemap.h     |    1 
 5 files changed, 369 insertions(+), 51 deletions(-)

 o kconfig.patch (6/11)
   Add selection for CONFIG_X86_PC9800.

 arch/i386/Kconfig |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

 o network_card.patch (7/11)
   C-bus(PC98's legacy bus like ISA) network cards support.

 drivers/net/8390.h       |    3 
 drivers/net/Makefile.lib |    1 
 drivers/net/ne2k_cbus.h  |  481 +++++++++++++++++++++++++
 drivers/net/Kconfig      |   55 ++
 drivers/net/Space.c      |    2 
 drivers/net/3c509.c      |   44 +-
 drivers/net/Makefile     |    1 
 drivers/net/at1700.c     |  120 +++++-
 drivers/net/ne2k_cbus.c  |  879 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1557 insertions(+), 29 deletions(-)

 o parport.patch (8/11)
   Parallel port support.

 drivers/parport/parport_pc.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletion(-)

 o pci.patch (9/11)
   Small changes for PCI support.

 arch/i386/pci/irq.c    |   27 +++++++++++++++++++++++++++
 drivers/pcmcia/yenta.c |    6 ++++++
 include/asm-i386/pci.h |    4 ++++
 3 files changed, 37 insertions(+)

 o pcmcia.patch (10/11)
   Small change for PCMCIA (16bits) support.

 drivers/pcmcia/i82365.c |    4 ++++
 1 files changed, 4 insertions(+)

 o scsi.patch (11/11)
   SCSI host adapter support.

 drivers/scsi/Kconfig     |    5 
 drivers/scsi/Makefile    |    1 
 drivers/scsi/pc980155.c  |  299 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/pc980155.h  |   52 ++++++++
 drivers/scsi/scsi_pc98.c |    2 
 drivers/scsi/sd.c        |    9 +
 drivers/scsi/wd33c93.c   |   49 +++----
 drivers/scsi/wd33c93.h   |    7 -
 8 files changed, 398 insertions(+), 26 deletions(-)


Osamu Tomita <tomita@cinet.co.jp>

