Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTEIOVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTEIOVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:21:15 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:4224 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S263253AbTEIOVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:21:13 -0400
Date: Fri, 9 May 2003 10:33:52 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The magical mystical changing ethernet interface order
In-Reply-To: <1052437088.13561.36.camel@orca.madrabbit.org>
Message-ID: <Pine.LNX.4.55.0305091020060.325@filesrv1.baby-dragons.com>
References: <1052437088.13561.36.camel@orca.madrabbit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Ray & All ,  While that RedHat/Debian/... have figured
	these out is really nice .  NOT one of those methods appears to be
	available for hand built distros .  Ie: there does not appear to
	be a standardised(tm) method to approach this difficulty through
	out all drivers (not just ethernet) .

	Could someone please point me to NON RedHat/Debian/... centric
	tool to determine the proper ethernet for now ?

	Modules are not an option for me here .  Imo: If this can be done
	with modules it should well be possible for staticly built
	drivers as well .  Tia , JimL

On Thu, 8 May 2003, Ray Lee wrote:
> Jean Tourrilhes wrote:
> >         My belief is that configuration scripts should be specified in
> > term of MAC address (or subset) and not in term of device name. Just
> > like the Pcmcia scripts are doing it.
> Debian already supports this, integrated into the normal scheme for
> dealing with interfaces. Anyone running Debian can take a look at
> /usr/share/doc/ifupdown/examples directory, the network-interfaces.gz
> file contains sample /etc/network/interfaces stanzas for configuring
> your interfaces via MAC address:
> 	auto eth0 eth1
> 	mapping eth0 eth1
> 		script /path/to/get-mac-addr.sh
> 		map 11:22:33:44:55:66 lan
> 		map AA:BB:CC:DD:EE:FF internet
> 	iface lan inet static
> 		address 192.168.42.1
> 		netmask 255.255.255.0
> 		pre-up /usr/local/sbin/enable-masq $IFACE
> 	iface internet inet dhcp
> 		pre-up /usr/local/sbin/firewall $IFACE
> You can even do something like:
> 	iface wireless inet dhcp
> 		wireless_key 12345678901234567890123456
> A sample get-mac-address.sh is in the same directory, though it has a
> typo (missing a close paren -- I need to report that...). This same
> scheme works for pinging some well-known host to determine where you
> are, or using ARPs, or whatever. I use it on my laptop with PCMCIA
> cards, works great.
> Ray
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
