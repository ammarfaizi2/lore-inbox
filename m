Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVCWBqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVCWBqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCWBqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:46:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16359 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262691AbVCWBqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:46:38 -0500
Message-ID: <4240CA69.9020902@pobox.com>
Date: Tue, 22 Mar 2005 20:46:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       Jouni Malinen <jkmaline@cc.hut.fi>,
       "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       "David S. Miller" <davem@davemloft.net>
Subject: 2.6.x wireless update and status
Content-Type: multipart/mixed;
 boundary="------------060906070504060809050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906070504060809050909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just updated the wireless-2.6 queue to include a HostAP update, and to 
add Wireless Extensions 18 (WPA).  See attached for BK info, patch info, 
and changelog.

I also wanted to comment on the general status and direction of wireless.


So far, the following decisions have been made:

1) Use HostAP as the basis for a wireless stack that can drive "softMAC" 
wireless hardware.

2) We want wireless to be better integrated into the network stack, 
rather than "faking" 802.3 ethernet.

3) The in-kernel Wireless Extensions API will see some changes, to be 
more type-safe (and more like other Linux APIs).  Userland ABI 
compatibility is desired, but don't care about kernel API compatibility.


Along these lines, the following work has been done:
* HostAP has been integrated into wireless-2.6, and Jouni has been 
updating it.
* Intel submitted the HostAP-derived ieee80211 lib code.
* DaveM posted some template code[1] that hackers can use as a starting 
point for true wireless protocol/management code.
* A few people have submitted some wireless cleanup patches associated 
with this.



Moving forward, the next "todo" for kernel wireless hackers is to get 
ieee80211 common code lib into shape, namely:
* Merge Intel ipw drivers, which use ieee80211
* Update HostAP to use ieee80211
* Merge/convert other drivers to use ieee80211?

At that point, ieee80211 has in-tree users, and I can push both the ipw 
and HostAP drivers upstream.  After that milestone, working on the 
wireless protocol layer (DaveM code template) and improving the 
in-kernel WE API will be key focus.


There is one minor point of contention so far.  Jouni stated he prefers 
that HostAP go upstream before it gets updated to use ieee80211.  I 
respectfully disagree, and prefer that HostAP is updated -first- to use 
the ieee80211 lib, before going upstream.

	Jeff


P.S.  For Realtek RTL8180 owners, I'm hoping to have some time in the 
next month or two to flesh out a driver that uses the ieee80211 lib in 
the wireless-2.6 queue.

[1] 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/davem-p80211.tar.bz2


--------------060906070504060809050909
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/wireless-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.12-rc1-bk1-wireless1.patch.bz2

