Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUDPFD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDPFD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:03:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:60577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbUDPFDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:03:24 -0400
Date: Thu, 15 Apr 2004 22:03:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] use Kconfig.debug (v2)
Message-Id: <20040415220338.3e351293.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use generic lib/Kconfig.debug and arch-specific arch/*/Kconfig.debug.
Move KALLSYMS to generic debugging menu.


Changes from version 1:
1.  remove global !CRIS && !H8300 from lib/Kconfig.debug;
2.  for CRIS and H8300, don't source lib/Kconfig.debug (not used);
3.  corrected several lib/Kconfig.debug ARCH usages;
4.  small change in generic debug menu order (moved SPINLOCK
	options together);

Ready for testing IMO.  More comments?


Large patch (over 100 KB) to 2.6.6-rc1:
http://developer.osdl.org/rddunlap/patches/kconf_debug_266rc1.patch

 arch/alpha/Kconfig           |  103 ---------------------------
 arch/alpha/Kconfig.debug     |   54 ++++++++++++++
 arch/arm/Kconfig             |  159 -------------------------------------------
 arch/arm/Kconfig.debug       |  113 ++++++++++++++++++++++++++++++
 arch/arm26/Kconfig           |  112 ------------------------------
 arch/arm26/Kconfig.debug     |   58 +++++++++++++++
 arch/cris/Kconfig            |   13 ---
 arch/cris/Kconfig.debug      |   15 ++++
 arch/h8300/Kconfig           |   71 -------------------
 arch/h8300/Kconfig.debug     |   67 ++++++++++++++++++
 arch/i386/Kconfig            |  124 ---------------------------------
 arch/i386/Kconfig.debug      |   15 ++++
 arch/ia64/Kconfig            |  113 ------------------------------
 arch/ia64/Kconfig.debug      |   63 +++++++++++++++++
 arch/m68k/Kconfig            |   37 ----------
 arch/m68k/Kconfig.debug      |    9 ++
 arch/m68knommu/Kconfig       |   54 --------------
 arch/m68knommu/Kconfig.debug |   42 +++++++++++
 arch/mips/Kconfig            |  110 -----------------------------
 arch/mips/Kconfig.debug      |   67 ++++++++++++++++++
 arch/parisc/Kconfig          |   48 ------------
 arch/parisc/Kconfig.debug    |    5 +
 arch/ppc/Kconfig             |  123 ---------------------------------
 arch/ppc/Kconfig.debug       |   72 +++++++++++++++++++
 arch/ppc64/Kconfig           |   79 ---------------------
 arch/ppc64/Kconfig.debug     |   27 +++++++
 arch/s390/Kconfig            |   55 --------------
 arch/s390/Kconfig.debug      |    5 +
 arch/sh/Kconfig              |  139 -------------------------------------
 arch/sh/Kconfig.debug        |  111 ++++++++++++++++++++++++++++++
 arch/sparc/Kconfig           |   71 -------------------
 arch/sparc/Kconfig.debug     |   13 +++
 arch/sparc64/Kconfig         |   98 --------------------------
 arch/sparc64/Kconfig.debug   |   38 ++++++++++
 arch/um/Kconfig              |   59 ---------------
 arch/um/Kconfig.debug        |   35 +++++++++
 arch/v850/Kconfig            |   28 -------
 arch/v850/Kconfig.debug      |   10 ++
 arch/x86_64/Kconfig          |  100 ---------------------------
 arch/x86_64/Kconfig.debug    |   47 ++++++++++++
 init/Kconfig                 |    8 --
 lib/Kconfig.debug            |  147 +++++++++++++++++++++++++++++++++++++++
 42 files changed, 1053 insertions(+), 1664 deletions(-)


Thanks,
--
~Randy
