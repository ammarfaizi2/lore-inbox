Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbVKIGxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbVKIGxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 01:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKIGxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 01:53:48 -0500
Received: from havoc.gtf.org ([69.61.125.42]:46479 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965094AbVKIGxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 01:53:47 -0500
Date: Wed, 9 Nov 2005 01:53:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20051109065345.GA16769@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates, including a big ipw wireless update:

 include/linux/eeprom.h                    |  136 
 Documentation/networking/README.ipw2100   |  119 
 Documentation/networking/README.ipw2200   |  194 
 MAINTAINERS                               |   18 
 arch/um/drivers/net_kern.c                |   36 
 arch/xtensa/platform-iss/network.c        |   33 
 drivers/net/Kconfig                       |    2 
 drivers/net/b44.c                         |  177 
 drivers/net/b44.h                         |   75 
 drivers/net/bonding/bond_main.c           |   32 
 drivers/net/bonding/bonding.h             |    7 
 drivers/net/cris/eth_v10.c                |  149 
 drivers/net/dgrs.c                        |   16 
 drivers/net/e100.c                        |    6 
 drivers/net/ns83820.c                     |   13 
 drivers/net/s2io.c                        |   43 
 drivers/net/skge.c                        |  267 -
 drivers/net/skge.h                        |    2 
 drivers/net/wireless/airo.c               |   36 
 drivers/net/wireless/airo_cs.c            |    6 
 drivers/net/wireless/atmel.c              |    2 
 drivers/net/wireless/atmel_cs.c           |    6 
 drivers/net/wireless/ipw2100.c            | 2862 ++++++------
 drivers/net/wireless/ipw2100.h            |  171 
 drivers/net/wireless/ipw2200.c            | 6861 +++++++++++++++++++++++-------
 drivers/net/wireless/ipw2200.h            |  592 +-
 drivers/net/wireless/prism54/isl_38xx.c   |   12 
 drivers/net/wireless/prism54/islpci_eth.c |   10 
 drivers/net/wireless/wavelan_cs.c         |    3 
 drivers/net/wireless/wl3501_cs.c          |    3 
 include/net/ieee80211.h                   |    2 
 include/net/ieee80211_crypt.h             |    1 
 net/ieee80211/ieee80211_crypt.c           |  156 
 net/ieee80211/ieee80211_rx.c              |    2 
 net/ieee80211/ieee80211_wx.c              |   14 
 35 files changed, 8273 insertions(+), 3791 deletions(-)

Adrian Bunk:
      fix NET_RADIO=n, IEEE80211=y compile
      kill include/linux/eeprom.h
      drivers/net/s2io.c: make functions static

Alexey Dobriyan:
      atmel: memset correct range

Ashutosh Naik:
      dgrs: fix warnings when CONFIG_ISA and CONFIG_PCI are not enabled

Ben Cahill:
      Fixes missed beacon logic in relation to on-network AP roaming.

Benoit Boissinot:
      Fix 'Driver using old /proc/net/wireless support, please fix driver !' message.

Christoph Hellwig:
      ieee80211: cleanup crypto list handling, other minor cleanups.
      cris v10 eth: use ethtool_ops
      xtensa platform-iss network: remove no-op ioctl handler
      uml_net: use ethtool_ops

Francois Romieu:
      b44: b44_start_xmit returns with a lock held when it fails allocating
      b44: miscellaneous cleanup
      b44: expose counters through ethtool
      b44: s/spin_lock_irqsave/spin_lock/ in b44_interrupt
      b44: late request_irq in b44_open
      b44: replace B44_FLAG_INIT_COMPLETE with netif_running()
      b44: race on device closing
      b44: increase version number

Hong Liu:
      Fixes the ad-hoc network WEP key list issue.
      [Bug 455] Fix frequent channel change generates firmware fatal error.
      Don't set hardware WEP if we are actually using TKIP/AES.
      Mixed PTK/GTK CCMP/TKIP support.
      Card with WEP enabled and using shared-key auth will have firmware
      Fixes problem with WEP not working (association succeeds, but no Tx/Rx)
      Fixes WEP firmware error condition.
      Fixed problem with not being able to send broadcast packets.

James Ketrenos:
      scripts/Lindent on ieee80211 subsystem.
      Update version ieee80211 stamp to 1.1.7
      Ran scripts/Lindent on drivers/net/wireless/ipw2{1,2}00.{c,h}
      Catch ipw2200 up to equivelancy with v1.0.1
      Catch ipw2200 up to equivelancy with v1.0.2
      Catch ipw2200 up to equivelancy with v1.0.3
      Catch ipw2200 up to equivelancy with v1.0.4
      Catch ipw2100 up to equivelancy with v1.1.1
      Catch ipw2200 up to equivelancy with v1.0.5
      Changed default # of missed beacons to miss before disassociation to 24
      Updated to support ieee80211 callback to is_queue_full for 802.11e
      Fixed some compiler issues if CONFIG_IPW2200_QOS is enabled.
      Added more useful geography encoding so people's experience with
      Modified ipw_config and STATUS_INIT setting to correct race condition
      Switched firmware error dumping so that it will capture a log available
      Changed all of the ipw_send_cmd() calls to return any ipw_send_cmd error
      Added cmdlog in non-debug systems.
      Updated ipw2200 to use the new ieee80211 callbacks
      Added wait_state wakeup on scan completion.
      Fixed problem with get_cmd_string not existing if CONFIG_IPW_DEBUG disabled.
      Removed PF_SYNCTHREAD legacy.
      Updated driver version stamps for ipw2100 (1.1.3) and ipw2200 (1.0.7)
      Pulled out a stray KERNEL_VERSION check around the suspend handler.
      Removed legacy WIRELESS_EXT checks from ipw2200.c
      Removed warning about TKIP not being configured if countermeasures are
      Added channel support for ipw2200 cards identified as 'ZZR'
      Fixed parameter reordering in firmware log routine.
      Updated firmware version stamp to 2.4 from 2.3 so it will use the latest firmware.
      Update version ipw2200 stamp to 1.0.8
      Updated READMEs and MAINTAINERS for the ipw2100 and ipw2200 drivers.

Jay Vosburgh:
      bonding: fix feature consolidation

Jeff Garzik:
      Merge branch 'master'
      Merge git://git.tuxdriver.com/git/netdev-jwl
      Merge rsync://bughost.org/repos/ieee80211-delta/
      Merge rsync://bughost.org/repos/ipw-delta/
      [wireless ipw2100] kill unused-var warnings for debug-disabled code

jketreno@io.(none):
      Fixed WEP on ipw2100 (priv->sec was being used instead of

Liu Hong:
      [Bug 339] Fix ipw2100 iwconfig set/get txpower.
      [Bug 637] Set tx power for A band.
      Migrated some of the channel verification code back into the driver to

Luiz Fernando Capitulino:
      Fix sparse warning in e100 driver.

Mike Kershaw:
      Adds radiotap support to ipw2200 in monitor mode..

Panagiotis Issaris:
      wireless net: Conversions of kmalloc/memset to kzalloc

Peter Jones:
      Make all the places the firmware fails to load showerrors (in decimal,
      Fixed is_network_packet() to include checking for broadcast packets.

Ralf Baechle:
      IOC: And don't mark the things as broken Cowboy.

Roger While:
      prism54 : Unused variable / extraneous udelay
      prism54 : Transmit stats updated in wrong place

Stephen Hemminger:
      skge: clear PCI PHY COMA mode on boot
      skge: use kzalloc
      skge: add mii ioctl support
      skge: goto low power mode on shutdown
      skge: use prefetch on receive
      skge: spelling fixes
      skge: increase version number

Volker Braun:
      Fix problem with WEP unicast key > index 0

Zhu Yi:
      IPW_DEBUG has already included DRV_NAME, remove double prefix print.
      Move code from ipw2100_wpa_enable to IPW2100_PARAM_DROP_UNENCRYPTED to
      Fix hardware encryption (both WEP and AES) doesn't work with fragmentation.
      Fix is_duplicate_packet() bug for fragmentation number setting.
      [bug 667] Fix the notorious "No space for Tx" bug.
      Workaround kernel BUG_ON panic caused by unexpected duplicate packets.
      Disable host fragmentation in open mode since IPW2200/2915 hardware
      [Bug 792] Fix WPA-PSK AES both for -Dipw and -Dwext.
      [Bug 701] Fix a misuse of ieee->mode with ieee->iw_mode.
      Fix ipw_wx_get_txpow shows wrong disabled value.
      Fix firmware error when setting tx_power.
      [Bug 760] Fix setting WEP key in monitor mode causes IV lost.
      [Fix bug# 771] Too many (8) bytes recieved when using AES/hwcrypto


[patch snipped due to size]

