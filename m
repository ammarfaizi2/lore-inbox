Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbREVRw1>; Tue, 22 May 2001 13:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbREVRwR>; Tue, 22 May 2001 13:52:17 -0400
Received: from geos.coastside.net ([207.213.212.4]:46001 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262690AbREVRwE>; Tue, 22 May 2001 13:52:04 -0400
Mime-Version: 1.0
Message-Id: <p05100306b73052aff22d@[207.213.214.37]>
In-Reply-To: <20010522231218.C10207@metastasis.f00f.org>
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au>
 <20010520163323.G18119@athlon.random>
 <15112.26868.5999.368209@pizda.ninka.net>
 <20010521034726.G30738@athlon.random>
 <15112.48708.639090.348990@pizda.ninka.net>
 <20010521105944.H30738@athlon.random>
 <15112.55709.565823.676709@pizda.ninka.net>
 <20010521115631.I30738@athlon.random>
 <15112.59880.127047.315855@pizda.ninka.net>
 <15112.60362.447922.780857@pizda.ninka.net>
 <20010522231218.C10207@metastasis.f00f.org>
Date: Tue, 22 May 2001 10:51:43 -0700
To: Chris Wedgwood <cw@f00f.org>, "David S. Miller" <davem@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 PM +1200 2001-05-22, Chris Wedgwood wrote:
>On Mon, May 21, 2001 at 03:19:54AM -0700, David S. Miller wrote:
>
>     Electrically (someone correct me, I'm probably wrong) PCI is
>     limited to 6 physical plug-in slots I believe, let's say it's 8
>     to choose an arbitrary larger number to be safe.
>
>Minor nit... it can in fact be higher than this, but typically it is
>not. CompactPCI implementations may go higher (different electrical
>characteristics allow for this).

Compact PCI specifies a max of 8 slots (one of which is typically the 
system board). Regular PCI doesn't have a hard and fast slot limit 
(except for the logical limit of 32 devices per bus); the limits are 
driven by electrical loading concerns. As I recall, a bus of typical 
length can accommodate 10 "loads", where a load is either a device 
pin or a slot connector (that is, an expansion card counts as two 
loads, one for the device and one for the connector). (I take this to 
be a rule of thumb, not a hard spec, based on the detailed electrical 
requirements in the PCI spec.)

Still, the presence of bridges opens up the number of devices on a 
root PCI bus to a very high number, logically. Certainly having three 
or four quad Ethernet cards, so 12 or 16 devices, is a plausible 
configuration. As for bandwidth, a 64x66 PCI bus has a nominal burst 
bandwidth of 533 MB/second, which would be saturated by 20 full 
duplex 100baseT ports that were themselves saturated in both 
directions (all ignoring overhead). Full saturation is not reasonable 
for either PCI or Ethernet; I'm just looking at order-of-magnitude 
numbers here.

The bottom line is: don't make any hard and fast assumption about the 
number of devices connected to a root PCI bus.
-- 
/Jonathan Lundell.
