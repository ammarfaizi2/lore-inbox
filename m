Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293747AbSCAUvU>; Fri, 1 Mar 2002 15:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293753AbSCAUvL>; Fri, 1 Mar 2002 15:51:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37646 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293747AbSCAUu7>;
	Fri, 1 Mar 2002 15:50:59 -0500
Message-ID: <3C7FE9B4.441B553@mandrakesoft.com>
Date: Fri, 01 Mar 2002 15:51:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com> <20020301174619.A6125@devcon.net> <3C7FD1E3.800A61FD@mandrakesoft.com> <20020301213458.A30120@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> On Fri, Mar 01, 2002 at 02:09:23PM -0500, Jeff Garzik wrote:
> > It is really halfway in between software and hardware VLAN
> > support.
> 
> Not really. The MTU setting is something which must be done for any
> "dumb" card that has no real hardware VLAN support, and the only thing
> Cyclone and Tornado cards care about the VlanEtherType is that they
> start IP checksumming 4 octets later. They don't care a bit about the
> contents of the VLAN tag.

Good to know, thanks.  My point still stands, though :)  See below...


> > 2) You don't want to set_8021q_mode if VLAN is not active.  It's silly
> > to activate it when VLAN is compiled as a module but no one is using
> > vlans.  That's going to be THE common case, because distros will
> > inevitably build the VLAN module with their stock kernel.
> 
> Well, this was discussed on the VLAN mailing list. The conclusion
> there was that it will not hurt on most cards if it is enabled
> unconditionally.

Well, conclusions like that slow down packet processing on the chip,
quite often...


> Anyway, if you want to enable it only if VLANs are really used on the
> card, what about adding a new hook to struct net_device, which can be
> used by the 802.1q core code to enable VLAN support on the card as
> needed (if supported by the driver)? Or, as this is only a boolean
> flag, maybe a generic feature_supported/set_feature hook pair that can
> be used for other similar situations in the future?
> 
> > 3) 3c59x needs real dev->change_mtu support.  This patch provides the
> > info needed to do that... but doesn't do that.
> 
> Intentionally, as this has nothing to do with VLAN support.

It does, but not directly.  The infrastructure for VLAN and changing MTU
share common elements, so both should be merged at the same time.

This is ESPECIALLY key with 3c59x, because we are turning on support for
large frames, not specifically VLAN.  That is obviously the same
operation as changing MTU to a larger, non-standard one, and so should
not be treated as something vlan-specific.

Thanks much for the patch, whoever the author(s) were though... it
provides the necessary reference information to modify 3c59x for these
things I describe, and also provide the framework for 

Early next week, I will likely make a bombing run through several
drivers, fixing up the large frame and MTU issues.  That should be
enough for software VLAN.

	Jeff

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
