Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUAOV6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUAOV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:58:38 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:58503 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263330AbUAOV6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:58:20 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com>
Subject: [PATCH 2.6] Altix updates
To: akpm@osdl.org, davidm@napali.hpl.hp.com
Date: Thu, 15 Jan 2004 15:54:37 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My latest set of patches for 2.6 Altix is at:
ftp://oss.sgi.com/projects/sn2/sn2-update/

diffstats are at the end of this email.

The reorg patch is one that I had submitted in the last set - it was
decided to take out the renaming, which I did.

-- Pat

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054





001-reorg.patch
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c |  358 ++-----
 arch/ia64/sn/io/machvec/pci_dma.c        |   19 
 arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c    |  355 ------
 arch/ia64/sn/io/sn2/pcibr/pcibr_config.c |   53 -
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c    | 1582 +++----------------------------
 arch/ia64/sn/io/sn2/pcibr/pcibr_error.c  |  690 ++++++++-----
 arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c   |  289 +----
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c    |  288 +++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c   |  265 ++---
 arch/ia64/sn/io/sn2/pciio.c              |   33 
 arch/ia64/sn/io/sn2/pic.c                |  588 +++++++++++
 arch/ia64/sn/kernel/irq.c                |    6 
 include/asm-ia64/sn/module.h             |    9 
 include/asm-ia64/sn/pci/bridge.h         |    8 
 include/asm-ia64/sn/pci/pci_bus_cvlink.h |    7 
 include/asm-ia64/sn/pci/pcibr.h          |   47 
 include/asm-ia64/sn/pci/pcibr_private.h  |  142 ++
 include/asm-ia64/sn/pci/pciio.h          |   25 
 include/asm-ia64/sn/pci/pic.h            |  809 ++-------------
 include/asm-ia64/sn/sn2/intr.h           |    4 
 20 files changed, 2011 insertions(+), 3566 deletions(-)


002-reorg1.patch
 pcibr_reg.c | 1437 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 1426 insertions(+), 11 deletions(-)


003-misc.cleanup.patch
 arch/ia64/sn/io/io.c                    |   42 ++++++++--------
 arch/ia64/sn/io/sn2/ml_iograph.c        |    7 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c   |   38 ++++++--------
 arch/ia64/sn/io/sn2/pcibr/pcibr_hints.c |    7 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c  |    8 +--
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c   |   12 ++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c  |   82 ++++++++++++++++----------------
 arch/ia64/sn/io/sn2/pciio.c             |   12 +---
 arch/ia64/sn/io/sn2/pic.c               |    6 +-
 arch/ia64/sn/io/sn2/shuberror.c         |    1 
 arch/ia64/sn/io/sn2/xbow.c              |    4 +
 arch/ia64/sn/io/sn2/xtalk.c             |   18 ++-----
 arch/ia64/sn/io/xswitch.c               |   10 ++-
 arch/ia64/sn/kernel/bte.c               |    2 
 arch/ia64/sn/kernel/mca.c               |    1 
 arch/ia64/sn/kernel/probe.c             |    1 
 arch/ia64/sn/kernel/sn2/prominfo_proc.c |    1 
 arch/ia64/sn/kernel/sn2/sn2_smp.c       |    1 
 arch/ia64/sn/kernel/sn2/sn_proc_fs.c    |    1 
 drivers/char/sn_serial.c                |    1 
 include/asm-ia64/sn/addrs.h             |    4 -
 include/asm-ia64/sn/alenlist.h          |   18 +++----
 include/asm-ia64/sn/arch.h              |    7 --
 include/asm-ia64/sn/bte.h               |    3 -
 include/asm-ia64/sn/clksupport.h        |    2 
 include/asm-ia64/sn/driver.h            |    2 
 include/asm-ia64/sn/hcl.h               |    2 
 include/asm-ia64/sn/hcl_util.h          |    2 
 include/asm-ia64/sn/hwgfs.h             |    3 +
 include/asm-ia64/sn/iograph.h           |    1 
 include/asm-ia64/sn/klconfig.h          |    8 +--
 include/asm-ia64/sn/kldir.h             |    4 -
 include/asm-ia64/sn/module.h            |    2 
 include/asm-ia64/sn/nodepda.h           |    4 -
 include/asm-ia64/sn/pci/bridge.h        |   16 +++---
 include/asm-ia64/sn/pci/pcibr_private.h |   15 -----
 include/asm-ia64/sn/pci/pciio.h         |   20 +++----
 include/asm-ia64/sn/pci/pciio_private.h |    6 +-
 include/asm-ia64/sn/pda.h               |    3 -
 include/asm-ia64/sn/pio.h               |    6 --
 include/asm-ia64/sn/sgi.h               |   17 +++++-
 include/asm-ia64/sn/sn2/arch.h          |    3 -
 include/asm-ia64/sn/sn2/sn_private.h    |   12 +---
 include/asm-ia64/sn/sn_cpuid.h          |    6 --
 include/asm-ia64/sn/sn_private.h        |    5 -
 include/asm-ia64/sn/types.h             |    8 ---
 include/asm-ia64/sn/vector.h            |    2 
 include/asm-ia64/sn/xtalk/xbow.h        |   19 -------
 include/asm-ia64/sn/xtalk/xtalk.h       |   16 +++---
 include/asm-ia64/sn/xtalk/xwidget.h     |   26 +++++-----
 50 files changed, 230 insertions(+), 267 deletions(-)


004-misc.cleanup1.patch
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c   |    2 ++
 include/asm-ia64/sn/pci/pcibr_private.h |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)


005-ate.flags.patch
 arch/ia64/sn/io/machvec/pci_dma.c |    8 ++++++--
 include/asm-ia64/sn/pci/pcibr.h   |    6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)


006-find_lboard.patch
 arch/ia64/sn/io/platform_init/sgi_io_init.c |    2 
 arch/ia64/sn/io/sn2/klconflib.c             |  215 +++++++---------------------
 arch/ia64/sn/io/sn2/klgraph.c               |   87 +----------
 arch/ia64/sn/io/sn2/ml_iograph.c            |   13 -
 arch/ia64/sn/io/sn2/module.c                |   37 ++++
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c       |   14 +
 arch/ia64/sn/kernel/setup.c                 |   35 ++++
 include/asm-ia64/sn/klconfig.h              |    7 
 8 files changed, 153 insertions(+), 257 deletions(-)


007-ate.patch
 pcibr_ate.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


008-early_probe_for_widget.patch
 ml_iograph.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)


009-setup.c.patch
 setup.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 76 insertions(+), 13 deletions(-)


010-kill-pcibr_intr_func.patch
 pcibr_intr.c |  136 -----------------------------------------------------------
 1 files changed, 2 insertions(+), 134 deletions(-)


011-irq.update.patch
 irq.c |  161 +++++++++++++++++++++++-------------------------------------------
 1 files changed, 58 insertions(+), 103 deletions(-)

