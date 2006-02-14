Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWBNXu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWBNXu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422870AbWBNXu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:50:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:59140 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1422880AbWBNXuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:50:25 -0500
Date: Wed, 15 Feb 2006 00:49:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bonding mode 1 works as designed. Or not?
Message-ID: <20060214234954.GA13843@w.ods.org>
References: <43F24DBA.7090602@am-anger-1.de> <20060214214746.GK11380@w.ods.org> <43F25138.9090503@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F25138.9090503@am-anger-1.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:52:56PM +0100, Heiko Gerstung wrote:
> Hi Willy,
> 
> Willy Tarreau wrote:
> >>[...]eth0 and eth1 are in a bonding group, mode=1, miimon=100 ... eth0 
> >>is the
> >>active slave and used as long as the physical link is available (checked
> >>by using MII monitoring), at the same time eth1 is totally passive,
> >>neither passing any received packets to the kernel nor sending packets,
> >>if the kernel wants it to do so. As soon as the eth0 link status changes
> >>to "down", eth1 is activated and used, and now eth0 remains silent and
> >>deaf until it becomes the active slave again.
> >>
> >>Any comments on that? Is the documentation wrong OR is there a bug in
> >>the implementation of the bonding module?
> >>    
> >
> >Neither, it's your understanding described above :-)
> >In fact, the bonding is used to select an OUTPUT device. If some trafic
> >manages to enter through the backup interface, it will reach the kernel.
> >It can be useful to implement some link health-checks for instance. 
> >However,
> >the only packets that you should receive are multicast and broadcast 
> >packets,
> >so this should be very limited anyway by design. After several years 
> >using
> >it, it has not caused me any trouble, including in environments involving
> >multicast for VRRP.
> >
> >  
> Unfortunately the ping replies come in on both interfaces, as well as 
> any other traffic (like ssh or web traffic). Everything works but the 
> load of the system caused by network traffic is nearly doubled this way 
> and may cause confusion in a number of applications. 

So you are using a hub instead of a switch, otherwise, your switch is
duplicating the traffic. You agree that it's not expected to find an
unicast packet on two different ports of the same switch when mirroring
is disabled and mac-learning has not been disabled ?

> Would there be a way to stop the non-active slave(s) from "listening", 
> i.e. drop all traffic received by them? If yes, where could I do that?

I don't see how. It would be fairly simpler IMHO to fix the switch's
configuration.

> >Regards,
> >willy
> >
> >  
> Thank you for your reply,
> kind regards,
> Heiko

Regards,
Willy

