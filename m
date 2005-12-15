Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbVLONcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbVLONcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbVLONcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:32:41 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:48344 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1422723AbVLONck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:32:40 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Arjan van de Ven <arjan@infradead.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Sridhar Samudrala <sri@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1134652070.16486.44.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
	 <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
	 <43A08546.8040708@superbug.co.uk> <20051215015456.GC23393@gaz.sfgoth.com>
	 <43A155AE.4050105@superbug.co.uk>
	 <1134647248.16486.37.camel@laptopd505.fenrus.org>
	 <1134651635.5912.108.camel@localhost.localdomain>
	 <1134652070.16486.44.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: unknown
Date: Thu, 15 Dec 2005 08:32:35 -0500
Message-Id: <1134653556.5912.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-15-12 at 14:07 +0100, Arjan van de Ven wrote:
> On Thu, 2005-12-15 at 08:00 -0500, jamal wrote:

> > The big hole punched by DaveM is that of dependencies: a http tcp
> > connection is tied to ICMP or the IPSEC example given; so you need a lot
> > more intelligence than just what your app is knowledgeable about at its
> > level. 
> 
> yeah well sort of. You're right of course, but that also doesn't mean
> you can't give hints from the other side. Like "data for this socked is
> NOT critical important". It gets tricky if you only do it for OOM stuff;
> because then that one ACK packet could cause a LOT of memory to be
> freed, and as such can be important for the system even if the socket
> isn't.
> 

true - but thats _just one input_ into a complex policy decision
process. The other is clearly VM realizing some type of threshold has
been crossed. The output being a policy decision of what to drop - which
gets very interesting if one looks at it being as fine grained as "drop
ACKS". 

The fallacy in the proposed solution is that it simplisticly ties 
the decision to VM input and the network level input to sockets; as in
the example of sockets doing http requests.

Methinks what is needed is something which keeps state and takes input
from the sockets and the VM and then runs some algorithm to decide what
needs to be the final policy that gets installed at the low level kernel
(tc classifier level or hardware). Sockets provide hints that they are
critical. The box admin could override what is important.

cheers,
jamal

