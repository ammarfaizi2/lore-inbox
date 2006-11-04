Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWKDCJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWKDCJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 21:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWKDCJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 21:09:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50078 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750714AbWKDCJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 21:09:47 -0500
Date: Fri, 3 Nov 2006 18:11:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.2
Message-ID: <20061104021118.GX5881@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.18.1 and 2.6.18.2, as it is (barely) small enough to do so.
                                                                                
The updated 2.6.18.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     
(note: the main -stable git tree update will lag a half-day or so for this one, 
use git://git.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.18.y.git for 
now)                                                                            

thanks,
-chris

--------

 Makefile                                    |    2 
 arch/i386/Kconfig.cpu                       |    3 
 arch/i386/kernel/alternative.c              |    4 
 arch/powerpc/Kconfig                        |    9 +
 arch/powerpc/configs/pseries_defconfig      |    1 
 arch/s390/Kconfig                           |    4 
 arch/s390/lib/Makefile                      |    1 
 arch/s390/lib/div64.c                       |  151 ++++++++++++++++++++++
 arch/sparc64/kernel/central.c               |    4 
 arch/sparc64/kernel/of_device.c             |   33 +++-
 arch/sparc64/kernel/pci_common.c            |   29 +---
 arch/sparc64/kernel/pci_iommu.c             |    2 
 arch/sparc64/kernel/pci_sabre.c             |   23 ++-
 arch/sparc64/kernel/prom.c                  |   30 ++--
 arch/um/include/kern_util.h                 |    1 
 arch/um/os-Linux/sys-i386/tls.c             |    2 
 arch/um/os-Linux/tls.c                      |    2 
 arch/um/sys-x86_64/stub_segv.c              |    1 
 arch/x86_64/kernel/time.c                   |    2 
 block/ll_rw_blk.c                           |   24 +++
 drivers/block/DAC960.c                      |    2 
 drivers/char/hw_random/intel-rng.c          |  186 ++++++++++++++++++++++++++--
 drivers/char/watchdog/sc1200wdt.c           |    9 +
 drivers/ide/pci/generic.c                   |    6 
 drivers/infiniband/hw/mthca/mthca_cq.c      |    7 +
 drivers/infiniband/hw/mthca/mthca_qp.c      |   19 ++
 drivers/infiniband/hw/mthca/mthca_srq.c     |    8 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c     |    4 
 drivers/isdn/capi/capidrv.c                 |    3 
 drivers/isdn/hisax/config.c                 |    6 
 drivers/isdn/i4l/isdn_common.c              |    9 -
 drivers/isdn/icn/icn.c                      |    3 
 drivers/isdn/isdnloop/isdnloop.c            |    3 
 drivers/isdn/pcbit/drv.c                    |   16 +-
 drivers/macintosh/via-pmu-backlight.c       |    2 
 drivers/md/md.c                             |    1 
 drivers/md/multipath.c                      |    2 
 drivers/md/raid10.c                         |    2 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c   |    2 
 drivers/media/dvb/frontends/dvb-pll.c       |    3 
 drivers/media/video/cx88/cx88-dvb.c         |   14 +-
 drivers/media/video/saa7134/saa7134-dvb.c   |    4 
 drivers/net/sky2.c                          |   83 ++++++------
 drivers/net/sky2.h                          |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |    8 +
 drivers/pci/quirks.c                        |   27 ----
 drivers/rtc/rtc-max6902.c                   |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c          |   21 ++-
 drivers/serial/serial_core.c                |    9 +
 drivers/serial/serial_cs.c                  |   12 -
 drivers/usb/core/devio.c                    |   26 ++-
 drivers/usb/core/notify.c                   |    3 
 drivers/usb/core/usb.h                      |    1 
 fs/fuse/dir.c                               |   30 +++-
 fs/fuse/file.c                              |   12 +
 fs/fuse/inode.c                             |    5 
 fs/jfs/jfs_imap.c                           |    4 
 fs/nfs/dir.c                                |   14 +-
 fs/splice.c                                 |    6 
 include/asm-generic/audit_change_attr.h     |    4 
 include/asm-generic/audit_dir_write.h       |    4 
 include/asm-s390/div64.h                    |   48 -------
 include/linux/mmzone.h                      |   12 +
 include/linux/serial_core.h                 |    1 
 kernel/posix-cpu-timers.c                   |   27 +++-
 kernel/taskstats.c                          |   15 +-
 lib/audit.c                                 |    2 
 mm/memory.c                                 |    9 +
 mm/page_alloc.c                             |    4 
 mm/vmscan.c                                 |   63 ++++++---
 mm/vmstat.c                                 |    2 
 net/bluetooth/rfcomm/tty.c                  |    3 
 net/core/skbuff.c                           |    9 -
 net/decnet/af_decnet.c                      |    4 
 net/ipv4/tcp_cubic.c                        |    6 
 net/ipv6/ip6_flowlabel.c                    |    2 
 net/sctp/input.c                            |    3 
 net/sunrpc/svcsock.c                        |    2 
 sound/core/hwdep.c                          |    3 
 sound/core/info.c                           |    5 
 sound/core/rtctimer.c                       |   17 ++
 sound/pci/au88x0/au88x0.c                   |    1 
 sound/pci/emu10k1/emu10k1_main.c            |    4 
 sound/ppc/keywest.c                         |    3 
 sound/usb/usx2y/usbusx2yaudio.c             |   18 --
 sound/usb/usx2y/usx2yhwdeppcm.c             |   17 --
 86 files changed, 851 insertions(+), 341 deletions(-)

