Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVAGAm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVAGAm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVAGAkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:40:10 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:46260 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261152AbVAGAfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:35:17 -0500
Message-ID: <305061386.22926@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: rol@as2917.net
Cc: linux-kernel@vger.kernel.org
Date: Fri, 07 Jan 2005 09:29:46 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: ARP routing issue
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I met a question about ARP. If i send packet to another host using Raw socket at
one host and i set protocol type into TCP, then at another host i receive the
packet, but when i read the field skb->protocol, it is ARP. But when i changed a
host to send the packet, it does well. 

There are something wrong on my network card or the Kernel?


>Hello,
> 
> Have a look at /proc/sys/net/conf/XXX/arp_filter :
> 
>         
> arp_filter - BOOLEAN
>         1 - Allows you to have multiple network interfaces on the same
>         subnet, and have the ARPs for each interface be answered
>         based on whether or not the kernel would route a packet from
>         the ARP'd IP out that interface (therefore you must use source
>         based routing for this to work). In other words it allows control
>         of which cards (usually 1) will respond to an arp request.
> 
>         0 - (default) The kernel can respond to arp requests with addresses
>         from other interfaces. This may seem wrong but it usually makes
>         sense, because it increases the chance of successful communication.
>         IP addresses are owned by the complete host on Linux, not by
>         particular interfaces. Only for more complex setups like load-
>         balancing, does this behaviour cause problems.
> 
> Regards,
> Paul
> 
> Paul Rolland, rol(at)as2917.net
> ex-AS2917 Network administrator and Peering Coordinator
> 
> --
> 
> Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur
> 
> "Some people dream of success... while others wake up and work hard at it" 
> 
>   
> 
> > -----Message d'origine-----
> > De : linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] De la part de Jan De Luyck
> > Envoy?: jeudi 6 janvier 2005 17:12
> > ?: Steve Iribarne
> > Cc : linux-kernel@vger.kernel.org; linux-net@vger.kernel.org
> > Objet : Re: ARP routing issue
> > 
> > On Thursday 06 January 2005 17:06, Steve Iribarne wrote:
> > > Hi Jan,
> > >
> > >
> > > -> default gateway is set to 10.0.22.1, on eth0.
> > > ->
> > > -> Problem is, if I try to ping from another network
> > > -> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
> > > ->
> > > -> arp who-has 10.0.22.1 tell 10.0.24.xx
> > > ->
> > >
> > > You see that coming out the eth0 interface??
> > >
> > > If that is the case it is most definately wrong.  Assuming that your
> > > masks are setup properly.  But I haven't worked on the 2.4 
> > kernel for a
> > > long time so I'm not so sure if what you are seeing is a 
> > bug that has
> > > been fixed.
> > 
> > The network information is:
> > eth0 10.0.22.xxx mask 255.255.255.0
> > eth1 10.0.24.xxx mask 255.255.255.0
> > 
> > routing:
> > 10.0.22.0 0.0.0.0 255.255.255.0 eth0
> > 10.0.24.0 0.0.0.0 255.255.255.0 eth1
> > 0.0.0.0  10.0.22.1 0.0.0.0  eth0
> > 
> > Jan
> > 
> > -- 
> > If a man slept by day, he had little time to work.  That was a
> > satisfying notion to Escargot.
> >   -- "The Stone Giant", James P. Blaylock
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


