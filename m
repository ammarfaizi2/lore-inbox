Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRAGTjV>; Sun, 7 Jan 2001 14:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132842AbRAGTjB>; Sun, 7 Jan 2001 14:39:01 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:20750 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S131953AbRAGTiu>;
	Sun, 7 Jan 2001 14:38:50 -0500
Message-ID: <3A58D49D.C4152BD5@candelatech.com>
Date: Sun, 07 Jan 2001 13:42:05 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Sandy Harris <sandy@storm.ca>
CC: jamal <hadi@cyberus.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup(DoesNOT  
 meet Linus' sumission policy!)
In-Reply-To: <Pine.GSO.4.30.0101071321330.18916-100000@shell.cyberus.ca> <3A58C137.63907CDC@storm.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris wrote:
> 
> jamal wrote:
> 
> > > What problem does this fix?
> > >
> > > If you are mucking with the ifindex, you may be affecting many places
> > > in the rest of the kernel, as well as user-space programs which use
> > > ifindex to bind to raw devices.
> >
> > I am talking about 2.5 possibilities now that 2.4 is out. I think
> > "parasitic/virtual" interfaces is not a issue specific to VLANs.
> > VLANs happen to use devices today to solve the problem.
> > As pointed by that example no routing daemons are doing aliased
> > interfaces (which are also virtual interfaces).
> > We need some more general solution.
> >
> Something like this also becomes an issue when you want routing
> daemons to interact sensibly with IPSEC tunnels. A paper on these
> issues is at:
> 
> http://www.quintillion.com/fdis/moat/ipsec+routing/
> 
> It is not (AFAIK) clear that the FreeS/WAN team will adopt the solutions
> suggested there, but it is very clear we need to deal with those issues.

Hrm, what if they just made each IP-SEC interface a net_device?  If they
are a routable entity, with it's own IP address, it starts to look a lot
like an interface/net_device.

This has seeming worked well for VLANs:  Maybe net_device is already
general enough??

So, what would be the down-side of having VLANs and other virtual interfaces
be net_devices?  The only thing I ever thought of was the linear lookups,
which is why I wrote the hash code.  The beauty of working with existing
user-space tools should not be over-looked!

It may be easier to fix other problems with many interface/net_devices
than cram a whole other virtual net_device structure (with many duplicate
functionalities found in the current net_device).

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
