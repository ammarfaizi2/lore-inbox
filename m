Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUL3Wm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUL3Wm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUL3Wm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:42:27 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:22446 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261740AbUL3Wl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:41:58 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Thu, 30 Dec 2004 23:32:40 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412302332.40251.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please do a

 bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 Documentation/ide.txt          |    2 
 arch/i386/pci/irq.c            |    2 
 drivers/ide/ide-proc.c         |   15 ----
 drivers/ide/ide.c              |    5 -
 drivers/ide/pci/aec62xx.c      |   11 +-
 drivers/ide/pci/aec62xx.h      |    4 -
 drivers/ide/pci/alim15x3.c     |    3 
 drivers/ide/pci/amd74xx.c      |    9 +-
 drivers/ide/pci/atiixp.c       |    3 
 drivers/ide/pci/cmd64x.c       |    3 
 drivers/ide/pci/cs5530.c       |    3 
 drivers/ide/pci/cy82c693.c     |    5 -
 drivers/ide/pci/generic.c      |   15 ++--
 drivers/ide/pci/hpt34x.c       |    3 
 drivers/ide/pci/hpt366.c       |   33 ++++----
 drivers/ide/pci/hpt366.h       |    6 -
 drivers/ide/pci/it8172.c       |    5 -
 drivers/ide/pci/ns87415.c      |    3 
 drivers/ide/pci/opti621.c      |    7 -
 drivers/ide/pci/opti621.h      |    2 
 drivers/ide/pci/pdc202xx_new.c |   27 +++----
 drivers/ide/pci/pdc202xx_new.h |    6 -
 drivers/ide/pci/pdc202xx_old.c |   20 ++---
 drivers/ide/pci/pdc202xx_old.h |    6 -
 drivers/ide/pci/piix.c         |   10 +-
 drivers/ide/pci/piix.h         |    5 -
 drivers/ide/pci/rz1000.c       |    3 
 drivers/ide/pci/sc1200.c       |    3 
 drivers/ide/pci/serverworks.c  |   31 +-------
 drivers/ide/pci/serverworks.h  |    4 -
 drivers/ide/pci/sgiioc4.c      |   19 ++++-
 drivers/ide/pci/siimage.c      |    3 
 drivers/ide/pci/sis5513.c      |    3 
 drivers/ide/pci/sl82c105.c     |    3 
 drivers/ide/pci/slc90e66.c     |    3 
 drivers/ide/pci/triflex.c      |    4 -
 drivers/ide/pci/trm290.c       |    3 
 drivers/ide/pci/via82cxxx.c    |    3 
 drivers/ide/setup-pci.c        |  152 +++++++++++++++++++++++++++--------------
 include/linux/ide.h            |    6 -
 include/linux/pci_ids.h        |   24 ++++++
 41 files changed, 262 insertions(+), 215 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/12/30 1.2204)
   [patch] Intel ICH7 DID's, PIRQ and PATA support
   
   From: Jason Gaston <jason.d.gaston@intel.com>
   
   This patch adds the Intel ICH7 DID's to the pci_ids.h file
   and updates the piix driver and related files for PATA support.
   
   bart: this patch also adds PIRQ support
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2203)
   [ide] make host drivers aware of the changes made to ide_setup_pci_device{s}
   
   - nothing clever here: the most noticeable change is the change of
     returned value for (*init_setup) in struct ide_pci_device_s which
     goes from void to int. Anything else is editing and checking for
     errors in the output of the compiler;
   - pci_disable_device() added for the error path in pci_init_sgiioc4();
   - BUG() removed in amd74xx_probe(): good old printk() is enough.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2202)
   [ide] propagate the error status in ide_pci_enable/ide_setup_pci_controller
   
   - no need to overwrite the status code returned by the pci_xyz() functions;
   - jump into the new century and use DMA_32BIT_MASK;
   - misc cleanup in the error paths. It should not add a huge value in
     ide_pci_enable() due to the FIXME comment but it should not bite too hard
     either.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2201)
   [ide] clean up error path in do_ide_setup_pci_device()
   
   ide_setup_pci_controller() puts the device in a PCI enabled state.
   The patch adds a small helper to balance it when things go wrong.
   
   Actually the helper does not *exactly* balance the setup: if it can
   not do a better job, ide_setup_pci_controller() may only enable some
   BARS whereas the new counterpart will try to disable everything.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2200)
   [ide] propagation of error code in PCI IDE setup
   
   - Change the return value and the prototype of do_ide_setup_pci_device
     Due to lack of appropriate return status code, the current clients of
     do_ide_setup_pci_device() can not distinguish a failing invocation
     from a successfull one. The patch modify do_ide_setup_pci_device() so
     that it can propagate some of the errors from the lower layers.
   
   - Make ide_setup_pci_device() aware of the change and propagate the news
     itself. I only gave a quick sight to create_proc_ide_interfaces() (and
     ide_remove_proc_entries()) but they do seem sane and it should not matter
     if it fails or not.
   
   - ide_setup_pci_devices(): mostly the same thing than ide_setup_pci_device().
     do not look trivially suspect.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2199)
   [ide] fix return codes in the generic PCI IDE driver
   
   From: Alan Cox <alan@redhat.com>
   
   This patch updates ide/pci/generic.c to fix the incorrect returns
   causing PCI devices to be left reserved wrongly by the driver.
   
   From: Francois Romieu <romieu@fr.zoreil.com>
   
   Use -ENODEV instead of -EAGAIN.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/30 1.2198)
   [ide] it8172: incorrect return from it8172_init_one()
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   
   Several IDE drivers return positive values as errors in the PCI setup
   code. Unfortunately the PCI layer considers positive values as success
   so the driver skips the device but still claims it and things then go
   downhill.
   
   This fixes the IT8172 driver.
   
   From: Francois Romieu <romieu@fr.zoreil.com>
   
   Use -ENODEV instead of -EAGAIN.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/29 1.2197)
   [ide] fix cleanup_module() in ide.c
   
   DMA should be already released by ide_unregister()
   (unless interface is still busy).
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/29 1.2196)
   [ide] ide-proc: kill destroy_proc_ide_interfaces()
   
   /proc interface entries should be already unregistered
   by ide_unregister() (unless interface is still busy).
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/28 1.2195)
   [ide] serverworks: add support for CSB6 RAID
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   
   The ServerWorks chips include a RAID variant that the 2.6 driver didn't
   support. This enables support for this and removes a pile of #if and
   other pointless obfuscations. This removes the need to use various
   vendor binary only drivers for CSB6 RAID.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/28 1.2194)
   [ide] add "ide=nodma" to documentation
   
   Here's a quick patch to add the currently-undocumented ide=nodma option
   to the Documentation/ide.txt file. Since the code does not mark this
   option as obsolete as far as I can see, I can only assume that it should
   be in the documentation
   
   Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
