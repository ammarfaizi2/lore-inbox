Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310125AbSB1Vvi>; Thu, 28 Feb 2002 16:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310134AbSB1Vtx>; Thu, 28 Feb 2002 16:49:53 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:46047 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310126AbSB1Vrd> convert rfc822-to-8bit; Thu, 28 Feb 2002 16:47:33 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C144E@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: hardware VLAN acceleration (RE: [BETA-0.92] Third test release of
	 Tigon3 driver)
Date: Thu, 28 Feb 2002 13:47:25 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 27 Feb 2002, David S. Miller wrote:
> 
> > [FEATURE] Yay, real HW acceleration hooks in the 802.1q VLAN layer.
> > 	  Tigon3 takes advantage of it.
>
> > Adding support to the Acenic driver should be pretty easy and I'll
> > try to do that before catching some sleep.  Jeff could also probably
> > cook up something quick for the e1000.
> 
> That would be nice, a common way for hw-vlans is a good thing.
> 
> Intel has also their own (kludgy?) way of doing hw-vlans in 
> the current driver?
> 
> - Pasi Kärkkäinen

The version of e1000 that Jeff merged in has no hardware VLAN capabilities
right now, the version distributed from Intel's web site has hooks for the
binary only iANS teaming/VLAN product.

That being said, I will add support to e1000 for a standard kernel interface
(e100 too, but there are other things to fix first).  David's interface
looks very nice to me, especially in it's clear advertisement of
capabilities and simple transmit and receive design.  Intel's hardware will
have no problem working with it.

I did have some questions about the entry points.

Is vlan_rx_kill_vid only there to ensure locking between vlan_hwaccel_rx and
unregister_802_1Q_vlan_dev?  If so, could this be handled outside of the
driver?

Also, when a vlan dev is unregistered, does the driver need to know that the
vlan_group passed in to vlan_rx_register is no longer valid?

	Chris

--
Chris Leech <christopher.leech@intel.com>
Network Software Engineer
UNIX/Linux/Netware Development Group
LAN Access Division, Intel
