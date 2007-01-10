Return-Path: <linux-kernel-owner+w=401wt.eu-S965105AbXAJVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXAJVUP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbXAJVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:20:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35642 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965105AbXAJVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:20:12 -0500
Date: Wed, 10 Jan 2007 13:25:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.19.2
Message-ID: <20070110212530.GJ10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.19.2 kernel.
There's a long list of fixes, not the least of which is the data
corruption fix from Linus and some security fixes:

d4ea7f9f: Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)
eaca4fd8: handle ext3 directory corruption better (CVE-2006-6053)
fe89cf78: corrupted cramfs filesystems cause kernel oops (CVE-2006-5823)
8d312ae1: ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)
54e25b04: VM: Fix nasty and subtle race in shared mmap'ed page writeback
e26353af: Fix incorrect user space access locking in mincore() (CVE-2006-4814)

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.19.1 and 2.6.19.2, as it is small enough to do so.
                                                                                
The updated 2.6.19.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris

--------

 Makefile                                       |    2 
 arch/arm/kernel/calls.S                        |   13 +
 arch/i386/kernel/apm.c                         |    6 
 arch/i386/kernel/process.c                     |    7 
 arch/i386/kernel/smpboot.c                     |    2 
 arch/ia64/kernel/process.c                     |   10 +
 arch/sparc/kernel/ioport.c                     |    3 
 arch/sparc64/kernel/isa.c                      |   20 +-
 arch/sparc64/mm/init.c                         |  147 ++++++++++++++++----
 arch/x86_64/kernel/process.c                   |    6 
 arch/x86_64/kernel/setup.c                     |    5 
 crypto/sha512.c                                |    2 
 drivers/acpi/processor_idle.c                  |   12 +
 drivers/ata/libata-core.c                      |   30 ++--
 drivers/block/aoe/aoecmd.c                     |   13 -
 drivers/block/cciss.c                          |    2 
 drivers/char/mem.c                             |   12 +
 drivers/connector/cn_proc.c                    |   11 -
 drivers/i2c/chips/ds1337.c                     |    8 -
 drivers/ieee1394/ohci1394.c                    |   21 ++
 drivers/infiniband/ulp/srp/ib_srp.c            |    2 
 drivers/infiniband/ulp/srp/ib_srp.h            |    2 
 drivers/md/Kconfig                             |    1 
 drivers/media/dvb/dvb-core/dvb_net.c           |    4 
 drivers/media/dvb/frontends/lgdt330x.c         |    6 
 drivers/media/video/cx88/cx88-cards.c          |    2 
 drivers/media/video/tuner-simple.c             |    2 
 drivers/media/video/tuner-types.c              |   14 -
 drivers/net/bonding/bond_main.c                |    2 
 drivers/net/smc911x.c                          |    2 
 drivers/net/wireless/zd1211rw/zd_ieee80211.h   |    2 
 drivers/net/wireless/zd1211rw/zd_mac.c         |   93 +++++++++---
 drivers/net/wireless/zd1211rw/zd_mac.h         |   10 -
 drivers/net/wireless/zd1211rw/zd_usb.c         |    4 
 drivers/net/wireless/zd1211rw/zd_usb.h         |   14 -
 drivers/scsi/scsi_lib.c                        |    1 
 drivers/usb/net/asix.c                         |    2 
 fs/cramfs/inode.c                              |    2 
 fs/ext2/dir.c                                  |    8 +
 fs/ext3/dir.c                                  |    3 
 fs/ext3/namei.c                                |    9 +
 fs/ramfs/file-mmu.c                            |    4 
 fs/ramfs/file-nommu.c                          |    4 
 include/asm-arm/unistd.h                       |   13 +
 include/linux/libata.h                         |    9 -
 include/linux/net.h                            |    2 
 include/media/cx2341x.h                        |    2 
 kernel/sched.c                                 |    2 
 mm/memory.c                                    |   32 ++--
 mm/mincore.c                                   |  183 ++++++++++---------------
 mm/oom_kill.c                                  |   12 -
 mm/page-writeback.c                            |   39 ++++-
 mm/rmap.c                                      |   23 +--
 mm/shmem.c                                     |    7 
 mm/vmscan.c                                    |    2 
 net/bluetooth/cmtp/capi.c                      |   39 ++++-
 net/bridge/netfilter/ebtables.c                |    3 
 net/core/pktgen.c                              |   20 ++
 net/ieee80211/softmac/ieee80211softmac_assoc.c |   14 +
 net/ieee80211/softmac/ieee80211softmac_auth.c  |    2 
 net/ieee80211/softmac/ieee80211softmac_priv.h  |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c    |    2 
 net/ipv4/devinet.c                             |    5 
 net/ipv4/udp.c                                 |   13 +
 net/ipv6/addrconf.c                            |    4 
 net/netlabel/netlabel_cipso_v4.c               |    9 +
 scripts/Kbuild.include                         |   19 +-
 sound/sparc/cs4231.c                           |   26 +--
 68 files changed, 673 insertions(+), 336 deletions(-)

