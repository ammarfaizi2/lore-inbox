Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWDGRZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWDGRZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWDGRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:25:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:21919 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964822AbWDGRZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:25:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc1: bcm43xx problems with BCM4306 on x86_64
Date: Fri, 7 Apr 2006 18:59:23 +0200
User-Agent: KMail/1.9.1
Cc: bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071859.23452.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried the version of the driver included in 2.6.17-rc1 on an x86_64
box (Asus L5D) with a built-in PCI BCM4306 adapter (Broadcom Corporation
BCM4306 802.11b/g Wireless LAN Controller (rev 03)), and unfortunately
it doesn't seem to work.

The driver loads and seems to initialize the adapter, but that's all,
apparently.

First, I compiled the driver with DMA and PIO support, but it hanged my box
solid when I tried "iwconfig eth1 essid on" on it.  On the next boot I noticed
it caused the following messages to appear in dmesg:

nommu_map_single: overflow 58ee7010+2404 of device mask 3fffffff
nommu_map_single: overflow 53669010+2404 of device mask 3fffffff
nommu_map_single: overflow 50180010+2404 of device mask 3fffffff

and so on, down to 455aa010.  Then I thought the adapter might be unable
to DMA for some reason and compiled it with PIO support only.  It did not
hang the box any more, but I couldn't make it work.

It causes the following messages to appear in dmesg:

bcm43xx: set security called
bcm43xx:    .level = 0
bcm43xx:    .enabled = 0
bcm43xx:    .encrypt = 0
bcm43xx: PHY connected
bcm43xx: Radio turned on
bcm43xx: Chip initialized
bcm43xx: PIO initialized
bcm43xx: 80211 cores initialized
bcm43xx: Keys cleared
ADDRCONF(NETDEV_UP): eth1: link is not ready
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: ASSERTION FAILED (0) at: drivers/net/wireless/bcm43xx/bcm43xx_pio.c:167:parse_cookie()
bcm43xx: ASSERTION FAILED (packetindex >= 0 && packetindex < BCM43xx_PIO_MAXTXPACKETS) at: drivers/net/wireless/bcm43xx/bcm43xx_
pio.c:170:parse_cookie()
bcm43xx: ASSERTION FAILED (queue) at: drivers/net/wireless/bcm43xx/bcm43xx_pio.c:482:bcm43xx_pio_handle_xmitstatus()
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: FATAL ERROR: BCM43xx_IRQ_XMIT_ERROR
bcm43xx: ASSERTION FAILED (0) at: drivers/net/wireless/bcm43xx/bcm43xx_pio.c:167:parse_cookie()
bcm43xx: ASSERTION FAILED (packetindex >= 0 && packetindex < BCM43xx_PIO_MAXTXPACKETS) at: drivers/net/wireless/bcm43xx/bcm43xx_
pio.c:170:parse_cookie()
bcm43xx: ASSERTION FAILED (queue) at: drivers/net/wireless/bcm43xx/bcm43xx_pio.c:482:bcm43xx_pio_handle_xmitstatus()

and so on.

I used fwcutter 004 to extract the firmvare from the Windows file delivered
with the machine (BCMWL5.SYS).

If you need/want any more information from me, please let me know.

Greetings,
Rafael
