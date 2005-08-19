Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVHSDfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVHSDfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVHSDfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:35:07 -0400
Received: from havoc.gtf.org ([69.61.125.42]:60827 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932086AbVHSDfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:35:04 -0400
Date: Thu, 18 Aug 2005 23:34:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [git] netdev-2.6 queue updated
Message-ID: <20050819033459.GA16382@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I finally got around to creating something that has been missing since
BitKeeper disappeared, and something that Andrew has been wanting
from me for a while:  an amalgamation of all the netdev branches that
I maintain internally.

First, a bit of background.  Most patches I receive are dumped into the
'upstream' branch of netdev-2.6.git.  However, some patches require more
development or review before they are ready for upstream.  In such cases,
patches are divided into branches by category:  chelsio (new 10gb driver
from Chelsio Comm), e100 (e100 changes some users complained about),
sis190 (resurrected SiS190 driver), ieee80211-wifi (wireless layer
rewrite), etc.

All these branches are terribly useful to me.  Dividing the changes up in
this manner means that some less-cooked changes can stay in the git
repository, while I can forward important changes to Andrew/Linus
immediately.  The downside is that this system leaves people with a
confusing set of branches.

The solution is something that I maintained during the BitKeeper days,
the "ALL" branch.  As the name implies, this branch contains all the
branches in netdev-2.6.git.  The creation of this branch also facilitates
the creation of a single downloadable patch (see below) that users can
easily patch into their kernel, without having to learn git.


To Andrew Morton specifically:  Please replace all git-netdev-* patches
with the content of the 'ALL' branch.  You can simply pull the 'ALL'
branch, and ignore all others.


The following is the current contents of the netdev queue's ALL branch,
which is a superset of all other branches in the repository:





git users:   'ALL' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.13-rc6-git10-netdev1.patch.bz2


 drivers/net/wireless/ieee802_11.h             |   78 
 Documentation/networking/README.ipw2100       |  246 
 Documentation/networking/README.ipw2200       |  290 
 Documentation/networking/cxgb.txt             |  352 +
 Documentation/networking/phy.txt              |  288 
 MAINTAINERS                                   |   13 
 drivers/net/Kconfig                           |   51 
 drivers/net/Makefile                          |    4 
 drivers/net/Space.c                           |    6 
 drivers/net/bonding/bond_alb.c                |   17 
 drivers/net/chelsio/Makefile                  |   11 
 drivers/net/chelsio/common.h                  |  314 
 drivers/net/chelsio/cphy.h                    |  148 
 drivers/net/chelsio/cpl5_cmd.h                |  145 
 drivers/net/chelsio/cxgb2.c                   | 1256 +++
 drivers/net/chelsio/elmer0.h                  |  151 
 drivers/net/chelsio/espi.c                    |  346 +
 drivers/net/chelsio/espi.h                    |   68 
 drivers/net/chelsio/gmac.h                    |  134 
 drivers/net/chelsio/mv88x201x.c               |  252 
 drivers/net/chelsio/pm3393.c                  |  826 ++
 drivers/net/chelsio/regs.h                    |  468 +
 drivers/net/chelsio/sge.c                     | 1684 +++++
 drivers/net/chelsio/sge.h                     |  105 
 drivers/net/chelsio/subr.c                    |  812 ++
 drivers/net/chelsio/suni1x10gexp_regs.h       |  213 
 drivers/net/e100.c                            |  225 
 drivers/net/forcedeth.c                       |  577 +
 drivers/net/hamradio/baycom_epp.c             |    3 
 drivers/net/hamradio/baycom_par.c             |    3 
 drivers/net/hamradio/baycom_ser_fdx.c         |    3 
 drivers/net/hamradio/baycom_ser_hdx.c         |    3 
 drivers/net/hamradio/mkiss.c                  |    3 
 drivers/net/ixgb/ixgb.h                       |    2 
 drivers/net/ixgb/ixgb_ee.c                    |  170 
 drivers/net/ixgb/ixgb_ethtool.c               |   59 
 drivers/net/ixgb/ixgb_hw.h                    |    9 
 drivers/net/ixgb/ixgb_main.c                  |   53 
 drivers/net/loopback.c                        |   22 
 drivers/net/pci-skeleton.c                    |    6 
 drivers/net/phy/Kconfig                       |   49 
 drivers/net/phy/Makefile                      |    9 
 drivers/net/phy/cicada.c                      |  134 
 drivers/net/phy/davicom.c                     |  195 
 drivers/net/phy/lxt.c                         |  179 
 drivers/net/phy/marvell.c                     |  140 
 drivers/net/phy/mdio_bus.c                    |   99 
 drivers/net/phy/phy.c                         |  690 ++
 drivers/net/phy/phy_device.c                  |  572 +
 drivers/net/phy/qsemi.c                       |  143 
 drivers/net/s2io-regs.h                       |   85 
 drivers/net/s2io.c                            | 3098 +++++----
 drivers/net/s2io.h                            |  364 -
 drivers/net/sis190.c                          | 1842 +++++
 drivers/net/skge.c                            |   63 
 drivers/net/skge.h                            |   19 
 drivers/net/sky2.c                            | 2686 ++++++++
 drivers/net/sky2.h                            | 1935 +++++
 drivers/net/smc91x.c                          |  159 
 drivers/net/smc91x.h                          |    9 
 drivers/net/tokenring/abyss.c                 |    2 
 drivers/net/tokenring/proteon.c               |  104 
 drivers/net/tokenring/skisa.c                 |  104 
 drivers/net/tokenring/tms380tr.c              |   37 
 drivers/net/tokenring/tms380tr.h              |    8 
 drivers/net/tokenring/tmspci.c                |    4 
 drivers/net/tulip/Kconfig                     |   12 
 drivers/net/tulip/Makefile                    |    1 
 drivers/net/tulip/media.c                     |   36 
 drivers/net/tulip/timer.c                     |    1 
 drivers/net/tulip/tulip.h                     |    8 
 drivers/net/tulip/tulip_core.c                |   34 
 drivers/net/tulip/uli526x.c                   | 1770 +++++
 drivers/net/wireless/Kconfig                  |  106 
 drivers/net/wireless/Makefile                 |    6 
 drivers/net/wireless/airo.c                   |   65 
 drivers/net/wireless/atmel.c                  |   62 
 drivers/net/wireless/hostap/Kconfig           |   71 
 drivers/net/wireless/hostap/Makefile          |    5 
 drivers/net/wireless/hostap/hostap.c          | 1198 +++
 drivers/net/wireless/hostap/hostap.h          |   57 
 drivers/net/wireless/hostap/hostap_80211.h    |   96 
 drivers/net/wireless/hostap/hostap_80211_rx.c | 1091 +++
 drivers/net/wireless/hostap/hostap_80211_tx.c |  524 +
 drivers/net/wireless/hostap/hostap_ap.c       | 3288 +++++++++
 drivers/net/wireless/hostap/hostap_ap.h       |  261 
 drivers/net/wireless/hostap/hostap_common.h   |  435 +
 drivers/net/wireless/hostap/hostap_config.h   |   55 
 drivers/net/wireless/hostap/hostap_cs.c       | 1030 +++
 drivers/net/wireless/hostap/hostap_download.c |  766 ++
 drivers/net/wireless/hostap/hostap_hw.c       | 3445 ++++++++++
 drivers/net/wireless/hostap/hostap_info.c     |  499 +
 drivers/net/wireless/hostap/hostap_ioctl.c    | 4102 ++++++++++++
 drivers/net/wireless/hostap/hostap_pci.c      |  473 +
 drivers/net/wireless/hostap/hostap_plx.c      |  645 +
 drivers/net/wireless/hostap/hostap_proc.c     |  448 +
 drivers/net/wireless/hostap/hostap_wlan.h     | 1033 +++
 drivers/net/wireless/ipw2100.c                | 8641 ++++++++++++++++++++++++++
 drivers/net/wireless/ipw2100.h                | 1195 +++
 drivers/net/wireless/ipw2200.c                | 7361 ++++++++++++++++++++++
 drivers/net/wireless/ipw2200.h                | 1770 +++++
 drivers/net/wireless/orinoco.c                |   89 
 drivers/net/wireless/strip.c                  |    2 
 drivers/net/wireless/wavelan_cs.c             |   26 
 drivers/net/wireless/wavelan_cs.h             |    6 
 drivers/net/wireless/wavelan_cs.p.h           |   17 
 drivers/net/wireless/wl3501.h                 |    4 
 drivers/net/wireless/wl3501_cs.c              |   11 
 drivers/usb/net/Makefile                      |    2 
 drivers/usb/net/zd1201.c                      |   16 
 include/linux/etherdevice.h                   |    6 
 include/linux/ethtool.h                       |    4 
 include/linux/mii.h                           |    9 
 include/linux/pci_ids.h                       |    1 
 include/linux/phy.h                           |  360 +
 include/net/ieee80211.h                       |    9 
 include/net/ieee80211_crypt.h                 |   86 
 net/Kconfig                                   |    1 
 net/Makefile                                  |    1 
 net/ieee80211/Kconfig                         |   69 
 net/ieee80211/Makefile                        |   11 
 net/ieee80211/ieee80211_crypt.c               |  259 
 net/ieee80211/ieee80211_crypt_ccmp.c          |  470 +
 net/ieee80211/ieee80211_crypt_tkip.c          |  708 ++
 net/ieee80211/ieee80211_crypt_wep.c           |  272 
 net/ieee80211/ieee80211_module.c              |  273 
 net/ieee80211/ieee80211_rx.c                  | 1205 +++
 net/ieee80211/ieee80211_tx.c                  |  447 +
 net/ieee80211/ieee80211_wx.c                  |  471 +
 129 files changed, 65323 insertions(+), 2247 deletions(-)




Adrian Bunk:
  net/ieee80211/ieee80211_tx.c: swapped memset arguments
  net/ieee80211/: make two functions static
  fix IEEE80211_CRYPT_* selects
  ieee80211: remove pci.h #include's
  ieee80211: fix recursive ipw2200 dependencies
  hostap update
  include/net/ieee80211.h must #include <linux/wireless.h>

Al Viro:
  ieee80211_module.c::store_debug_level() cleanup
  zd1201 fixes

Andrew Morton:
  ipw2100 old gcc fix
  wireless-device-attr-fixes
  wireless-device-attr-fixes-2

Andy Fleming:
  This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling

Brandon Enochs:
  hostap update

Christoph Lameter:
  A new 10GB Ethernet Driver by Chelsio Communications

Chuck Ebbert:
  loopback: #ifdef the TSO code
  loopback: optimize stats
  loopback: whitespace cleanup

Dave Hansen:
  hostap update

Francois Romieu:
  sis190: resurrection
  sis190: netconsole support.
  sis190: ethtool/mii support.
  sis190: add MAINTAINER entry.
  sis190: merge some register related information from SiS driver.
  sis190: remove hardcoded constants.
  sis190: initialisation of MAC address.
  sis190: the size of the Rx buffer is constrained
  sis190: extract bits definition from SiS driver.
  sis190: add endian annotations.
  sis190: allow a non-hardcoded ID for the PHY.
  sis190: dummy read is required by the status register
  sis190: new PHY detection code.
  sis190: PHY identifier for the K8S-MX motherboard.
  sis190: compare the lpa to the local advertisement

Henrik Brix Andersen:
  hostap update

James Ketrenos:
  Add ipw2100 wireless driver.
  Add ipw2200 wireless driver.

Jar:
  hostap update

Jeff Garzik:
  [netdrvr smc91x] use __iomem addresses in eeprom read/write changes
  [NET] ieee80211 subsystem
  [wireless] ipw2100: fix build after applying SuSE cleanups
  wireless: fix ipw warning; add is_broadcast_ether_addr() to linux/etherdevice.h
  ieee80211: trim trailing whitespace
  [wireless ipw2200] trim trailing whitespace
  [wireless hostap] trim trailing whitespace
  Fix numerous minor problems with new phy subsystem.
  phy subsystem: more cleanups
  ieee80211: remove last uses of compat define WLAN_CAPABILITY_BSS

Jiri Benc:
  ieee80211: cleanup
  ieee80211: fix ipw 64bit compilation warnings

Jochen Friedrich:
  tms380tr: move to DMA API

John W. Linville:
  bonding: ALB -- allow slave to use bond's MAC address if its own MAC address conflicts

Jouni Malinen:
  Add HostAP wireless driver.
  hostap update
  hostap update
  hostap update
  hostap update
  hostap update
  hostap update
  hostap: Start using net/ieee80211.h
  hostap: Replace crypto code with net/ieee80211 version
  hostap: Fix skb->cb use for TX meta data
  hostap: Remove experimental PCI bus master/DMA code
  hostap: Use void *hw_priv instead of #ifdef in local data
  hostap: Remove extra defines
  hostap: Replace hostap_ieee80211_hdr with ieee80211_hdr
  hostap: Use ieee80211 WLAN_FC_GET_{TYPE,STYPE}
  ieee80211: Fix frame control pver mask
  ieee80211: Capability field is called ESS, not BSS
  hostap: Capability field is called ESS, not BSS
  hostap: Replace WLAN_FC_ defines with ieee80211 ones

ladis@linux-mips.org:
  smc91x: get/set eeprom

Malli Chilakala:
  e100: Added cpu cycle saver microcode for 8086:[1209/1229]
  e100: Driver version, white space, comments & other
  ixgb: Set RXDCTL:PTHRESH/HTHRESH to zero
  ixgb: Fix unnecessary link state messages
  ixgb: Use netdev_priv() instead of netdev->priv
  ixgb: Fix Broadcast/Multicast packets received statistics
  ixgb: Fix data output by ethtool -d
  ixgb: Ethtool cleanup patch from Stephen Hemminger
  ixgb: Remove unused functions
  ixgb: Redefined buffer_info-dma to be dma_addr_t instead of uint64
  ixgb: Driver version, white space, comments

Manfred Spraul:
  forcedeth: Jumbo Frame Support
  forcedeth: Improve ethtool support
  forcedeth: rewritten tx irq handling
  forcedeth: 64-bit DMA support
  forcedeth: Add set_mac_address support
  forcedeth: write back original mac address during ifdown

Marcelo Feitoza Parisi:
  Use time_before in hamradio drivers

Pavel Machek:
  ipw2100: remove commented-out code
  ipw2100: assume recent kernel
  ipw2100: kill dead macros
  ipw2100: small cleanups

Pavel Roskin:
  hostap update

Peer Chen:
  [netdrvr] add 'uli526x' driver (a tulip clone)
  [netdrvr tulip] Remove ULi-specific code from generic tulip driver

Peter Hagervall:
  orinoco: Sparse fixes

raghavendra.koushik@neterion.com:
  S2io: Code cleanup
  S2io: Hardware fixes
  S2io: Software fixes
  S2io: Removed memory leaks
  S2io: Performance improvements
  S2io: Support for runtime MTU change
  S2io: Timer based slowpath handling
  S2io: VLAN support
  S2io: Support for Xframe II NIC
  S2io: Support for bimodal interrupts
  S2io: New link handling scheme for Xframe II
  S2io: Miscellaneous fixes
  S2io: Errors found during review

Richard Purdie:
  hostap update

Scott Bardone:
  Update Chelsio gige net driver.

Stephen Hemminger:
  skge: stop bogus sensor messages
  skge: fibre vs copper detection cleanup
  skge: increase receive flush threshold default
  skge: turn on link status LED
  sky2: new experimental Marvell Yukon2 driver

Tobias Klauser:
  drivers/net/wireless/ipw2100: Use the DMA_32BIT_MASK constant
  drivers/net/wireless/ipw2200: Use the DMA_32BIT_MASK constant

Victor Fusco:
  drivers/net/pci-skeleton.c: MODULE_PARM -> module_param


