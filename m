Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKMPv5>; Wed, 13 Nov 2002 10:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKMPv5>; Wed, 13 Nov 2002 10:51:57 -0500
Received: from citi.umich.edu ([141.211.92.141]:5237 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S261900AbSKMPv5>;
	Wed, 13 Nov 2002 10:51:57 -0500
Date: Wed, 13 Nov 2002 10:58:48 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <3DD19332.1050703@kegel.com>
Message-ID: <Pine.BSO.4.33.0211131054260.29275-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002, Dan Kegel wrote:

> Chuck wrote:
> > make RPC timeout behavior over TCP sockets behave more like reference
> > client implementations.  reference behavior is to transmit the same
> > request three times at 60 second intervals; if there is no response, close
> > and reestablish the socket connection.  we modify the Linux RPC client as
> > follows:
> >
> > +  after a minor retransmit timeout, use the same timeout value when
> >    retrying on a TCP socket rather than doubling the value
> > +  after a major retransmit timeout, close the socket and attempt
> >    to reestablish a fresh TCP connection
> >
> > note that today mount uses a 6 second timeout with 5 retries for NFS over
> > TCP by default; proper default behavior is 2 retries each with 60 second
> > timeouts.  a separate patch for mount is pending.
>
> Chuck, can you briefly explain why RPC does any minor
> retransmits at all over TCP?
> Shouldn't TCP's natural retransmit take care of that?

the socket layer guarantees delivery only to the RPC server application...
if the application itself chooses to drop the request, an RPC retransmit
is still required.

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