This will update the following files:

 drivers/net/wireless/ieee802_11.h               |   78 
 MAINTAINERS                                     |    7 
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/Makefile                   |    2 
 drivers/net/wireless/atmel.c                    |   62 
 drivers/net/wireless/hostap/Kconfig             |  104 
 drivers/net/wireless/hostap/Makefile            |    8 
 drivers/net/wireless/hostap/hostap.c            | 1205 +++++++
 drivers/net/wireless/hostap/hostap.h            |   57 
 drivers/net/wireless/hostap/hostap_80211.h      |  107 
 drivers/net/wireless/hostap/hostap_80211_rx.c   | 1084 ++++++
 drivers/net/wireless/hostap/hostap_80211_tx.c   |  522 +++
 drivers/net/wireless/hostap/hostap_ap.c         | 3286 +++++++++++++++++++
 drivers/net/wireless/hostap/hostap_ap.h         |  272 +
 drivers/net/wireless/hostap/hostap_common.h     |  557 +++
 drivers/net/wireless/hostap/hostap_config.h     |   86 
 drivers/net/wireless/hostap/hostap_crypt.c      |  167 
 drivers/net/wireless/hostap/hostap_crypt.h      |   50 
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |  486 ++
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |  696 ++++
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |  281 +
 drivers/net/wireless/hostap/hostap_cs.c         |  929 +++++
 drivers/net/wireless/hostap/hostap_download.c   |  766 ++++
 drivers/net/wireless/hostap/hostap_hw.c         | 3631 +++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_info.c       |  478 ++
 drivers/net/wireless/hostap/hostap_ioctl.c      | 4116 ++++++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_pci.c        |  453 ++
 drivers/net/wireless/hostap/hostap_plx.c        |  612 +++
 drivers/net/wireless/hostap/hostap_proc.c       |  466 ++
 drivers/net/wireless/hostap/hostap_wlan.h       | 1075 ++++++
 drivers/net/wireless/orinoco.c                  |   11 
 drivers/net/wireless/wl3501.h                   |    4 
 include/linux/wireless.h                        |  283 +
 include/net/ieee80211.h                         |  887 +++++
 include/net/ieee80211_crypt.h                   |   86 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/wireless.c                             |   74 
 net/ieee80211/Kconfig                           |   67 
 net/ieee80211/Makefile                          |   11 
 net/ieee80211/ieee80211_crypt.c                 |  259 +
 net/ieee80211/ieee80211_crypt_ccmp.c            |  470 ++
 net/ieee80211/ieee80211_crypt_tkip.c            |  708 ++++
 net/ieee80211/ieee80211_crypt_wep.c             |  272 +
 net/ieee80211/ieee80211_module.c                |  268 +
 net/ieee80211/ieee80211_rx.c                    | 1206 +++++++
 net/ieee80211/ieee80211_tx.c                    |  448 ++
 net/ieee80211/ieee80211_wx.c                    |  471 ++
 48 files changed, 27052 insertions(+), 121 deletions(-)

through these ChangeSets:

<jketreno:linux.intel.com>:
  o ieee80211 subsystem

<mgalgoci:parcelfarce.linux.theplanet.co.uk>:
  o wireless-2.6 cleanup

Adrian Bunk:
  o net/ieee80211/Kconfig: don't describe what gets selected

Alexander Viro:
  o hostap __user annotations

François Romieu:
  o ieee80211: offset_in_page() removal
  o ieee80211: C99 initialization for eap_types
  o ieee80211: failure of ieee80211_crypto_init()

Jean Tourrilhes:
  o Wireless Extensions 18 (aka WPA)

Jeff Garzik:
  o [wireless hostap] update for new pci_save_state()

Joshua Kwan:
  o hostap: fix Kconfig typos and missing select CRYPTO

Jouni Malinen:
  o hostap: Update to use the new WE18 proposal
  o hostap: Filter disconnect events
  o hostap: Improved suspend
  o hostap: Rate limiting for debug messages
  o hostap: Clear station statistic on accounting start
  o hostap: Fix procfs rmdir after ifname change
  o hostap: Add support for multi-func SanDisk ConnectPlus
  o hostap: Disable interrupts before Genesis mode
  o hostap: Include asm/io.h
  o hostap: Clear station statistic on accounting start
  o Host AP: Replaced MODULE_PARM with module_param*
  o Host AP: Replaced direct dev->priv references with netdev_priv(dev)
  o Host AP: Updated to use Linux wireless extensions v17
  o Host AP: pci_register_driver() return value changes
  o Host AP: Fix netif_carrier_off() in non-client modes
  o Host AP: Fix PRISM2_IO_DEBUG
  o Host AP: Use void __iomem * with {read,write}{b,w}
  o Host AP: Fix card enabling after firmware download
  o Host AP: Do not bridge packets to unauthorized ports
  o Host AP: Fix compilation with PRISM2_NO_STATION_MODES defined
  o Host AP: Prevent STAs from associating using AP address
  o Host AP: Fix hw address changing for wifi# interface
  o Host AP: Remove ioctl debug messages
  o Host AP: Ignore (Re)AssocResp messages silently
  o Host AP: Fix interface packet counters
  o Host AP: Disable EAPOL TX/RX debug messages
  o fix hostap crypto bugs
  o Add HostAP wireless driver


--------------060906070504060809050909--
