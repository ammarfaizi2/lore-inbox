Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSDWNWP>; Tue, 23 Apr 2002 09:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSDWNWO>; Tue, 23 Apr 2002 09:22:14 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:43020 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S313924AbSDWNWO>; Tue, 23 Apr 2002 09:22:14 -0400
Date: Tue, 23 Apr 2002 08:20:03 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200204231320.IAA21634@tomcat.admin.navo.hpc.mil>
To: vda@port.imtp.ilyichevsk.odessa.ua, Frank Louwers <frank@openminds.be>
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <200204231118.g3NBIvX15310@Port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On 23 April 2002 09:11, Frank Louwers wrote:
> > > > Is this a bug or a known issue? If it is not a bug, how can it be
> > > > solved?
> > >
> > > Do you have ip forwarding enabled? If yes, kernel just forwards packets:
> > > network -> eth0 -> kernel
> > >
> > > Try traceroute to eth1' ip. Examine arp tables. What MAC is listed there
> > > for eth1 IP?
> >
> > ipforwarding is disabled, arp proxy is disabled.
> >
> > The mac address is that of eth0 ...
> 
> Kernel bug I think. Sorry can't help you here.
> I'm afraid you have to dig deeper...

I would suspect the default route is directing the reply (netstat -r should
show if this is the case).
This happens whenever there are two NICs to the same network. An incoming
connection will go out the default route IF the default route is the same
as the network address. This gives preferential activity to the designated
route. We've done this when phasing out one interface in favor of another
(fddi->GEthernet)..

The usual reccomendation is not to have both interfaces active simultaneiously
as this causes (relatively minor) confusion. The connections should
work, but one will be relayed to the other interface since there is no
distinguishing characteristic about which interface to use - they are
equivalent. Once the default route is switched, the inverse situation
occurs.

If you want only one port, just down the undesired interface. Use it only
when the primary fails. If you need both IPs active, then use ifconfig eth0:1
and have both on the same interface (I think that still works).

Load balancing really calls for two different subnets. Otherwise you get
collisions between the two interfaces...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
