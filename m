Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbRETQAn>; Sun, 20 May 2001 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbRETQAd>; Sun, 20 May 2001 12:00:33 -0400
Received: from geos.coastside.net ([207.213.212.4]:3536 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262061AbRETQAR>; Sun, 20 May 2001 12:00:17 -0400
Mime-Version: 1.0
Message-Id: <p05100303b72d95fa36d1@[207.213.214.37]>
In-Reply-To: <m1wv7cgy45.fsf@frodo.biederman.org>
In-Reply-To: <811opRpHw-B@khms.westfalen.de>
 <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de>
 <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de>
 <p0510031eb72c5f11b8c7@[207.213.214.37]>
 <m1wv7cgy45.fsf@frodo.biederman.org>
Date: Sun, 20 May 2001 08:54:50 -0700
To: ebiederm@xmission.com (Eric W. Biederman)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:37 AM -0600 2001-05-20, Eric W. Biederman wrote:
>Jonathan Lundell <jlundell@pobox.com> writes:
>
>>  At 10:42 AM +0200 2001-05-19, Kai Henningsen wrote:
>>  >  > Jeff Garzik's ethtool
>>  >  > extension at least tells me the PCI bus/dev/fcn, though, and from
>>  >>  that I can write a userland mapping function to the physical
>>  >>  location.
>>  >
>>  >I don't see how PCI bus/dev/fcn lets you do that.
>>
>>  I know from system documentation, or can figure out once and for all
>>  by experimentation, the correspondence between PCI bus/dev/fcn and
>>  physical locations. Jeff's extension gives me the mapping between
>>  eth# and PCI bus/dev/fcn, which is not otherwise available (outside
>>  the kernel).
>
>Just a second let me reenumerate your pci busses, and change all of the bus
>numbers.  Not that this is a bad thought.  It is just you need to know
>the tree of PCI busses/bridges up to the root on the machine in question.

Yes, you do. And it's true that renumbering is problematical; I 
hadn't thought of all the implications. Say, you have a system with 
hot-plug slots on two buses, and someone hot-plugs a card with a 
bridge (fairly common; most dual/quad Ethernet boards have a bridge). 
If the buses were numbered densely to begin with, they're going to 
have to be renumbered above the point that the new bridge was added.

Phooey. Well, it can still be done, but it's a bit more complicated 
than the bus/dev/fcn-to-location map I was imagining. You'd have to 
describe the topology of the built-in buses, and dynamically make the 
correspondences. As you say, "know the tree", by topology, not bus 
numbers.


-- 
/Jonathan Lundell.
