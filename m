Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTEZANO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTEZANO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:13:14 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:31147
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263808AbTEZANK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:13:10 -0400
Date: Sun, 25 May 2003 20:26:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver merges
Message-ID: <20030526002618.GA10516@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk18-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/apne.c                  |    9 
 drivers/net/arcnet/arcnet.c         |    5 
 drivers/net/e100/e100.h             |   30 -
 drivers/net/e100/e100_main.c        |  342 +++++++++---
 drivers/net/e100/e100_phy.c         |    7 
 drivers/net/e100/e100_test.c        |  155 ++++-
 drivers/net/e1000/Makefile          |    2 
 drivers/net/e1000/e1000.h           |    5 
 drivers/net/e1000/e1000_ethtool.c   |  959 +++++++++++++++++++++++++++++++++++-
 drivers/net/e1000/e1000_hw.c        |   23 
 drivers/net/e1000/e1000_hw.h        |    8 
 drivers/net/e1000/e1000_main.c      |  145 ++---
 drivers/net/fc/iph5526.c            |   18 
 drivers/net/fec.c                   |   18 
 drivers/net/fmv18x.c                |    6 
 drivers/net/hamradio/scc.c          |    7 
 drivers/net/irda/sa1100_ir.c        |    3 
 drivers/net/macmace.c               |    5 
 drivers/net/myri_sbus.c             |    4 
 drivers/net/ppp_synctty.c           |    4 
 drivers/net/seeq8005.c              |    9 
 drivers/net/sun3lance.c             |    8 
 drivers/net/sunqe.c                 |    1 
 drivers/net/tokenring/lanstreamer.c |    5 
 drivers/net/tulip/de4x5.c           |    2 
 drivers/net/wan/lmc/lmc_main.c      |    8 
 drivers/net/wireless/airport.c      |    4 
 include/linux/arcdevice.h           |    2 
 28 files changed, 1475 insertions(+), 319 deletions(-)

through these ChangeSets:

<paulus@samba.org> (03/05/25 1.1338)
   [PATCH] module refcounts for airport driver
   
   This patch takes out the MOD_INC/DEC_USE_COUNT in the airport (Apple
   wireless ethernet) driver.  The driver already does SET_MODULE_OWNER
   on the netdevice, so the MOD_INC/DEC_USE_COUNT are unnecessary and
   just cause warnings.
   
   Please apply.
   
   Thanks,
   Paul.

<paulus@samba.org> (03/05/25 1.1337)
   [PATCH] module owner for ppp_synctty.c
   
   This patch fixes ppp_synctty.c (used for doing PPP over some synchronous
   serial HDLC links) so that it sets the owner field of the tty line
   discipline it exports, rather than using MOD_INC/DEC_USE_COUNT.  This
   is more or less from Stephen Hemminger.
   
   Please apply.
   
   Thanks,
   Paul.

<scott.feldman@intel.com> (03/05/25 1.1336)
   [PATCH] full stop/start on ethtool set speed/duplex/autoneg
   
   * Cleanup ethtool/mii_ioctl sets of speed/duplex/autoneg by
     stop/set/start driver to ensure sets stick.  Must hold
     xmit_lock around stop/start.

<cramerj@intel.com> (03/05/21 1.1209.1.17)
   [PATCH] Whitespace cleanup
   
   * Whitespace cleanup

<cramerj@intel.com> (03/05/21 1.1209.1.16)
   [PATCH] Miscellaneous code cleanup
   
   * Added Change Log entries
   * Miscellaneous code cleanup

<cramerj@intel.com> (03/05/21 1.1209.1.15)
   [PATCH] Fixed LED coloring on 82541/82547 controllers
   
   * LED colors on 82541 and 82547 controllers were incorrect.
     The LED mode register didn't have the proper configuration.

<cramerj@intel.com> (03/05/21 1.1209.1.14)
   [PATCH] Added support for 82546 Quad-port adapter
   
   * Added support for 82546 Quad-port adapter

<cramerj@intel.com> (03/05/21 1.1209.1.13)
   [PATCH] Removed strong branded device ids
   
   * Removed strong branded device ids from the device id table
     along with the associated branding strings.

<cramerj@intel.com> (03/05/21 1.1209.1.12)
   [PATCH] Added ethtool test ioctl
   
   * Added routines for the Ethtool Test ioctl.
   * Added more statistics for the Ethtool statistics dump.
   * Added more registers for the register dump.

<cramerj@intel.com> (03/05/21 1.1209.1.11)
   [PATCH] TSO fix
   
   * Premature write-back of descriptors during TSO causing
     resources to be returned too early on ppc64.  Fix is to
     wait until last descriptor of frame is written back,
     then return resources back to OS.
   * 82544 hang caused by setting RS bit in context descriptor.
     Exposes known hang in 82544.  Fix is same as above - set
     RS bit only in last descriptor.

<scott.feldman@intel.com> (03/05/21 1.1209.1.10)
   [PATCH] misc
   
   * Remove leftovers from removal of /proc support and IDIAG support
   * Cleaned up reporting of h/w init failure messages
   * Add 1/2 second delay after PHY reset to allow link partner to
     see and respond to reset, per IEEE 802.3

<scott.feldman@intel.com> (03/05/21 1.1209.1.9)
   [PATCH] VLAN configuration was lost after ethtool diags run
   
   * Bug fix: ethtool diags would call e100_up/e100_down, which overwrite
     current VLAN settings.  Move initialization of config regs out of
     up/down.

<scott.feldman@intel.com> (03/05/21 1.1209.1.8)
   [PATCH] fixed stalled stats collection
   
   * Bug fix: In the rare event of a failed command to dump stats,
     stat collection would stop, giving the illusion that traffic
     had stopped.  Fixed by issuing stat dump in watchdog
     regardless of status of previous attempt to dump stats.

<scott.feldman@intel.com> (03/05/21 1.1209.1.7)
   [PATCH] cleanup Tx resources before running ethtool diags.
   
   * Bug fix: clean up Tx resources before running ethtool diags.

<scott.feldman@intel.com> (03/05/21 1.1209.1.6)
   [PATCH] Add MDI/MDI-X status to ethtool reg dump
   
   * Add MDI/MDI-X (crossover cable) status to ethtool reg dump.

<scott.feldman@intel.com> (03/05/21 1.1209.1.5)
   [PATCH] Add ethtool cable diag test
   
   * Feature Add: ethtool cable diag test.
   * Some cleanup of the ethtool diags.
   * Fixed bug in return code for ethtool diag results.

<scott.feldman@intel.com> (03/05/21 1.1209.1.4)
   [PATCH] Add ethtool parameter support
   
   * Feature Add: ethtool parameter support: Tx/Rx ring size, Rx xsum
     offloading, flow control.

<scott.feldman@intel.com> (03/05/21 1.1209.1.3)
   [PATCH] move e100_asf_enable under CONFIG_PM to avoid warning
   
   * Bug fix: move e100_asf_enable under CONFIG_PM to avoid warning.
     [Stephen Rothwell (sfr@canb.auug.org.ua)]

<scott.feldman@intel.com> (03/05/21 1.1209.1.2)
   [PATCH] Remove "Freeing alive device" warning
   
   * Bug fix: don't call any netif_carrier_* until netdev is registered.
     [Andrew Morton (akpm@digeo.com)]

<akpm@digeo.com> (03/05/11 1.1063.33.1)
   [netdrvr] remaining irqreturn_t changes

