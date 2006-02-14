Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWBNVsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWBNVsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWBNVsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:48:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54532 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1422813AbWBNVsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:48:15 -0500
Date: Tue, 14 Feb 2006 22:47:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bonding mode 1 works as designed. Or not?
Message-ID: <20060214214746.GK11380@w.ods.org>
References: <43F24DBA.7090602@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F24DBA.7090602@am-anger-1.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, Feb 14, 2006 at 10:38:02PM +0100, Heiko Gerstung wrote:
> Hi, there!
> 
> I just set up bonding for a 2.6.12 box in active-backup mode (mode 1)
> and found out that every packet is duplicated, despite the fact that the
> documentation (Documentation/network/bonding.txt) says:
> 
> "active-backup or 1
>                 Active-backup policy: Only one slave in the bond is
>                 active.  A different slave becomes active if, and only
>                 if, the active slave fails.  The bond's MAC address is
>                 externally visible on only one port (network adapter)
>                 to avoid confusing the switch.  This mode provides
>                 fault tolerance.  The primary option affects the
>                 behavior of this mode."
> 
> 
> My understanding of this mode is:
> eth0 and eth1 are in a bonding group, mode=1, miimon=100 ... eth0 is the
> active slave and used as long as the physical link is available (checked
> by using MII monitoring), at the same time eth1 is totally passive,
> neither passing any received packets to the kernel nor sending packets,
> if the kernel wants it to do so. As soon as the eth0 link status changes
> to "down", eth1 is activated and used, and now eth0 remains silent and
> deaf until it becomes the active slave again.
> 
> Any comments on that? Is the documentation wrong OR is there a bug in
> the implementation of the bonding module?

Neither, it's your understanding described above :-)
In fact, the bonding is used to select an OUTPUT device. If some trafic
manages to enter through the backup interface, it will reach the kernel.
It can be useful to implement some link health-checks for instance. However,
the only packets that you should receive are multicast and broadcast packets,
so this should be very limited anyway by design. After several years using
it, it has not caused me any trouble, including in environments involving
multicast for VRRP.

> Thank you in advance,
> kind regards,
> 
> Heiko

Regards,
willy

