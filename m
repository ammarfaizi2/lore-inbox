Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbTKFXdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTKFXdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:33:21 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:43484 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263860AbTKFXdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:33:16 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200311062331.hA6NVvN5023023@fsgi900.americas.sgi.com>
Subject: [PATCH] Updating our sn code in 2.6
To: akpm@osdl.org, davidm@napali.hpl.hp.com
Date: Thu, 6 Nov 2003 17:31:56 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a patch for 2.6 that will update our sn I/O. This patch includes
initial support for new h/w, some code reorganization to accomodate the
new h/w, fixes to our code since the last bulk update earlier this year
and code clean-up. The diffstat follows at the end of this email.

The patch can be viewed from :
ftp://oss.sgi.com/pub/outgoing

Thanks,
-- Pat

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054


 arch/ia64/sn/Makefile                        |    2
 arch/ia64/sn/fakeprom/fpmem.c                |  222 +-
 arch/ia64/sn/fakeprom/fpmem.h                |   31
 arch/ia64/sn/fakeprom/fpromasm.S             |   12
 arch/ia64/sn/fakeprom/fw-emu.c               |  168 -
 arch/ia64/sn/fakeprom/klgraph_fake.c         |  373 +++
 arch/ia64/sn/fakeprom/klgraph_init.c         |    4
 arch/ia64/sn/fakeprom/main.c                 |  101 -
 arch/ia64/sn/io/Makefile                     |    6
 arch/ia64/sn/io/cdl.c                        |   23
 arch/ia64/sn/io/drivers/Makefile             |    2
 arch/ia64/sn/io/drivers/ioconfig_bus.c       |   87
 arch/ia64/sn/io/drivers/pciba.c              |  917 +++++++++
 arch/ia64/sn/io/hwgfs/Makefile               |    2
 arch/ia64/sn/io/hwgfs/hcl.c                  |  249 --
 arch/ia64/sn/io/hwgfs/hcl_util.c             |   68
 arch/ia64/sn/io/hwgfs/interface.c            |   46
 arch/ia64/sn/io/hwgfs/labelcl.c              |    1
 arch/ia64/sn/io/io.c                         |   44
 arch/ia64/sn/io/machvec/Makefile             |    2
 arch/ia64/sn/io/machvec/pci.c                |   35
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c     |  445 ++--
 arch/ia64/sn/io/machvec/pci_dma.c            |   45
 arch/ia64/sn/io/platform_init/Makefile       |    2
 arch/ia64/sn/io/platform_init/irix_io_init.c |   76
 arch/ia64/sn/io/platform_init/sgi_io_init.c  |   15
 arch/ia64/sn/io/sgi_if.c                     |   34
 arch/ia64/sn/io/sgi_io_sim.c                 |   79
 arch/ia64/sn/io/sn2/Makefile                 |    9
 arch/ia64/sn/io/sn2/bte_error.c              |   36
 arch/ia64/sn/io/sn2/geo_op.c                 |    4
 arch/ia64/sn/io/sn2/ioc4/Makefile            |   21
 arch/ia64/sn/io/sn2/ioc4/ioc4.c              |  649 ++++++
 arch/ia64/sn/io/sn2/ioc4/sio_ioc4.c          | 2289 +++++++++++++++++++++++
 arch/ia64/sn/io/sn2/klconflib.c              |  160 -
 arch/ia64/sn/io/sn2/klgraph.c                |  444 ++--
 arch/ia64/sn/io/sn2/l1_command.c             |   44
 arch/ia64/sn/io/sn2/ml_SN_init.c             |   71
 arch/ia64/sn/io/sn2/ml_SN_intr.c             |   52
 arch/ia64/sn/io/sn2/ml_iograph.c             |  427 ++--
 arch/ia64/sn/io/sn2/module.c                 |  141 -
 arch/ia64/sn/io/sn2/pcibr/Makefile           |    9
 arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c        |  415 ----
 arch/ia64/sn/io/sn2/pcibr/pcibr_config.c     |  223 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c        | 2505 ++++++--------------------
 arch/ia64/sn/io/sn2/pcibr/pcibr_error.c      | 1299 +++++++------
 arch/ia64/sn/io/sn2/pcibr/pcibr_hints.c      |   38
 arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c       |  425 +---
 arch/ia64/sn/io/sn2/pcibr/pcibr_msix_intr.c  |  264 ++
 arch/ia64/sn/io/sn2/pcibr/pcibr_reg.c        | 2592 +++++++++++++++++++++++++++
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c        |  406 ++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c       | 1009 +++++++---
 arch/ia64/sn/io/sn2/pciio.c                  |  530 +----
 arch/ia64/sn/io/sn2/pciio_ppb.c              | 1550 ++++++++++++++++
 arch/ia64/sn/io/sn2/pic.c                    |  691 ++++++-
 arch/ia64/sn/io/sn2/shub.c                   |   78
 arch/ia64/sn/io/sn2/shub_intr.c              |   96 -
 arch/ia64/sn/io/sn2/shuberror.c              |   14
 arch/ia64/sn/io/sn2/shubio.c                 |   14
 arch/ia64/sn/io/sn2/tio.c                    |  743 +++++++
 arch/ia64/sn/io/sn2/tio_intr.c               |  166 +
 arch/ia64/sn/io/sn2/tiocp.c                  |  963 ++++++++++
 arch/ia64/sn/io/sn2/xbow.c                   |  529 -----
 arch/ia64/sn/io/sn2/xtalk.c                  |   96 -
 arch/ia64/sn/io/snia_if.c                    |  278 ++
 arch/ia64/sn/io/tio/Makefile                 |   10
 arch/ia64/sn/io/tio/ca/Makefile              |   10
 arch/ia64/sn/io/tio/ca/ca_driver.c           |   75
 arch/ia64/sn/io/tio/ca/ca_error.c            |  147 +
 arch/ia64/sn/io/tio/ca/ca_linux.c            |  246 ++
 arch/ia64/sn/io/tio/ca/ca_pci.c              | 1281 +++++++++++++
 arch/ia64/sn/io/xswitch.c                    |   72
 arch/ia64/sn/kernel/Makefile                 |    2
 arch/ia64/sn/kernel/irq.c                    |  137 -
 arch/ia64/sn/kernel/setup.c                  |   86
 arch/ia64/sn/kernel/sn2/Makefile             |    4
 arch/ia64/sn/kernel/sn2/cache.c              |   20
 arch/ia64/sn/kernel/sn2/timer_interrupt.c    |   76
 drivers/char/ioc4_serial.c                   | 1840 +++++++++++++++++++
 drivers/char/sn_serial.c                     |    3
 include/asm-ia64/sn/addrs.h                  |   42
 include/asm-ia64/sn/alenlist.h               |    3
 include/asm-ia64/sn/arc/hinv.h               |  183 -
 include/asm-ia64/sn/arc/types.h              |   41
 include/asm-ia64/sn/arch.h                   |    3
 include/asm-ia64/sn/cdl.h                    |    5
 include/asm-ia64/sn/clksupport.h             |    3
 include/asm-ia64/sn/dmamap.h                 |   29
 include/asm-ia64/sn/driver.h                 |    3
 include/asm-ia64/sn/geo.h                    |    9
 include/asm-ia64/sn/hcl.h                    |   40
 include/asm-ia64/sn/hcl_util.h               |    3
 include/asm-ia64/sn/hwgfs.h                  |    6
 include/asm-ia64/sn/intr.h                   |    3
 include/asm-ia64/sn/invent.h                 |  733 -------
 include/asm-ia64/sn/io.h                     |    3
 include/asm-ia64/sn/ioc4.h                   |   80
 include/asm-ia64/sn/ioconfig_bus.h           |   39
 include/asm-ia64/sn/ioerror.h                |    7
 include/asm-ia64/sn/ioerror_handling.h       |   54
 include/asm-ia64/sn/iograph.h                |   85
 include/asm-ia64/sn/klconfig.h               |  277 --
 include/asm-ia64/sn/ksys/elsc.h              |    9
 include/asm-ia64/sn/ksys/l1.h                |   38
 include/asm-ia64/sn/labelcl.h                |   16
 include/asm-ia64/sn/module.h                 |   16
 include/asm-ia64/sn/nag.h                    |   32
 include/asm-ia64/sn/nodepda.h                |    5
 include/asm-ia64/sn/pci/bridge.h             | 1901 -------------------
 include/asm-ia64/sn/pci/pci_bus_cvlink.h     |   12
 include/asm-ia64/sn/pci/pci_defs.h           |  203 +-
 include/asm-ia64/sn/pci/pciba.h              |  113 +
 include/asm-ia64/sn/pci/pcibr.h              |   85
 include/asm-ia64/sn/pci/pcibr_asic.h         |  511 +++++
 include/asm-ia64/sn/pci/pcibr_private.h      |  314 ++-
 include/asm-ia64/sn/pci/pciio.h              |  167 +
 include/asm-ia64/sn/pci/pciio_private.h      |   89
 include/asm-ia64/sn/pci/pic.h                | 2499 +++++---------------------
 include/asm-ia64/sn/pci/tiocp.h              |  588 ++++++
 include/asm-ia64/sn/pda.h                    |    4
 include/asm-ia64/sn/pio.h                    |    3
 include/asm-ia64/sn/prio.h                   |    3
 include/asm-ia64/sn/router.h                 |    3
 include/asm-ia64/sn/serialio.h               |  462 ++++
 include/asm-ia64/sn/sgi.h                    |  150 -
 include/asm-ia64/sn/simulator.h              |    2
 include/asm-ia64/sn/slotnum.h                |    3
 include/asm-ia64/sn/sn2/addrs.h              |   58
 include/asm-ia64/sn/sn2/arch.h               |    5
 include/asm-ia64/sn/sn2/geo.h                |    9
 include/asm-ia64/sn/sn2/iceio.h              |  162 +
 include/asm-ia64/sn/sn2/intr.h               |    8
 include/asm-ia64/sn/sn2/shub.h               |    1
 include/asm-ia64/sn/sn2/shub_md.h            |    7
 include/asm-ia64/sn/sn2/shub_mmr_t.h         |    1
 include/asm-ia64/sn/sn2/shubio.h             |    8
 include/asm-ia64/sn/sn2/sn_private.h         |    9
 include/asm-ia64/sn/sn2/tio.h                |   45
 include/asm-ia64/sn/sn_fru.h                 |    3
 include/asm-ia64/sn/sn_private.h             |    3
 include/asm-ia64/sn/tio/tioca.h              |  482 +++++
 include/asm-ia64/sn/tio/tioca_private.h      |   61
 include/asm-ia64/sn/tio/tioca_soft.h         |   80
 include/asm-ia64/sn/vector.h                 |    3
 include/asm-ia64/sn/xtalk/corelet.h          |   22
 include/asm-ia64/sn/xtalk/xbow.h             |  227 --
 include/asm-ia64/sn/xtalk/xbow_info.h        |   55
 include/asm-ia64/sn/xtalk/xswitch.h          |    9
 include/asm-ia64/sn/xtalk/xtalk.h            |   28
 include/asm-ia64/sn/xtalk/xtalk_private.h    |   15
 include/asm-ia64/sn/xtalk/xtalkaddrs.h       |    9
 include/asm-ia64/sn/xtalk/xwidget.h          |   84
 152 files changed, 23736 insertions(+), 12917 deletions(-)

