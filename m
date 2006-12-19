Return-Path: <linux-kernel-owner+w=401wt.eu-S932531AbWLSAoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWLSAoN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWLSAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:44:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53692 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbWLSAoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:44:10 -0500
Date: Mon, 18 Dec 2006 16:48:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.6
Message-ID: <20061219004824.GN10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.6 kernel.
An assortment of important fixes with one security related fix that is
associated with less common bluetooth hardware:

1dca7c28: Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.18.5 and 2.6.18.6, as it is small enough to do so.
                                                                                
The updated 2.6.18.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris
--------

 Makefile                                      |    2 
 arch/arm/kernel/calls.S                       |   13 +++++
 arch/m32r/kernel/entry.S                      |   65 +++++++++++---------------
 arch/x86_64/kernel/setup.c                    |    5 +-
 drivers/ieee1394/ohci1394.c                   |   21 ++++++--
 drivers/md/dm-crypt.c                         |    6 +-
 drivers/md/dm-snap.c                          |    1 
 drivers/media/dvb/frontends/lgdt330x.c        |    6 --
 drivers/media/video/tuner-simple.c            |    2 
 drivers/media/video/tuner-types.c             |   14 -----
 drivers/net/bonding/bond_main.c               |    2 
 drivers/net/forcedeth.c                       |    3 +
 drivers/net/sunhme.c                          |    5 ++
 fs/compat.c                                   |    2 
 include/asm-arm/unistd.h                      |   13 +++++
 include/asm-m32r/ptrace.h                     |   28 +----------
 include/asm-m32r/sigcontext.h                 |   13 -----
 kernel/softirq.c                              |    2 
 net/bluetooth/cmtp/capi.c                     |   39 +++++++++++++--
 net/bridge/netfilter/ebtables.c               |   54 +++++++++++++--------
 net/ieee80211/softmac/ieee80211softmac_scan.c |    2 
 net/ipv4/netfilter/ip_tables.c                |    5 +-
 net/ipv4/route.c                              |    2 
 net/ipv4/xfrm4_policy.c                       |    2 
 net/irda/irttp.c                              |    4 -
 net/sched/act_gact.c                          |    4 -
 net/sched/act_police.c                        |   26 ++++++++--
 27 files changed, 199 insertions(+), 142 deletions(-)

Summary of changes from v2.6.18.5 to v2.6.18.6
============================================

Al Viro (4):
      EBTABLES: Fix wraparounds in ebt_entries verification.
      EBTABLES: Verify that ebt_entries have zero ->distinguisher.
      EBTABLES: Deal with the worst-case behaviour in loop checks.
      EBTABLES: Prevent wraparounds in checks for entry components' sizes.

Andrey Mirkin (1):
      skip data conversion in compat_sys_mount when data_page is NULL

Andy Gospodarek (1):
      bonding: incorrect bonding state reported via ioctl

Arjan van de Ven (1):
      x86-64: Mark rdtsc as sync only for netburst, not for core2

Chris Wright (1):
      Linux 2.6.18.6

Christophe Saout (1):
      dm crypt: Fix data corruption with dm-crypt over RAID5

Daniel Barkalow (1):
      forcedeth: Disable INTx when enabling MSI in forcedeth

David Miller (3):
      PKT_SCHED act_gact: division by zero
      XFRM: Use output device disable_xfrm for forwarded packets
      IPSEC: Fix inetpeer leak in ipv4 xfrm dst entries.

Hans Verkuil (1):
      V4L: Fix broken TUNER_LG_NTSC_TAPE radio support

Hirokazu Takata (1):
      m32r: make userspace headers platform-independent

Jeet Chaudhuri (1):
      IrDA: Incorrect TTP header reservation

Jurij Smakov (1):
      SUNHME: Fix for sunhme failures on x86

Marcel Holtmann (1):
      Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)

Michael Buesch (1):
      softmac: remove netif_tx_disable when scanning

Michael Krufky (1):
      DVB: lgdt330x: fix signal / lock status detection bug

Milan Broz (1):
      dm snapshot: fix freeing pending exception

Patrick McHardy (2):
      NET_SCHED: policer: restore compatibility with old iproute binaries
      NETFILTER: ip_tables: revision support for compat code

Russell King (1):
      ARM: Add sys_*at syscalls

Stefan Richter (1):
      ieee1394: ohci1394: add PPC_PMAC platform code to driver probe

Zachary Amsden (1):
      softirq: remove BUG_ONs which can incorrectly trigger

