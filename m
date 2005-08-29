Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVH2ARc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVH2ARc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVH2ARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:17:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750972AbVH2ARb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:17:31 -0400
Date: Sun, 28 Aug 2005 17:17:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.13
Message-ID: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There it is. 

The most painful part of 2.6.13 is likely to be the fact that we made x86
use the generic PCI bus setup code for assigning unassigned resources.  
That uncovered rather a lot of nasty small details, but should also mean
that a lot of laptops in particular should be able to discover PCI devices
behind bridges that the BIOS hasn't set up.

We've hopefully fixed up all the problems that the longish -rc series
showed, and it shouldn't be that painful, but if you have device problems,
please make a report that at a minimum contains the unified diff of the
output of "lspci -vvx" running on 2.6.12 vs 2.6.13. That might give us
some clues.

The changes since -rc7 are pretty small, full shortlog and diffstat of
that appended.

As to the new world order: I'm actually going to be away for most of next
week, but in general we should now try to do all major merges within the
first two weeks of the release. After that, we go into calm-down mode, and 
if you have work that didn't make the cut, you get to wait until 2.6.14. 

The plan is that this should bring in the time between releases, so that 
even stuff that misses the deadline won't have to wait _too_ long for the 
next one.

		Linus

----
Al Viro:
  bogus iounmap() in emac
  bogus function type in qdio
  late spinlock initialization in ieee1394/ohci
  mmaper_kern.c fixes [buffer overruns]

