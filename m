Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSKMQfI>; Wed, 13 Nov 2002 11:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSKMQfI>; Wed, 13 Nov 2002 11:35:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41604 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262023AbSKMQfH>; Wed, 13 Nov 2002 11:35:07 -0500
Date: Wed, 13 Nov 2002 11:44:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chuck Lever <cel@citi.umich.edu>
cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <Pine.BSO.4.33.0211131054260.29275-100000@citi.umich.edu>
Message-ID: <Pine.LNX.3.95.1021113113943.2196A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Chuck Lever wrote:

> On Tue, 12 Nov 2002, Dan Kegel wrote:
> 
> > Chuck wrote:
> > > make RPC timeout behavior over TCP sockets behave more like reference
> > > client implementations.  reference behavior is to transmit the same
> > > request three times at 60 second intervals; if there is no response, close
> > > and reestablish the socket connection.  we modify the Linux RPC client as
> > > follows:
> > >
> > > +  after a minor retransmit timeout, use the same timeout value when
> > >    retrying on a TCP socket rather than doubling the value
> > > +  after a major retransmit timeout, close the socket and attempt
> > >    to reestablish a fresh TCP connection
> > >
> > > note that today mount uses a 6 second timeout with 5 retries for NFS over
> > > TCP by default; proper default behavior is 2 retries each with 60 second
> > > timeouts.  a separate patch for mount is pending.
> >
> > Chuck, can you briefly explain why RPC does any minor
> > retransmits at all over TCP?
> > Shouldn't TCP's natural retransmit take care of that?
> 
> the socket layer guarantees delivery only to the RPC server application...
> if the application itself chooses to drop the request, an RPC retransmit
> is still required.
> 
> 	- Chuck Lever
> --

If the application "chooses to drop the request", the kernel is not
required to fix that application. The RPC cannot retransmit if
it has been shut-down or disconnected, which is about the only
way the application could "choose to drop the request". So something
doesn't smell right here.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


