Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVAFSD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVAFSD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVAFR46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:56:58 -0500
Received: from tag.witbe.net ([81.88.96.48]:15567 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262932AbVAFRxV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:53:21 -0500
Message-Id: <200501061753.j06HrJ101272@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Jan De Luyck'" <lkml@kcore.org>,
       "'Steve Iribarne'" <steve.iribarne@dilithiumnetworks.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: ARP routing issue
Date: Thu, 6 Jan 2005 18:53:19 +0100
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <200501061711.59301.lkml@kcore.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcT0CrSZiWR5VUhLSoGcYdaWVJMuAwADdRrQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Have a look at /proc/sys/net/conf/XXX/arp_filter :

        
arp_filter - BOOLEAN
        1 - Allows you to have multiple network interfaces on the same
        subnet, and have the ARPs for each interface be answered
        based on whether or not the kernel would route a packet from
        the ARP'd IP out that interface (therefore you must use source
        based routing for this to work). In other words it allows control
        of which cards (usually 1) will respond to an arp request.

        0 - (default) The kernel can respond to arp requests with addresses
        from other interfaces. This may seem wrong but it usually makes
        sense, because it increases the chance of successful communication.
        IP addresses are owned by the complete host on Linux, not by
        particular interfaces. Only for more complex setups like load-
        balancing, does this behaviour cause problems.

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de Jan De Luyck
> Envoyé : jeudi 6 janvier 2005 17:12
> À : Steve Iribarne
> Cc : linux-kernel@vger.kernel.org; linux-net@vger.kernel.org
> Objet : Re: ARP routing issue
> 
> On Thursday 06 January 2005 17:06, Steve Iribarne wrote:
> > Hi Jan,
> >
> >
> > -> default gateway is set to 10.0.22.1, on eth0.
> > ->
> > -> Problem is, if I try to ping from another network
> > -> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
> > ->
> > -> arp who-has 10.0.22.1 tell 10.0.24.xx
> > ->
> >
> > You see that coming out the eth0 interface??
> >
> > If that is the case it is most definately wrong.  Assuming that your
> > masks are setup properly.  But I haven't worked on the 2.4 
> kernel for a
> > long time so I'm not so sure if what you are seeing is a 
> bug that has
> > been fixed.
> 
> The network information is:
> eth0 10.0.22.xxx mask 255.255.255.0
> eth1 10.0.24.xxx mask 255.255.255.0
> 
> routing:
> 10.0.22.0 0.0.0.0 255.255.255.0 eth0
> 10.0.24.0 0.0.0.0 255.255.255.0 eth1
> 0.0.0.0  10.0.22.1 0.0.0.0  eth0
> 
> Jan
> 
> -- 
> If a man slept by day, he had little time to work.  That was a
> satisfying notion to Escargot.
>   -- "The Stone Giant", James P. Blaylock
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

