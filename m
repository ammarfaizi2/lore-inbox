Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbRERC0M>; Thu, 17 May 2001 22:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbRERC0C>; Thu, 17 May 2001 22:26:02 -0400
Received: from intranet.resilience.com ([209.245.157.33]:6825 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262237AbRERCZx>; Thu, 17 May 2001 22:25:53 -0400
Mime-Version: 1.0
Message-Id: <p05100301b72a335d4b61@[10.128.7.49]>
In-Reply-To: <811opRpHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de>
Date: Thu, 17 May 2001 19:18:28 -0700
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:23 PM +0200 2001-05-17, Kai Henningsen wrote:
>jlundell@pobox.com (Jonathan Lundell)  wrote on 15.05.01 in 
><p05100316b7272cdfd50c@[207.213.214.37]>:
>
>>  What about:
>>
>>  1 (network domain). I have two network interfaces that I connect to
>>  two different network segments, eth0 & eth1; they're ifconfig'd to
>>  the appropriate IP and MAC addresses. I really do need to know
>>  physically which (physical) hole to plug my eth0 cable into.
>
>Sorry, the software doesn't know that. Never has, for that matter.

Well, no, it doesn't. That's a problem. Jeff Garzik's ethtool 
extension at least tells me the PCI bus/dev/fcn, though, and from 
that I can write a userland mapping function to the physical 
location. My point, though, is that finding the socket is a real-life 
problem on systems with multiple interfaces. I don't expect the 
kernel to know the physical locations, but the user has to be able to 
get from kernel/ifconfig names (eth#) to sockets, one way or another. 
Support for a uniform means of doing the mapping, even if it needs 
userland help, would be good.

>  > (Extension: same situation, but it's a firewall and I've got 12 ports
>>  to connect.) (Extension #2: if I add a NIC to the system and reboot,
>>  I'd really prefer that the NICs already in use didn't get renumbered.)
>
>Make your config script look at the hardware MAC addresses. Those don't
>change.

They're not necessarily unique, though.

>  > 2 (disk domain). I have multiple spindles on multiple SCSI adapters.
>>  I want to allocate them to more than one RAID0/1/5 set, with the
>>  usual considerations of putting mirrors on different adapters,
>>  spreading my RAID5 drives optimally, ditto stripes. I need (eg) SCSI
>>  paths to config all this, and I further need real physical locations
>>  to identify failed drives that need to be hot-replaced. The mirror
>>  members will move around as drives are replaced and hot spares come
>>  into play.
>
>Use partition UUIDs, or SCSI serial numbers, or whatever. This works
>today.

This pushes the problem back in time: I need to write the UUID, for 
example, at some point. And, with hot-swappable drives, I'm still 
interested in the physical location. I really know know that there's 
a good answer to this problem, especially with FC, but I need to tell 
an operator, "replace this particular physical drive". It doesn't do 
any good to tell the operator the UUID.

>  > Seems like more that merely informational.
>
>The *location*? Nope. Some unique id for the device, if available at all:
>sure.

What good does it do to tell an operator to connect a cable to a MAC 
address? Or to remove a drive having a particular UUID? If it's "mere 
information", it's *necessary* mere information.

>  > (A side observation: PCI or SCSI bus/device/lun/etc paths are not
>>  physical locations; you also need external hardware-specific
>>  knowledge to be able to talk about real physical locations in a way
>>  that does the system operator any good.)
>
>And those you typically do not have.

But (ideally) should.

-- 
/Jonathan Lundell.
