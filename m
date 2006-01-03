Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWACE6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWACE6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 23:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWACE6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 23:58:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWACE6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 23:58:51 -0500
Date: Mon, 2 Jan 2006 20:58:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.15
Message-ID: <Pine.LNX.4.64.0601022055310.3668@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1447360119-1136264328=:3668"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1447360119-1136264328=:3668
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok, very small/few changes in the last week, it seems everybody is off on 
vacation. All the better.

The shortlog/diffstat tell the story: a few one-liners, another ipv6 
deadlock fixed, some sysctl and /proc fixes. 

Have fun,

		Linus

---
Andi Kleen:
      Make sure interleave masks have at least one node set

Anton Blanchard:
      ppc64: htab_initialize_secondary cannot be marked __init

Benjamin Herrenschmidt:
      Fix more radeon GART start calculation cases
      powerpc: more g5 overtemp problem fix

Chris Elmquist:
      [TG3]: ethtool -d hangs PCIe systems

Dag-Erling Smørgrav:
      Avoid namespace pollution in <asm/param.h>

Dave Jones:
      fix ia64 compile failure with gcc4.1

David Kimdon:
      [BR_NETFILTER]: Fix leak if skb traverses > 1 bridge

David L Stevens:
      [IPV6]: Increase default MLD_MAX_MSF to 64.
      [IPV6] mcast: Fix multiple issues in MLDv2 reports.

David S. Miller:
      [NET]: Validate socket filters against BPF_MAXINSNS in one spot.
      [TG3]: Update driver version and reldate.
      [SPARC]: Use STABS_DEBUG and DWARF_DEBUG macros in vmlinux.lds.S
      [SERMOUSE]: Sun mice speak 5-byte protocol too.

Denny Priebe:
      Input: wacom - fix X axis setup

Dmitry Torokhov:
      Input: kbtab - fix Y axis setup
      Input: warrior - fix HAT0Y axis setup

Erik Hovland:
      [ARM] 3216/1: indent and typo in drivers/serial/pxa.c

James Bottomley:
      Fix Fibre Channel boot oops

Jean Delvare:
      Fix recursive config dependency for SAA7134
      Simplify the VIDEO_SAA7134_OSS Kconfig dependency line

Linus Torvalds:
      Revert radeon AGP aperture offset changes
      Insanity avoidance in /proc
      sysctl: don't overflow the user-supplied buffer with '\0'
      sysctl: make sure to terminate strings with a NUL
      Linux v2.6.15

Paolo 'Blaisorblade' Giarrusso:
      uml: fix random segfaults at bootup
      Hostfs: remove unused var
      uml: hostfs - fix possible PAGE_CACHE_SHIFT overflows
      Hostfs: update for new glibc - add missing symbol exports
      uml: fix compilation with CONFIG_MODE_TT disabled

Ravikiran G Thirumalai:
      x86_64: Fix incorrect node_present_pages on NUMA

Riccardo Magliocchetti:
      Input: aiptek - fix Y axis setup

Russell King:
      [MMC] Set correct capacity for 1024-byte block cards
      [SERIAL] Fix AMBA PL011 sysrq character handling

Stas Sergeev:
      x86: teach dump_task_regs() about the -8 offset.

Yi Yang:
      Fix false old value return of sysctl

YOSHIFUJI Hideaki:
      [IPV6]: Fix addrconf dead lock.

 Makefile                            |    2 
 arch/i386/kernel/process.c          |    4 +
 arch/powerpc/mm/hash_utils_64.c     |    2 
 arch/sparc/kernel/vmlinux.lds.S     |   18 +---
 arch/sparc64/kernel/vmlinux.lds.S   |   18 +---
 arch/um/os-Linux/start_up.c         |   22 +++--
 arch/um/os-Linux/user_syms.c        |    5 +
 arch/um/sys-i386/Makefile           |    8 +-
 arch/um/sys-x86_64/Makefile         |    5 +
 arch/x86_64/mm/init.c               |    2 
 drivers/char/drm/radeon_cp.c        |    9 --
 drivers/char/vc_screen.c            |    2 
 drivers/input/joystick/warrior.c    |    2 
 drivers/input/mouse/sermouse.c      |    2 
 drivers/macintosh/therm_pm72.c      |    6 +
 drivers/media/video/saa7134/Kconfig |    4 -
 drivers/mmc/mmc_block.c             |   14 ++-
 drivers/net/ppp_generic.c           |    3 -
 drivers/net/tg3.c                   |   13 ++-
 drivers/net/tg3.h                   |    7 ++
 drivers/scsi/scsi_scan.c            |    3 -
 drivers/serial/amba-pl011.c         |    2 
 drivers/serial/pxa.c                |    4 -
 drivers/usb/input/aiptek.c          |    2 
 drivers/usb/input/kbtab.c           |    2 
 drivers/usb/input/wacom.c           |    2 
 fs/hostfs/hostfs_kern.c             |    9 +-
 fs/proc/generic.c                   |   47 ++++++------
 include/asm-i386/param.h            |    3 -
 include/asm-x86_64/param.h          |    3 -
 include/net/if_inet6.h              |    1 
 kernel/sysctl.c                     |   29 ++++---
 mm/mempolicy.c                      |    4 +
 net/bridge/br_netfilter.c           |    2 
 net/core/filter.c                   |    4 -
 net/ipv6/addrconf.c                 |    9 +-
 net/ipv6/mcast.c                    |  142 +++++++++++++++++++++++++++--------
 37 files changed, 254 insertions(+), 162 deletions(-)
--21872808-1447360119-1136264328=:3668--
