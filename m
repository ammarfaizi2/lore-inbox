Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSLTMeU>; Fri, 20 Dec 2002 07:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLTMeU>; Fri, 20 Dec 2002 07:34:20 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:57762 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261854AbSLTMeT>;
	Fri, 20 Dec 2002 07:34:19 -0500
Date: Fri, 20 Dec 2002 12:41:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Next round of AGPGART fixes.
Message-ID: <20021220124137.GA28068@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
 Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
following fixes..

- AGP 3.0 now compiles as a module too.
- beginnings of VIA KT400 AGP 3.0 support.
  (Not functional yet, more work needed).
- corrected handling of AGP capability bit in PCI headers for chipset drivers.
  This should fix the problems on I815 and similar chipsets.
- small cleanups (making functions static, making things __initdata etc)
- Hopefully fix AMD K8 GART driver
- Fix module exit routine in backend
- Unmark some things __init (The cause of many modules bugs)
- agp_generic_agp_3_0_enable() now returns FALSE to the chipset driver
  if it can't configure in 3.0 mode instead of falling back to
  generic 2.0 routines.
- Export agp_generic_agp_3_0_enable() to work as module.
- Missing HP ZX1/Intel I460 fixes from David Mosberger (My bad)
- Changed I7505 driver to handle new agp_generic_agp_3_0_enable semantics.
- Renamed some VIA chipsets.

 Makefile      |    2 
 agp.h         |    4 +
 ali-agp.c     |   21 +++++----
 amd-k7-agp.c  |   26 +++++------
 amd-k8-agp.c  |   18 +++++--
 backend.c     |   27 +++--------
 frontend.c    |    2 
 generic-3.0.c |   14 ++----
 hp-agp.c      |   18 +++----
 i460-agp.c    |   35 ++++++++-------
 i7x05-agp.c   |   32 +++++++------
 intel-agp.c   |  134 ++++++++++++++++++++++++++++------------------------------
 sis-agp.c     |   27 +++++------
 sworks-agp.c  |   59 ++++++++-----------------
 via-agp.c     |   99 +++++++++++++++++++++++++++++++++++-------
 15 files changed, 283 insertions(+), 235 deletions(-)

GNU diff for those who care (against Linus' bk tree) is at
ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.52/agpgart-fixes-1.diff

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
