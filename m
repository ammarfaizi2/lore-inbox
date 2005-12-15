Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVLONAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVLONAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVLONAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:00:50 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:38332 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S965202AbVLONAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:00:49 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Arjan van de Ven <arjan@infradead.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Sridhar Samudrala <sri@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1134647248.16486.37.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
	 <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
	 <43A08546.8040708@superbug.co.uk> <20051215015456.GC23393@gaz.sfgoth.com>
	 <43A155AE.4050105@superbug.co.uk>
	 <1134647248.16486.37.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: unknown
Date: Thu, 15 Dec 2005 08:00:35 -0500
Message-Id: <1134651635.5912.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-15-12 at 12:47 +0100, Arjan van de Ven wrote:
> > 
> > You are using the wrong hammer to crack your nut.
> > You should instead approach your problem of why the ARP entry gets lost.
> > For example, you could give as critical priority to your TCP session, 
> > but that still won't cure your ARP problem.
> > I would suggest that the best way to cure your arp problem, is to 
> > increase the time between arp cache refreshes.
> 
> or turn it around entirely: all traffic is considered important
> unless... and have a bunch of non-critical sockets (like http requests)
> be marked non-critical.

The big hole punched by DaveM is that of dependencies: a http tcp
connection is tied to ICMP or the IPSEC example given; so you need a lot
more intelligence than just what your app is knowledgeable about at its
level. 
You cant really do this shit at the socket level. You need to do it much
earlier.
At runtime, when lower memory thresholds gets crossed, you kick
classification of what packets need to be dropped using something along
the lines of statefull/connection tracking. When things get better you
undo.

cheers,
jamal