Alexey Dobriyan:
  drivers/hwmon/*: kfree() correct pointers
  zfcp: fix compilation due to rports changes

Andi Kleen:
  x86_64: update defconfig - reenable fusion
  x86_64: Tell VM about holes in nodes

Andreas Herrmann:
  zfcp: add rports to enable scsi_add_device to work again

Andreas Schwab:
  m68k: fix broken macros causing compile errors

Anton Blanchard:
  ppc64: Fix issue with gcc 4.0 compiled kernels

Benjamin Herrenschmidt:
  ppc64: Export machine_power_off for therm_pm72 module

Deepak Saxena:
  arm: fix IXP4xx flash resource range

Eric W. Biederman:
  acpi_shutdown: Only prepare for power off on power_off

Heiko Carstens:
  zfcp: bugfix and compile fixes

James Bottomley:
  Fix oops in sysfs_hash_and_remove_file()

James Morris:
  Fix capifs bug in initialization error path.

Jan Blunck:
  sg.c: fix a memory leak in devices seq_file implementation

Jean Delvare:
  hwmon: Off-by-one error in fscpos driver

Jens Axboe:
  cfq-iosched.c: minor fixes

John McCutchan:
  Document idr_get_new_above() semantics, update inotify

Keith Owens:
  Export pcibios_bus_to_resource

Linus Torvalds:
  Only pre-allocate 256 bytes of cardbio IO range
  Ignore disabled ROM resources at setup
  Merge HEAD from master.kernel.org:/.../davem/net-2.6.git 
  Merge refs/heads/upstream-fixes from master.kernel.org:/.../jgarzik/netdev-2.6 
  Linux v2.6.13

Marcelo Tosatti:
  ppc32 8xx: fix m8xx_ide_init() #ifdef

Mark M. Hoffman:
  I2C hwmon: kfree fixes

Michael Chan:
  [TG3]: Fix ethtool loopback test lockup

NeilBrown:
  md: create a MODULE_ALIAS for md corresponding to its block major number.
  md: clear the 'recovery' flags when starting an md array.

Paolo 'Blaisorblade' Giarrusso:
  Fixup symlink function pointers for hppfs [for 2.6.13]
  hppfs: fix symlink error path

Patrick Boettcher:
  fix for race problem in DVB USB drivers (dibusb)

Patrick McHardy:
  [FIB_TRIE]: Don't ignore negative results from fib_semantic_match

Paul Jackson:
  cpu_exclusive sched domains build fix
  undo partial cpu_exclusive sched domain disabling
  completely disable cpu_exclusive sched domain

Paul Mackerras:
  Remove race between con_open and con_close

Ralf Baechle:
  6pack Timer initialization
  Fix 6pack setting of MAC address

Roland Dreier:
  IB: fix use-after-free in user verbs cleanup

Steve French:
  Fix oops in fs/locks.c on close of file with pending locks

----
 Makefile                                  |    2 +
 arch/arm/mach-ixp4xx/coyote-setup.c       |    2 +
 arch/arm/mach-ixp4xx/gtwx5715-setup.c     |    2 +
 arch/arm/mach-ixp4xx/ixdp425-setup.c      |    2 +
 arch/ia64/pci/pci.c                       |    1 +
 arch/ppc/syslib/m8xx_setup.c              |    2 +
 arch/ppc64/kernel/setup.c                 |    2 +
 arch/sparc64/kernel/pci.c                 |    1 +
 arch/um/drivers/mmapper_kern.c            |   41 ++++++-----------------------
 arch/x86_64/defconfig                     |   21 +++++++++------
 arch/x86_64/kernel/e820.c                 |   34 ++++++++++++++++++++++++
 arch/x86_64/mm/init.c                     |   16 ++++++++---
 arch/x86_64/mm/numa.c                     |    8 +++++-
 drivers/acpi/sleep/poweroff.c             |    6 ++++
 drivers/block/cfq-iosched.c               |   31 +++++++++++++++-------
 drivers/char/vt.c                         |    2 +
 drivers/hwmon/adm1026.c                   |    4 +--
 drivers/hwmon/adm1031.c                   |    4 +--
 drivers/hwmon/adm9240.c                   |    2 +
 drivers/hwmon/fscpos.c                    |    2 +
 drivers/hwmon/smsc47b397.c                |    2 +
 drivers/hwmon/smsc47m1.c                  |    2 +
 drivers/ieee1394/ohci1394.c               |    8 +++++-
 drivers/infiniband/core/uverbs_main.c     |    3 +-
 drivers/isdn/capi/capifs.c                |    4 ++-
 drivers/md/md.c                           |    2 +
 drivers/media/dvb/dvb-usb/dibusb-common.c |   19 ++++++++++---
 drivers/media/dvb/dvb-usb/dvb-usb-dvb.c   |    5 ++--
 drivers/net/hamradio/6pack.c              |    9 ++----
 drivers/net/ibm_emac/ibm_emac_core.c      |    2 +
 drivers/net/tg3.c                         |    6 +---
 drivers/pci/setup-bus.c                   |    2 +
 drivers/pci/setup-res.c                   |    4 ++-
 drivers/s390/cio/qdio.c                   |    2 +
 drivers/s390/scsi/zfcp_aux.c              |   28 ++++----------------
 drivers/s390/scsi/zfcp_ccw.c              |   10 +++++++
 drivers/s390/scsi/zfcp_def.h              |    2 +
 drivers/s390/scsi/zfcp_erp.c              |   25 ++++++++++++++++--
 drivers/s390/scsi/zfcp_ext.h              |    2 +
 drivers/s390/scsi/zfcp_fsf.c              |    1 +
 drivers/s390/scsi/zfcp_scsi.c             |   25 ++++++++++++++----
 drivers/s390/scsi/zfcp_sysfs_port.c       |    2 -
 drivers/scsi/sg.c                         |   13 ++++-----
 fs/cifs/file.c                            |    2 +
 fs/hppfs/hppfs_kern.c                     |   30 ++++++++-------------
 fs/inotify.c                              |    2 +
 fs/sysfs/inode.c                          |    4 +++
 include/asm-m68k/page.h                   |    6 ++--
 include/asm-ppc64/bug.h                   |    7 +++--
 include/asm-x86_64/e820.h                 |    2 +
 kernel/cpuset.c                           |   30 +++++++++------------
 lib/idr.c                                 |    2 +
 net/ipv4/fib_trie.c                       |   14 +++++-----
 53 files changed, 277 insertions(+), 185 deletions(-)
