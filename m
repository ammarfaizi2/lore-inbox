Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUHVVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUHVVFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUHVVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:05:40 -0400
Received: from havoc.gtf.org ([216.162.42.101]:16341 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265800AbUHVVFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:05:08 -0400
Date: Sun, 22 Aug 2004 17:03:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] large 2.6.x net driver update
Message-ID: <20040822210335.GA6888@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, all this has been waiting for -rc to end.

This stuff has been simmering in -mm, sometimes for quite a while.

Please do a

	bk pull bk://gkernel.bkbits.net/netdev-2.6

This will update the following files:

 include/asm-mips/mv64340.h             | 1039 ------------
 MAINTAINERS                            |    2 
 arch/mips/configs/jaguar-atx_defconfig |    8 
 arch/mips/configs/ocelot_c_defconfig   |    2 
 arch/mips/momentum/jaguar_atx/prom.c   |    4 
 arch/mips/momentum/ocelot_c/prom.c     |    6 
 drivers/net/8139too.c                  |    4 
 drivers/net/8390.c                     |   36 
 drivers/net/8390.h                     |   12 
 drivers/net/Kconfig                    |   45 
 drivers/net/Makefile                   |    5 
 drivers/net/acenic.c                   |  156 -
 drivers/net/acenic.h                   |    2 
 drivers/net/e100.c                     |   89 -
 drivers/net/e1000/e1000.h              |   24 
 drivers/net/e1000/e1000_ethtool.c      |  146 +
 drivers/net/e1000/e1000_hw.c           |   16 
 drivers/net/e1000/e1000_hw.h           |    3 
 drivers/net/e1000/e1000_main.c         |  486 +++---
 drivers/net/e1000/e1000_param.c        |   46 
 drivers/net/eepro100.c                 |   17 
 drivers/net/epic100.c                  |  426 +++--
 drivers/net/gianfar.c                  | 1864 +++++++++++++++++++++++
 drivers/net/gianfar.h                  |  535 ++++++
 drivers/net/gianfar_ethtool.c          |  525 ++++++
 drivers/net/gianfar_phy.c              |  661 ++++++++
 drivers/net/gianfar_phy.h              |  213 ++
 drivers/net/gt64240eth.h               |  402 +++++
 drivers/net/gt96100eth.c               |  119 -
 drivers/net/mv643xx_eth.c              | 2646 +++++++++++++++++++++++++++++++++
 drivers/net/mv643xx_eth.h              |  601 +++++++
 drivers/net/natsemi.c                  |   15 
 drivers/net/r8169.c                    |  655 +++++---
 drivers/net/sk98lin/h/skdrv2nd.h       |   54 
 drivers/net/sk98lin/skaddr.c           |    4 
 drivers/net/sk98lin/skge.c             |  742 +++------
 drivers/net/via-rhine.c                |  691 ++++----
 drivers/net/via-velocity.c             |  566 +++----
 drivers/net/via-velocity.h             |    4 
 drivers/net/wireless/airport.c         |   34 
 drivers/net/wireless/hermes.c          |   12 
 drivers/net/wireless/hermes.h          |  133 +
 drivers/net/wireless/hermes_rid.h      |   99 -
 drivers/net/wireless/ieee802_11.h      |    1 
 drivers/net/wireless/orinoco.c         | 2483 +++++++++++++++---------------
 drivers/net/wireless/orinoco.h         |   36 
 drivers/net/wireless/orinoco_cs.c      |   70 
 drivers/net/wireless/orinoco_pci.c     |   52 
 drivers/net/wireless/orinoco_plx.c     |  203 +-
 drivers/net/wireless/orinoco_tmd.c     |   56 
 include/linux/mii.h                    |    3 
 include/linux/mv643xx.h                | 1039 ++++++++++++
 include/linux/pci_ids.h                |    1 
 53 files changed, 12411 insertions(+), 4682 deletions(-)

through these ChangeSets:

<afleming:freescale.com>:
  o update gianfar ethernet driver

<kalev:smartlink.ee>:
  o natsemi netpoll support

Adrian Bunk:
  o 2.6.8-rc1-mm1: 8139too: uninline rtl8139_start_thread

Andrew Morton:
  o via-velocity warning fixes
  o fix via-velocity oopses

