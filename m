Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbTGKLWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269905AbTGKLWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:22:22 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:20352 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269886AbTGKLWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:22:07 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Pekka Savola <pekkas@netcore.fi>
Cc: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0307110821110.24981-100000@netcore.fi>
References: <Pine.LNX.4.44.0307110821110.24981-100000@netcore.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057923396.893.16.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 14:36:36 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

Here's a valid use for subnet router anycase that isn't working.
Somebody asked me how to set up 6to4, so I did a little testing.

Doesn't work:

hades:~# ip route add ::/0 via 2002:c058:6301::
RTNETLINK answers: Invalid argument

Works:

hades:~# ip route add ::/0 via 2002:c058:6301::1

Unfortunately the first form is what I need:

hades:~# host -t AAAA 6to4.ipv6.funet.fi
6to4.ipv6.funet.fi has AAAA address 2001:708:0:1::624
6to4.ipv6.funet.fi has AAAA address 2002:c058:6301::

So apparently there really is an inappropriate subnet router anycast
sanity check. Please fix this!

	MikaL

On Fri, 2003-07-11 at 08:22, Pekka Savola wrote:
> On 11 Jul 2003, Mika Liljeberg wrote:
> > On Fri, 2003-07-11 at 07:51, Pekka Savola wrote:
> > > Well, the system may make some sense, but IMHO, there is still zero sense 
> > > in policing this thing when you add a route.  That's just plain bogus.  
> > > This is a bug which must be fixed ASAP.
> > 
> > Correct me if I'm wrong but I think in this case the interface had
> > forwarding enabled and the sanity check in fact prevented a default
> > route pointing to the node itself from being configured.
> >
> > Otherwise I fully agree. The subnet router anycast address doesn't
> > warrant any special handling.
> 
> If that's the case, it's OK -- it's OK, I don't remember the details.
> 
> (It might be nice to have configurable /proc option on whether to enable 
> the subnet router anycast address at all, but that's also a different 
> story..)
