Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbREQXwC>; Thu, 17 May 2001 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbREQXvx>; Thu, 17 May 2001 19:51:53 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:46096 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S262218AbREQXvo>; Thu, 17 May 2001 19:51:44 -0400
Date: Fri, 18 May 2001 00:51:39 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
In-Reply-To: <E150WkN-0006JK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0105180042440.21745-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 May 2001, Alan Cox wrote:

> > The following program blocks indefinitely on Linux (2.2, 2.4 not tested).
> > Since the other end is clearly gone, I would expect some sort of error
> > condition. Indeed, FreeBSD gives ECONNRESET.
>
> Since its a datagram socket Im not convinced thats a justifiable assumption.

Hmm - there's definitely a Linux inconsistency here. With SOCK_DGRAM,
read() is blocking but write() is giving ECONNRESET.

The ECONNRESET makes sense to me (despite this being a datagram socket),
because the sockets are anonymous. Once one end goes away, the other end
is pretty useless.

Cheers
Chris