Christoph Hellwig:
  o remove dead code from mv64340_eth
  o fix compiler warnings in mv64340_eth
  o allow modular mv64340_eth
  o convert skge to pci_driver API (2nd try)

David Gibson:
  o orinoco merge preliminaries - update authorship information
  o orinoco merge preliminaries - more HW data
  o orinoco merge preliminaries - don't typedef structs
  o orinoco merge preliminaries - remove unneeded #includes
  o orinoco merge preliminaries - use name/version macros
  o orinoco merge preliminaries - miscelaneous
  o orinoco merge preliminaries - make things static
  o orinoco merge preliminaries - use BUG_ON()
  o orinoco merge preliminaries - comment/whitespace/spelling updates
  o orinoco merge preliminaries - spam stoppers
  o orinoco merge preliminaries - use ARRAY_SIZE()
  o orinoco merge preliminaries - use ALIGN()
  o orinoco merge preliminaries - use netdev_priv()
  o orinoco merge preliminaries - rearrange code
  o orinoco merge preliminaries - squash backwards compatibility

Domen Puncer:
  o remove old ifdefs net/eepro100.c

François Romieu:
  o via-velocity: use common crc16 code for WOL
  o via-velocity: unneeded forward declarations
  o via-velocity: ordering of Rx descriptors operations
  o via-velocity: Rx copybreak
  o via-velocity: Rx buffers allocation rework
  o via-velocity: velocity_receive_frame diets
  o via-velocity: uniformize use of OWNED_BY_NIC
  o via-velocity: PCI ID move
  o r8169: tx lock removal
  o r8169: gcc bug workaround
  o r8169: initial link setup rework
  o r8169: link handling and phy reset rework
  o r8169: ethtool .get_{settings/link}
  o r8169: ethtool .set_settings
  o r8169: janitoring
  o r8169: cosmetic renaming of a register
  o r8169: napi support
  o epic100: code removal in irq handler
  o epic100: spin_unlock_irqrestore avoidance
  o [netdrvr epic100] napi fixes
  o [netdrvr epic100] napi 3/3 - transmit path
  o [netdrvr epic100] napi 2/3 - receive path
  o [netdrvr epic100] napi 1/3 - just shuffle some code around
  o [netdrvr epic100] minor cleanups

Ganesh Venkatesan:
  o e100 - driver version update
  o e100 - Auto MDI/MDI-X support
  o e100 - Support to load device firmware
  o e100 - fix stat counters rx_length_error and rx_over_errors
  o e100 - Support for Intel(R) PRO/100 VE Network Connection (82562) adapter
  o e100 - restore speed/duplex/autoneg settings after the completion of the diagnostic tests
  o e1000 - white space and related cleanup
  o e1000 - suspend/resume fix from alex@zodiac.dasalias.org
  o e1000 - more DPRINTK messages to syslog
  o e1000 - add compiler hints (likely/unlikely), check
  o e1000 - Shutdown PHY while bringing the interface
  o e1000 - Use pci_dma_sync_single_[for_device|for_cpu]
  o e1000 - include work down in tx path to decide when
  o e1000 - Avoid infinite loop while trying to
  o e1000 - TSO fixes (in preparation for IPv6 TSO)
  o e1000 - Use vmalloc for data structures not shared
  o e1000 - Enable TSO
  o e1000 - ethtool support (register dump, interrupt

Herbert Xu:
  o Fix successive calls to spin_lock_irqsave in sk98lin

Kumar Gala:
  o add new ethernet driver 'gianfar'

Margit Schubert-While:
  o prism54 Clean up dev ids totally

Mika Kukkonen:
  o Fix warnings drivers/net/sk98lin/skaddr.c

Paul Gortmaker:
  o Remove obsolete code in 8390 driver

Ralf Bächle:
  o GT96100 update
  o [netdrvr mv643xx] rename from mv64340 to mv643xx
  o New driver for MV64340 GigE

Roger Luethi:
  o Add WOL support
  o Small fixes and clean-up
  o Media mode rewrite
  o Fix Tx engine race for good
  o Remove options, full_duplex parameters
  o Rewrite PHY detection
  o Remove lingering PHY special casing
  o fix mc_filter on big-endian arch
  o Restructure reset code

Scott Feldman:
  o e100: use NAPI mode all the time

Stephen Hemminger:
  o acenic - don't print eth%d in messages
  o module_param for acenic
  o [sparse] minor #if complaint

