Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRIFRDs>; Thu, 6 Sep 2001 13:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271498AbRIFRDg>; Thu, 6 Sep 2001 13:03:36 -0400
Received: from ns.suse.de ([213.95.15.193]:53769 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271487AbRIFRDa>;
	Thu, 6 Sep 2001 13:03:30 -0400
Date: Thu, 6 Sep 2001 19:03:49 +0200
From: Andi Kleen <ak@suse.de>
To: Wietse Venema <wietse@porcupine.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010906190349.A10470@gruyere.muc.suse.de>
In-Reply-To: <20010906204423.B23109@castle.nmd.msu.ru> <20010906165051.7EA29BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906165051.7EA29BC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 12:50:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 12:50:51PM -0400, Wietse Venema wrote:
> That is not practical. Surely there is an API to find out if an IP
> address connects to the machine itself. If every UNIX system on
> this planet can do it, then surely Linux can do it.

It's not possible in the general case; e.g. it has to ignore NAT rules
and some of the more advanced features of policy routing

The API is rtnetlink. You can send a RTM_GETROUTE message and the kernel
will send you the routing entry for it; which has the RTN_LOCAL type for
local addresses.  

> The same issue is true for local subnets. Surely there exists an
> API to find out what subnetworks a machine is attached to. If every
> UNIX system on this planet can do it, then surely Linux can do it.

You could resolve the backwards address using rtnetlink again and check
the resulting route for LINK scope.  Again it is only an approximation
and will break in some/many cases.


-Andi
