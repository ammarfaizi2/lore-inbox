Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292565AbSCAVwU>; Fri, 1 Mar 2002 16:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293005AbSCAVwL>; Fri, 1 Mar 2002 16:52:11 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:58642 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S292776AbSCAVvn>; Fri, 1 Mar 2002 16:51:43 -0500
Date: Fri, 1 Mar 2002 22:51:33 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
Message-ID: <20020301225133.A30468@devcon.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Ben Greear <greearb@candelatech.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, zab@zabbo.net
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com> <20020301174619.A6125@devcon.net> <3C7FD1E3.800A61FD@mandrakesoft.com> <20020301213458.A30120@devcon.net> <3C7FE9B4.441B553@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7FE9B4.441B553@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 03:51:00PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 03:51:00PM -0500, Jeff Garzik wrote:
> > 
> > > 3) 3c59x needs real dev->change_mtu support.  This patch provides the
> > > info needed to do that... but doesn't do that.
> > Intentionally, as this has nothing to do with VLAN support.
> It does, but not directly.  The infrastructure for VLAN and changing MTU
> share common elements, so both should be merged at the same time.

OK, from the chip driving side, yes, but not from the network stack
side, as noted by Ben.

> This is ESPECIALLY key with 3c59x, because we are turning on support for
> large frames, not specifically VLAN.  That is obviously the same
> operation as changing MTU to a larger, non-standard one, and so should
> not be treated as something vlan-specific.
> 
> Thanks much for the patch, whoever the author(s) were though...

It was me actually ;-)

> it
> provides the necessary reference information to modify 3c59x for these
> things I describe, and also provide the framework for 

When doing the 3c59x modifications, please note the comment above
set_8201q_mode

| Note that this must be done after each RxReset due to some backwards
| compatibility logic in the Cyclone and Tornado ASICs */

The "backwards compatibility logic" mentioned there refers to that
Cyclone and Tornado cards will reset MaxPktSize to standard ethernet
or FDDI MTU (as determined by the allowLargePackets flag) on every
RxReset.

> Early next week, I will likely make a bombing run through several
> drivers, fixing up the large frame and MTU issues.  That should be
> enough for software VLAN.

Ack.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
