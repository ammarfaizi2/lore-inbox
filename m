Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHNSPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHNSPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUHNSPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:15:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:61386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264377AbUHNSPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:15:04 -0400
Date: Sat, 14 Aug 2004 11:05:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kconfig.debug for 2.6.8
Message-Id: <20040814110522.4879ddd4.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the Kconfig.debug patch updated for 2.6.8:

  http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268.patch


Localize Kconfig debug options into one file (lib/Kconfig.debug)
for easier maintenance, searching, and menu-building.

Updated to 2.6.8.

Summary of changes:

. localizes the following symbols in lib/Kconfig.debug:
    DEBUG_KERNEL, MAGIC_SYSRQ, DEBUG_SLAB, DEBUG_SPINLOCK,
    DEBUG_SPINLOCK_SLEEP, DEBUG_HIGHMEM, DEBUG_BUGVERBOSE,
    DEBUG_INFO
  and FRAME_POINTER for some instances of it (if it's freely
  user-selectable) but not for the cases where it's forced or
  it depends on some other options.
. adds DEBUG_KERNEL requirement to some DEBUG_vars;
. remove KALLSYMS from S390-specific kernel hacking menu;
  use KALLSYMS in the EMBEDDED menu instead;
. add CRIS and M68KNOMMU symbols for use in lib/Kconfig.debug;
. eliminate duplicate "General setup" labels in sparc64 config;
. whitespace cleanup;
. fixed a few trival typos;


Portions of the original patch were also done by
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

 arch/alpha/Kconfig           |  104 ---------------------------
 arch/alpha/Kconfig.debug     |   59 +++++++++++++++
 arch/arm/Kconfig             |  163 -------------------------------------------
 arch/arm/Kconfig.debug       |  115 ++++++++++++++++++++++++++++++
 arch/arm26/Kconfig           |  117 ------------------------------
 arch/arm26/Kconfig.debug     |   60 +++++++++++++++
 arch/cris/Kconfig            |   56 +-------------
 arch/cris/Kconfig.debug      |   28 +++++++
 arch/h8300/Kconfig           |   75 -------------------
 arch/h8300/Kconfig.debug     |   68 +++++++++++++++++
 arch/i386/Kconfig            |  148 ++-------------------------------------
 arch/i386/Kconfig.debug      |   58 +++++++++++++++
 arch/ia64/Kconfig            |  114 ------------------------------
 arch/ia64/Kconfig.debug      |   64 ++++++++++++++++
 arch/m68k/Kconfig            |   43 -----------
 arch/m68k/Kconfig.debug      |    5 +
 arch/m68knommu/Kconfig       |   66 +----------------
 arch/m68knommu/Kconfig.debug |   42 +++++++++++
 arch/mips/Kconfig            |  146 ++------------------------------------
 arch/mips/Kconfig.debug      |   76 ++++++++++++++++++++
 arch/parisc/Kconfig          |   70 ------------------
 arch/parisc/Kconfig.debug    |   14 +++
 arch/ppc/Kconfig             |  131 +---------------------------------
 arch/ppc/Kconfig.debug       |   72 ++++++++++++++++++
 arch/ppc64/Kconfig           |   98 -------------------------
 arch/ppc64/Kconfig.debug     |   57 +++++++++++++++
 arch/s390/Kconfig            |   65 +----------------
 arch/s390/Kconfig.debug      |    5 +
 arch/sh/Kconfig              |  162 +-----------------------------------------
 arch/sh/Kconfig.debug        |  124 ++++++++++++++++++++++++++++++++
 arch/sh64/Kconfig            |   50 -------------
 arch/sh64/Kconfig.debug      |   37 +++++++++
 arch/sparc/Kconfig           |   78 --------------------
 arch/sparc/Kconfig.debug     |   14 +++
 arch/sparc64/Kconfig         |  109 ----------------------------
 arch/sparc64/Kconfig.debug   |   44 +++++++++++
 arch/um/Kconfig              |   73 +------------------
 arch/um/Kconfig.debug        |   39 ++++++++++
 arch/v850/Kconfig            |   32 --------
 arch/v850/Kconfig.debug      |   10 ++
 arch/x86_64/Kconfig          |  134 ++++-------------------------------
 arch/x86_64/Kconfig.debug    |   56 ++++++++++++++
 init/Kconfig                 |    3 
 lib/Kconfig.debug            |  100 ++++++++++++++++++++++++++
 44 files changed, 1241 insertions(+), 1943 deletions(-)

--
