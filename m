Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293159AbSB1XSg>; Thu, 28 Feb 2002 18:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293630AbSB1XQ4>; Thu, 28 Feb 2002 18:16:56 -0500
Received: from jffdns01.or.intel.com ([134.134.248.3]:8442 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S310196AbSB1XLx>; Thu, 28 Feb 2002 18:11:53 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C1451@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "Leech, Christopher" <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: RE: [BETA-0.92] Third test release of Tigon3 driver
Date: Thu, 28 Feb 2002 15:11:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sounds good to me, this should work nicely.

	Chris

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Thursday, February 28, 2002 2:57 PM
>
> This is exactly the kind of thing I wanted people to discover
> and discuss.  Thanks for bringing this up.
> 
> It would be quite simple to hook back into your driver for this
> purpose, proposed API:
> 
> /* For netdev->features */
> #define NETIF_F_HW_VLAN_FILTER		1024
> 
> /* For NETIF_F_VLAN_RX_FILTER devices */
> 	void (*vlan_rx_new_vid)(struct net_device *dev,
> 				unsigned short vid);
> 
> We call dev->vlan_rx_kill_vid() in all cases because it has to
> deal with interlocking, as described in an earlier email.
> 
> But if NETIF_F_HW_VLAN_FILTER is set, when new VLAN devices are
> registered that go through your card, you will get a
> dev->vlan_rx_new_vid() call.
> 
> I do not think you would need any more informatin than the
> VID itself.  If this is wrong, tell me now :-)
> 
