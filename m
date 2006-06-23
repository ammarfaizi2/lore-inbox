Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWFWSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWFWSmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWFWSlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16335 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751912AbWFWSlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:50 -0400
Message-Id: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:30:56 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] m68k patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A series of m68k related patches, the first patches are mostly bug fixes
and the rest are a major cleanup of the m68k irq system, which gets it a
lot closer to the generic code.

bye, Roman

--

 arch/m68k/amiga/amiga_ksyms.c  |    2 
 arch/m68k/amiga/amiints.c      |  384 +++----------------------------
 arch/m68k/amiga/cia.c          |  156 ++++++------
 arch/m68k/amiga/config.c       |   15 -
 arch/m68k/apollo/Makefile      |    2 
 arch/m68k/apollo/config.c      |   24 -
 arch/m68k/apollo/dn_ints.c     |  137 ++---------
 arch/m68k/atari/ataints.c      |  278 +++-------------------
 arch/m68k/atari/config.c       |   11 
 arch/m68k/bvme6000/Makefile    |    2 
 arch/m68k/bvme6000/bvmeints.c  |  160 -------------
 arch/m68k/bvme6000/config.c    |   21 -
 arch/m68k/hp300/Makefile       |    2 
 arch/m68k/hp300/config.c       |   11 
 arch/m68k/hp300/ints.c         |  175 --------------
 arch/m68k/hp300/ints.h         |    9 
 arch/m68k/hp300/time.c         |    3 
 arch/m68k/kernel/Makefile      |    4 
 arch/m68k/kernel/dma.c         |  129 ++++++++++
 arch/m68k/kernel/entry.S       |  100 +++-----
 arch/m68k/kernel/ints.c        |  378 ++++++++++++++++++++----------
 arch/m68k/kernel/m68k_ksyms.c  |    2 
 arch/m68k/kernel/setup.c       |    3 
 arch/m68k/kernel/traps.c       |  180 ++++++--------
 arch/m68k/mac/baboon.c         |    2 
 arch/m68k/mac/config.c         |   20 -
 arch/m68k/mac/iop.c            |    2 
 arch/m68k/mac/macints.c        |  503 ++++++++++-------------------------------
 arch/m68k/mac/oss.c            |   14 -
 arch/m68k/mac/psc.c            |   10 
 arch/m68k/mac/via.c            |   18 -
 arch/m68k/mm/kmap.c            |    6 
 arch/m68k/mvme147/147ints.c    |  145 -----------
 arch/m68k/mvme147/Makefile     |    2 
 arch/m68k/mvme147/config.c     |   22 -
 arch/m68k/mvme16x/16xints.c    |  149 ------------
 arch/m68k/mvme16x/Makefile     |    2 
 arch/m68k/mvme16x/config.c     |   23 -
 arch/m68k/q40/config.c         |   13 -
 arch/m68k/q40/q40ints.c        |  485 +++++++++++++--------------------------
 arch/m68k/sun3/config.c        |    8 
 arch/m68k/sun3/sun3ints.c      |  210 ++---------------
 arch/m68k/sun3x/config.c       |    7 
 drivers/block/amiflop.c        |    1 
 drivers/macintosh/via-pmu68k.c |    3 
 drivers/net/sun3lance.c        |    2 
 drivers/scsi/mac_esp.c         |    7 
 drivers/scsi/mac_scsi.c        |    7 
 drivers/scsi/sun3x_esp.c       |    8 
 include/asm-m68k/amigaints.h   |   94 +++----
 include/asm-m68k/apollohw.h    |    4 
 include/asm-m68k/atari_stdma.h |    2 
 include/asm-m68k/atariints.h   |   11 
 include/asm-m68k/bvme6000hw.h  |   30 +-
 include/asm-m68k/cacheflush.h  |   40 +--
 include/asm-m68k/dma-mapping.h |   90 ++++++-
 include/asm-m68k/irq.h         |  110 ++++----
 include/asm-m68k/mac_oss.h     |   10 
 include/asm-m68k/machdep.h     |    6 
 include/asm-m68k/macintosh.h   |   10 
 include/asm-m68k/macints.h     |   14 -
 include/asm-m68k/mvme147hw.h   |   44 +--
 include/asm-m68k/mvme16xhw.h   |   40 +--
 include/asm-m68k/scatterlist.h |    9 
 include/asm-m68k/signal.h      |   19 +
 include/asm-m68k/sun3ints.h    |   22 -
 include/asm-m68k/traps.h       |    7 
 include/asm-m68k/uaccess.h     |  234 ++++++++++---------
 68 files changed, 1519 insertions(+), 3134 deletions(-)

