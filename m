Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbRBBFsK>; Fri, 2 Feb 2001 00:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRBBFsA>; Fri, 2 Feb 2001 00:48:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23680 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129239AbRBBFrw>;
	Fri, 2 Feb 2001 00:47:52 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.18890.146329.92116@pizda.ninka.net>
Date: Thu, 1 Feb 2001 21:46:50 -0800 (PST)
To: "Paul D. Smith" <pausmith@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEADDR redux
In-Reply-To: <14970.5436.897143.934189@lemming.engeast.baynetworks.com>
In-Reply-To: <14969.57896.331183.374489@lemming.engeast.baynetworks.com>
	<E14OSOC-0005FD-00@the-village.bc.nu>
	<14970.5436.897143.934189@lemming.engeast.baynetworks.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul D. Smith writes:
 > %% Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
 > 
 >   >> This application uses SO_REUSEADDR in conjunction with INADDR_ANY.  What
 >   >> it does is bind() to INADDR_ANY, then listen().  Then, it proceeds to
 >   >> bind (but _not_ listen) various other specific addresses.
 > 
 >   ac> That should be ok if its setting SO_REUSEADDR
 > 
 > I agree, and so does Solaris/FreeBSD, but Linux doesn't.

After reading up some code, FreeBSD does do a bind() check which is
just as restrictive as Linux's except that they allow INADDR_ANY
combinations when the credentials of the user doing the bind() match
the credentials of all other sockets bound to that port.

I don't think we should change our behavior.  Allowing the combination
in question only when the UIDs match between the socket owners is
dubious at best.

I actually went to the FreeBSD code because what Steven's showed
was extremely loose in what it let through.  It allowed the nfs
port override trick Alan mentioned.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
