Return-Path: <linux-kernel-owner+w=401wt.eu-S1762594AbWLKVVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762594AbWLKVVK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762600AbWLKVVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:21:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37627 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762594AbWLKVVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:21:09 -0500
Date: Mon, 11 Dec 2006 13:25:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.19.1
Message-ID: <20061211212500.GF1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.19.1 kernel.
It's an assortment of fixes with a couple security related:

a526d58e: do_coredump() and not stopping rewrite attacks? (CVE-2006-6304)
ad8ca99c: TOKENRING: Remote memory corruptor in ibmtr.c

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.19 and 2.6.19.1, as it is small enough to do so.
                                                                                
The updated 2.6.19.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris

--------

 Makefile                                      |    2 
 arch/i386/kernel/acpi/boot.c                  |   10 -
 arch/i386/kernel/nmi.c                        |    8 -
 arch/m32r/kernel/entry.S                      |   65 +++++------
 arch/x86_64/kernel/nmi.c                      |    9 -
 drivers/block/Kconfig                         |    1 
 drivers/char/drm/drm_sman.c                   |    1 
 drivers/infiniband/core/ucm.c                 |    2 
 drivers/net/forcedeth.c                       |    3 
 drivers/net/sunhme.c                          |    5 
 drivers/net/tokenring/ibmtr.c                 |    2 
 drivers/usb/misc/phidgetservo.c               |    1 
 fs/autofs/inode.c                             |    7 -
 fs/autofs4/inode.c                            |    7 -
 fs/compat.c                                   |    2 
 fs/exec.c                                     |    3 
 include/asm-m32r/ptrace.h                     |   28 -----
 include/asm-m32r/sigcontext.h                 |   13 --
 include/linux/bottom_half.h                   |    5 
 include/linux/if_addr.h                       |    6 +
 include/linux/if_link.h                       |    6 +
 include/linux/interrupt.h                     |    7 -
 include/linux/rtnetlink.h                     |    2 
 include/linux/spinlock.h                      |    1 
 kernel/power/disk.c                           |    2 
 kernel/softirq.c                              |    2 
 net/bridge/br_netfilter.c                     |   36 +++++-
 net/bridge/netfilter/ebtables.c               |   54 +++++----
 net/ieee80211/softmac/ieee80211softmac_scan.c |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c   |    3 
 net/ipv4/netfilter/arp_tables.c               |   48 ++++----
 net/ipv4/netfilter/ip_tables.c                |  144 +++++++++++++-------------
 net/ipv4/route.c                              |    2 
 net/ipv4/xfrm4_policy.c                       |    2 
 net/ipv6/ndisc.c                              |   16 ++
 net/ipv6/netfilter/ip6_tables.c               |   59 ++++------
 net/irda/irttp.c                              |    4 
 net/sched/act_gact.c                          |    4 
 net/sched/act_police.c                        |   26 +++-
 39 files changed, 323 insertions(+), 277 deletions(-)

Summary of changes from v2.6.19 to v2.6.19.1
============================================

Al Viro (5):
      EBTABLES: Fix wraparounds in ebt_entries verification.
      EBTABLES: Verify that ebt_entries have zero ->distinguisher.
      EBTABLES: Deal with the worst-case behaviour in loop checks.
      EBTABLES: Prevent wraparounds in checks for entry components' sizes.
      TOKENRING: Remote memory corruptor in ibmtr.c

Alexey Dobriyan (1):
      do_coredump() and not stopping rewrite attacks? (CVE-2006-6304)

Andrew Morton (2):
      add bottom_half.h
      drm-sis linkage fix

Andrey Mirkin (1):
      compat: skip data conversion in compat_sys_mount when data_page is NULL

Bart De Schuymer (1):
      NETFILTER: bridge netfilter: deal with martians correctly

Chris Wright (1):
      Linux 2.6.19.1

Daniel Barkalow (1):
      forcedeth: Disable INTx when enabling MSI in forcedeth

David Miller (4):
      IPV6 NDISC: Calculate packet length correctly for allocation.
      PKT_SCHED act_gact: division by zero
      IPSEC: Fix inetpeer leak in ipv4 xfrm dst entries.
      NETLINK: Put {IFA,IFLA}_{RTA,PAYLOAD} macros back for userspace.

Dmitry Mishin (2):
      NETFILTER: Fix {ip, ip6, arp}_tables hook validation
      NETFILTER: Fix iptables compat hook validation

Herbert Xu (1):
      cryptoloop: Select CRYPTO_CBC

Hirokazu Takata (1):
      m32r: make userspace headers platform-independent

Jeet Chaudhuri (1):
      IrDA: Incorrect TTP header reservation

Jiri Kosina (1):
      autofs: fix error code path in autofs_fill_sb()

Jurij Smakov (1):
      SUNHME: Fix for sunhme failures on x86

Len Brown (1):
      Revert "ACPI: SCI interrupt source override"

Maxime Austruy (1):
      softmac: fix unbalanced mutex_lock/unlock in ieee80211softmac_wx_set_mlme

Michael Buesch (1):
      softmac: remove netif_tx_disable when scanning

Michael S Tsirkin (1):
      IB/ucm: Fix deadlock in cleanup

Patrick McHardy (2):
      NET_SCHED: policer: restore compatibility with old iproute binaries
      XFRM: Use output device disable_xfrm for forwarded packets

Rafael J Wysocki (1):
      PM: Fix swsusp debug mode testproc

Ravikiran G Thirumalai (1):
      x86: Fix boot hang due to nmi watchdog init code

Sean Young (1):
      USB: Fix oops in PhidgetServo

Thomas Graf (1):
      NETLINK: Restore API compatibility of address and neighbour bits

Zachary Amsden (1):
      softirq: remove BUG_ONs which can incorrectly trigger

