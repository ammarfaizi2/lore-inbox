Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSHHQN1>; Thu, 8 Aug 2002 12:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHHQN1>; Thu, 8 Aug 2002 12:13:27 -0400
Received: from firewall.citel.com ([62.190.107.60]:64946 "EHLO cad.citel.com")
	by vger.kernel.org with ESMTP id <S317643AbSHHQNM>;
	Thu, 8 Aug 2002 12:13:12 -0400
Date: Thu, 8 Aug 2002 17:15:24 +0100
From: Michael Procter <lkml@procter-collective.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Unix-domain sockets - abstract addresses
Message-ID: <20020808171524.A2469@cad.citel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to use unix domain datagram sockets in an application,
but have found what appears to be an inconsistency between the kernel and
the manpage unix(7).

I have a server, which creates a socket, binds it to an address and then
does a recvfrom().  When it gets a packet, it tries to respond with
sendto(), supplying the address information from the recvfrom() call.

All this works fine when the client binds it's socket to an address in the
filesystem before issuing the connect().  But I don't want another
filesystem entity, so I am trying to use an address in the abstract
namespace.

Abstract addresses work fine when the client calls bind() with an address
length of 2, and also if it sets the socket option SO_PASSCRED before
connect().  But if the client does neither and simply calls connect(),
the server gets an invalid 'from' address (address family usually zero,
but I have seen 0x0BA5, 0x7FA8, 0x1FA8 and others).

According to the man page 'unix(7)':
When a socket is connected and it doesn't already have a local address a
unique address in the abstract namespace will be generated automatically.

So, the question is:  which is right?  The man page, or af_unix.c?

I have been doing my tests on 2.4.9-34 (RedHat 7.2), but looking at 2.4.19
from kernel.org, the results should be the same.

Regards,

Michael Procter