Summary of changes from v2.6.18.1 to v2.6.18.2
============================================

Akinobu Mita:
      Watchdog: sc1200wdt - fix missing pnp_unregister_driver()

Al Viro:
      fix missing ifdefs in syscall classes hookup for generic targets

Alan Cox:
      JMB 368 PATA detection

Alan Stern:
      usbfs: private mutex for open, release, and remove

Amol Lad:
      sound/pci/au88x0/au88x0.c: ioremap balanced with iounmap

Andi Kleen:
      x86-64: Fix C3 timer test

Andy Whitcroft:
      Reintroduce NODES_SPAN_OTHER_NODES for powerpc

Arnaud Patard:
      ALSA: emu10k1: Fix outl() in snd_emu10k1_resume_regs()

Arthur Kepner:
      IB/mthca: Use mmiowb after doorbell ring

Brian King:
      SCSI: DAC960: PCI id table fixup

Chris Wright:
      Linux 2.6.18.2

Clemens Ladisch:
      ALSA: snd_rtctimer: handle RTC interrupts with a tasklet

Dave Kleikamp:
      JFS: pageno needs to be long

David Miller:
      SPARC64: Fix central/FHC bus handling on Ex000 systems.
      SPARC64: Fix memory corruption in pci_4u_free_consistent().
      SPARC64: Fix PCI memory space root resource on Hummingbird.

David Woodhouse:
      Fix uninitialised spinlock in via-pmu-backlight code.

Doug Ledford:
      SCSI: aic7xxx: pause sequencer before touching SBLKCTL

Eli Cohen:
      IPoIB: Rejoin all multicast groups after a port event

Florin Malita:
      ALSA: Dereference after free in snd_hwdep_release()

Francisco Larramendi:
      rtc-max6902: month conversion fix

Herbert Xu:
      NET: Fix skb_segment() handling of fully linear SKBs
      SCTP: Always linearise packet on input

James Bottomley:
      SCSI: aic7xxx: avoid checking SBLKCTL register for certain cards

James Morris:
      IPV6: fix lockup via /proc/net/ip6_flowlabel [CVE-2006-5619]

Jan Beulich:
      fix Intel RNG detection

Jeff Garzik:
      ISDN: check for userspace copy faults
      ISDN: fix drivers, by handling errors thrown by ->readstat()

Jens Axboe:
      splice: fix pipe_to_file() ->prepare_write() error path

Karsten Wiese:
      ALSA: Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()
      ALSA: Repair snd-usb-usx2y for usb 2.6.18
      PCI: Remove quirk_via_abnormal_poweroff

Marcel Holtmann:
      Bluetooth: Check if DLC is still attached to the TTY

Martin Bligh:
      vmscan: Fix temp_priority race
      Use min of two prio settings in calculating distress for reclaim

Martin Schwidefsky:
      __div64_32 for 31 bit.

Michael Buesch:
      bcm43xx: fix watchdog timeouts.

Michael Krufky:
      DVB: fix dvb_pll_attach for mt352/zl10353 in cx88-dvb, and nxt200x

Miklos Szeredi:
      fuse: fix hang on SMP

NeilBrown:
      md: Fix bug where spares don't always get rebuilt properly when they become live.
      md: Fix calculation of ->degraded for multipath and raid10
      knfsd: Fix race that can disable NFS server.
      md: check bio address after mapping through partitions.

Oleg Nesterov:
      fill_tgid: fix task_struct leak and possible oops

Paolo 'Blaisorblade' Giarrusso:
      uml: fix processor selection to exclude unsupported processors and features
      uml: remove warnings added by previous -stable patch

Patrick McHardy:
      Fix sfuzz hanging on 2.6.18

Russell King:
      SERIAL: Fix resume handling bug
      SERIAL: Fix oops when removing suspended serial port

Stephen Hemminger:
      sky2: MSI test race and message
      sky2: pause parameter adjustment
      sky2: turn off PHY IRQ on shutdown
      sky2: accept multicast pause frames
      sky2: GMAC pause frame
      sky2: 88E803X transmit lockup (2.6.18)
      tcp: cubic scaling error

Suresh Siddha:
      mm: fix a race condition under SMC + COW

Takashi Iwai:
      ALSA: powermac - Fix Oops when conflicting with aoa driver
      ALSA: Fix re-use of va_list

Thomas Gleixner:
      posix-cpu-timers: prevent signal delivery starvation

Trond Myklebust:
      NFS: nfs_lookup - don't hash dentry when optimising away the lookup

Ulrich Drepper:
      uml: make Uml compile on FC6 kernel headers

Zachary Amsden:
      Fix potential interrupts during alternative patching

