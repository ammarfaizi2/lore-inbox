Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUDEXId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUDEXI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:08:28 -0400
Received: from frontend-1.hamburg.de ([212.1.41.126]:15782 "EHLO
	flut.int-rz.hamburg.de") by vger.kernel.org with ESMTP
	id S263225AbUDEXIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:08:18 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linux-Kernel List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Date: Tue, 6 Apr 2004 01:08:19 +0200
User-Agent: KMail/1.6.1
Cc: Francois Romieu <romieu@fr.zoreil.com>, Andrew Morton <akpm@osd.org>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@oss.sgi.com,
       jgarzik@pobox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404060108.19488.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
> Manfred Spraul <manfred@colorfullife.com> :
> [...]
> > tx_left counts packets submitted by hard_xmit_start to the hardware. 
> > Initially OWNbit is set, the packet is owned by the nic. The OWNbit is 
> > cleared by the hardware after the packet was sent. A packet with OWNbit 
> > set means that the nic didn't send it yet to the wire. I think the "else 
> > break;" patch is correct, but someone with docs should confirm that.
> 
> Realtek Gigabit Ethernet Media Access Controller with power management R8169
> Rev.1.21, p.54
> [...]
> Ownership: This bit, when set, indicates that the descriptor is owned by
> the NIC. When cleared, it indicates that the descriptor is owned by the host
> system. NIC clears this bit when the relative buffer data is already
> transmitted. In this case, OWN=0.
> 
> [...]
> > Perhaps gcc optimized away the reload from memory and loops on a 
> 
> Point taken.

Isn't the "current" RTL8169s (32/64) driver much outdated?

I got a version # 1.6 with all my cards.
Anyone what a copy?

/*
=========================================================================
 r8169.c: A RealTek RTL8169s/8110s Gigabit Ethernet driver for Linux kernel 
2.4.x.
 --------------------------------------------------------------------

 History:
 Feb  4 2002	- created initially by ShuChen <shuchen@realtek.com.tw>.
 May 20 2002	- Add link status force-mode and TBI mode support.
=========================================================================
  1. The media can be forced in 5 modes.
	 Command: 'insmod r8169 media = SET_MEDIA'
	 Ex:	  'insmod r8169 media = 0x04' will force PHY to operate in 100Mpbs 
Half-duplex.

	 SET_MEDIA can be:
 		_10_Half	= 0x01
 		_10_Full	= 0x02
 		_100_Half	= 0x04
 		_100_Full	= 0x08
 		_1000_Full	= 0x10

  2. Support TBI mode.
//=========================================================================
RTL8169_VERSION "1.1"	<2002/10/4>

	The bit4:0 of MII register 4 is called "selector field", and have to be
	00001b to indicate support of IEEE std 802.3 during NWay process of
	exchanging Link Code Word (FLP).

RTL8169_VERSION "1.2"	<2003/6/17>
	Update driver module name.
	Modify ISR.
        Add chip mac_version.

RTL8169_VERSION "1.3"	<2003/6/20>
        Add chip phy_version.
	Add priv->phy_timer_t, rtl8169_phy_timer_t_handler()
	Add rtl8169_hw_PHY_config()
	Add rtl8169_hw_PHY_reset()

RTL8169_VERSION "1.4"	<2003/7/14>
	Add tx_bytes, rx_bytes.

RTL8169_VERSION "1.5"	<2003/7/18>
	Set 0x0000 to PHY at offset 0x0b.
	Modify chip mac_version, phy_version
	Force media for multiple card.
RTL8169_VERSION "1.6"	<2003/8/25>
	Modify receive data buffer.
*/

Greetings,
	Dieter


-- 
Dieter Nützel
@home: <Dieter.Nuetzel () hamburg ! de>
