Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbTHHAFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHHAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:05:31 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:59281
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271146AbTHHAFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:05:09 -0400
Date: Thu, 7 Aug 2003 20:05:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] 2.6.x net driver updates
Message-ID: <20030808000508.GA4464@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6

Others may download the patch from

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test2-bk7-netdrvr1.patch.bz2

This will update the following files:

 CREDITS                             |   15 +
 MAINTAINERS                         |    8 
 drivers/net/arm/am79c961a.c         |    7 
 drivers/net/arm/ether00.c           |   81 ++++------
 drivers/net/arm/ether1.c            |    9 -
 drivers/net/arm/ether3.c            |    7 
 drivers/net/arm/etherh.c            |   16 +
 drivers/net/pcmcia/3c574_cs.c       |   18 --
 drivers/net/pcmcia/3c589_cs.c       |   18 --
 drivers/net/pcmcia/axnet_cs.c       |   19 --
 drivers/net/pcmcia/com20020_cs.c    |   14 -
 drivers/net/pcmcia/fmvj18x_cs.c     |   18 --
 drivers/net/pcmcia/ibmtr_cs.c       |   15 -
 drivers/net/pcmcia/nmclan_cs.c      |   17 --
 drivers/net/pcmcia/pcnet_cs.c       |   17 --
 drivers/net/pcmcia/smc91c92_cs.c    |   17 --
 drivers/net/pcmcia/xirc2ps_cs.c     |   18 --
 drivers/net/wireless/airo.c         |   33 ++--
 drivers/net/wireless/airo_cs.c      |   22 --
 drivers/net/wireless/netwave_cs.c   |   20 --
 drivers/net/wireless/orinoco_cs.c   |   16 -
 drivers/net/wireless/ray_cs.c       |   22 --
 drivers/net/wireless/wavelan_cs.c   |   15 -
 drivers/net/wireless/wavelan_cs.p.h |    2 
 drivers/net/wireless/wl3501.h       |  244 ++++++++++++++++++------------
 drivers/net/wireless/wl3501_cs.c    |  290 +++++++++++++++++++++++-------------
 26 files changed, 534 insertions(+), 444 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/07 1.1130)
   [netdrvr airo] now that it builds, re-enable wireless_ext

<achirica@telefonica.net> (03/08/07 1.1129)
   [netdrvr airo] Fix adhoc config

<achirica@telefonica.net> (03/08/07 1.1128)
   [netdrvr airo] safer unload code

<achirica@telefonica.net> (03/08/07 1.1127)
   [netdrvr airo] MIC support with newer firmware

<achirica@telefonica.net> (03/08/07 1.1126)
   [netdrvr airo] add missing lines for Wireless Extensions 16

<achirica@telefonica.net> (03/08/07 1.1125)
   [netdrvr airo] MAC type changed to unsigned

<achirica@telefonica.net> (03/08/07 1.1124)
   [netdrvr airo] Missing defines (only for documentation)

<hch@lst.de> (03/08/07 1.1123)
   [netdrvr pcmcia] remove the release timer from all pcmcia net drivers
   
   Ack'd by Russell King as well.

<rmk@arm.linux.org.uk> (03/08/05 1.1106.1.11)
   [netdrvr ARM] alloc_etherdev updates

<acme@conectiva.com.br> (03/07/20 1.1046.409.66)
   o MAINTAINERS: add acme as wl3501 maintainer
   
   Also add Niemeyer to CREDITS for his work on early stages of
   wireless extensions support for the wl3501 card.

<acme@conectiva.com.br> (03/07/20 1.1046.409.65)
   o wl3501: add a first cut, lazy scan triggering for set_scan

<acme@conectiva.com.br> (03/07/20 1.1046.409.64)
   o wl3501: implement {get,set}_scan wireless extensions
   
   set_scan still needs to trigger a scan, but for now doing something
   that resets the card, like iwconfig eth0 mode ad-hoc triggers a
   scanning, and even without that we report the last scan results,
   good enough for now 8) But it will be implemented, don't worry! :-)

<acme@conectiva.com.br> (03/07/20 1.1046.409.63)
   o wl3501: introduce iw_mgmt_data_rset and rate labels enum

<acme@conectiva.com.br> (03/07/20 1.1046.409.62)
   o wl3501: introduce struct iw_mgmt_cf_pset
   
   Just for completeness, it is included in the mgmt frames, but
   not used in this driver, i.e. it may well be that this driver
   supports contention free service, but the original driver had
   no use for it at all.

<acme@conectiva.com.br> (03/07/20 1.1046.409.61)
   o wl3501: introduce iw_mgmt_ibss_pset

<acme@conectiva.com.br> (03/07/20 1.1046.409.60)
   o wl3501: fix bug in iw_mgmt_info_element id field and more
   
   . unfortunately we can't use enum iw_mgmt_info_element_ids for the
     id field in iw_mgmt_info_element, as it has to be u8 and sizeof(enum)
     is bigger than that, but we use the enum in the relevant functions to
     help catch invalid elements being used.
   . also we can't have iw_mgmt_info_element with a fixed size data field,
     as it is variable as per the 802.11 specs, so I do a poor man's OOP
     by subclassing iw_mgmt_info_element into the standard element types. Done
     up to now with iw_mgmt_essid_pset and iw_mgmt_ds_pset, others will follow.

<acme@conectiva.com.br> (03/07/19 1.1046.409.59)
   o wl3501: fix set_essid wireless extension, using the flags for any

<acme@conectiva.com.br> (03/07/19 1.1046.409.58)
   o wl3501: use iw_mgmt_info_element for phy_pset (now ds_parameter_set)
   
   Clarifying stuff is good: with this I have fixed a bug in join, where
   the element id and size were not being set... longstanding one, since
   original driver times...

<acme@conectiva.com.br> (03/07/19 1.1046.409.57)
   o wl3501: introduce iw_mgmt_info_element & associate functions and enums
   
   Also aimed at inclusion on the core wireless extensions, with this we are
   closer to 802.11 specs with regards to frame management elements stuff.
   Next patches will deal with other elements that are done in a raw way such
   as the phys parameter set (DS in this driver).