Summary of changes from v2.6.19.1 to v2.6.19.2
============================================

Andy Gospodarek (1):
      bonding: incorrect bonding state reported via ioctl

Ang Way Chuang (1):
      dvb-core: fix bug in CRC-32 checking on 64-bit systems

Arjan van de Ven (1):
      x86-64: Mark rdtsc as sync only for netburst, not for core2

Badari Pulavarty (1):
      Fix for shmem_truncate_range() BUG_ON()

Chris Wright (1):
      Linux 2.6.19.2

Chuck Ebbert (1):
      ebtables: don't compute gap before checking struct type

David Hollis (1):
      asix: Fix typo for AX88772 PHY Selection

David L Stevens (1):
      IPV4/IPV6: Fix inet{,6} device initialization order.

David Miller (4):
      UDP: Fix reversed logic in udp_get_port()
      SPARC64: Fix "mem=xxx" handling.
      SPARC64: Handle ISA devices with no 'regs' property.
      SOUND: Sparc CS4231: Use 64 for period_bytes_min

David Woodhouse (1):
      NET: Don't export linux/random.h outside __KERNEL__

Dimitri Gorokhovik (1):
      ramfs breaks without CONFIG_BLOCK

Dirk Eibach (1):
      i2c: fix broken ds1337 initialization

Ed L Cashin (1):
      fix aoe without scatter-gather [Bug 7662]

Eric Sandeen (2):
      handle ext3 directory corruption better (CVE-2006-6053)
      ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)

Erik Jacobson (1):
      connector: some fixes for ia64 unaligned access errors

Georg Chini (1):
      SOUND: Sparc CS4231: Fix IRQ return value and initialization.

Hans Verkuil (2):
      V4L: Fix broken TUNER_LG_NTSC_TAPE radio support
      V4L: cx2341x: audio_properties is an u16, not u8

Herbert Xu (2):
      dm-crypt: Select CRYPTO_CBC
      sha512: Fix sha384 block size

Hugh Dickins (2):
      read_zero_pagealigned() locking fix
      fix OOM killing of swapoff

Ingo Molnar (1):
      sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code

Jan Andersson (1):
      sparc32: add offset in pci_map_sg()

Jean Delvare (1):
      V4L: cx88: Fix leadtek_eeprom tagging

John W. Linville (1):
      Revert "zd1211rw: Removed unneeded packed attributes"

Linus Torvalds (2):
      VM: Fix nasty and subtle race in shared mmap'ed page writeback
      Fix incorrect user space access locking in mincore() (CVE-2006-4814)

Marcel Holtmann (1):
      Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)

Michael Krufky (1):
      DVB: lgdt330x: fix signal / lock status detection bug

Mike Miller (1):
      cciss: fix XFER_READ/XFER_WRITE in do_cciss_request

Paul Moore (1):
      NetLabel: correctly fill in unused CIPSOv4 level and category mappings

Peter Zijlstra (1):
      Fix up page_mkclean_one(): virtual caches, s390

Phillip Lougher (1):
      corrupted cramfs filesystems cause kernel oops (CVE-2006-5823)

Robert Olsson (1):
      PKTGEN: Fix module load/unload races.

Roland Dreier (1):
      IB/srp: Fix FMR mapping for 32-bit kernels and addresses above 4G

Roman Zippel (1):
      kbuild: don't put temp files in source

Russell King (1):
      ARM: Add sys_*at syscalls

Shantanu Goel (1):
      Buglet in vmscan.c

Shaohua Li (1):
      i386: CPU hotplug broken with 2GB VMSPLIT

Stefan Richter (1):
      ieee1394: ohci1394: add PPC_PMAC platform code to driver probe

Tejun Heo (2):
      libata: handle 0xff status properly
      SCSI: add missing cdb clearing in scsi_execute()

Tim Chen (1):
      sched: remove __cpuinitdata anotation to cpu_isolated_map

Ulrich Kunitz (3):
      ieee80211softmac: Fix mutex_lock at exit of ieee80211_softmac_get_genie
      softmac: Fixed handling of deassociation from AP
      zd1211rw: Call ieee80211_rx in tasklet

Vitaly Wool (1):
      smc911x: fix netpoll compilation faliure
