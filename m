Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQLCMrk>; Sun, 3 Dec 2000 07:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbQLCMra>; Sun, 3 Dec 2000 07:47:30 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:32208 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130304AbQLCMr1>; Sun, 3 Dec 2000 07:47:27 -0500
Message-ID: <3A2A3A94.167C4D20@uow.edu.au>
Date: Sun, 03 Dec 2000 23:20:36 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <200012022318.SAA17498@tsx-prime.MIT.EDU> <Pine.GSO.4.21.0012021830090.28923-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Erm... Not that ignoring the return values was a bright idea, but the
> lack of reliable ordered datagram protocol in IP family is not a good
> thing. It can be implemented over TCP, but it's a big overkill. IL is a
> nice thing to have...

Pet peeve?  There are about five "reliable UDPs" floating
around.  Take a look at

	http://www.faqs.org/rfcs/rfc2960.html

SCTP is mainly designed as a way of transporting telephony signalling
information across IP.  But it is now a quite general purpose protocol.

Culturally, this is "Telephony industry comes to IP.  Telephony
industry is appalled.  IP industry gets a clue".

SCTP provides the reliable delivery of messages to which you refer.
It's slightly more efficient than TCP for a given set of network
characteristics - there's no statement about implementation
efficiency here. No head-of-line blocking issues.

One very interesting part of SCTP is that transport endpoints are
explicitly set up between *hosts*, not between IP addresses.  The
protocol is designed around multihomed hosts.

I don't know if anyone has looked into mapping SCTP capabilities onto
the BSD socket API.  It may be hard.

The reference implementation is for userland Linux.  It's at
ftp://standards.nortelnetworks.com/sigtran/

A good kernel-mode implementation of SCTP for Linux would be
a very big project.  But also a very big contribution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
