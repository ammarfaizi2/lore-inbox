Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRAXAQg>; Tue, 23 Jan 2001 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRAXAKk>; Tue, 23 Jan 2001 19:10:40 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2055 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132068AbRAXAKO>;
	Tue, 23 Jan 2001 19:10:14 -0500
Date: Wed, 24 Jan 2001 01:10:11 +0100
From: Andi Kleen <ak@suse.de>
To: Pete Elton <elton@iqs.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
        "A.N.Kuznetsov" <kuznet@ms2.inr.ac.ru>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <20010124011011.A12252@gruyere.muc.suse.de>
In-Reply-To: <20010123100803.A24145@gruyere.muc.suse.de> <200101232350.PAA14448@tech1.nameservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101232350.PAA14448@tech1.nameservers.com>; from elton@iqs.net on Tue, Jan 23, 2001 at 03:50:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 03:50:36PM -0800, Pete Elton wrote:
> Is there something that the arp_filter can do that will mirror this
> functionality?  The modification that you made to the documentation 
> was pretty straight forward in that the arp_filter was BOOLEAN, so 
> I think I implemented it right.

The snippet you posted doesn't describe what ClusterThingy exactly wants
to do with ARPs. 

Arpfilter was designed for multiple interfaces, to direct ARP replies
to specific interfaces based on the routing table. If you have only a 
single interface and no other way to policy route the packet I think you can 
only try to use policy routing hacks (not tested). e.g. tag all outgoing 
packets with a specific fwmark that redirects them to a specific routing
table which does the real routing, and put no routes into the normal 
one used by arpfilter so that it doesnt' reply.

Admittedly it's quite a hack. Perhaps Alexey can suggest a better solution,
he's the routing/arp guru. I guess it would be easier if arpfilter was
able to select a special own routing table, but I was too chicken to implement
that.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
