Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269725AbSISBjS>; Wed, 18 Sep 2002 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269727AbSISBjS>; Wed, 18 Sep 2002 21:39:18 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:37387 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S269725AbSISBjR>; Wed, 18 Sep 2002 21:39:17 -0400
Date: Thu, 19 Sep 2002 03:44:17 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Pointer: connect to 127.x.y.z succeeds
Message-ID: <20020919014417.GD12590@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a slight difference between Linux and FreeBSD. Assume each is
configured so that the loopback device is 127.0.0.1/8. Linux will then
accept a connect to 127.126.125.124, FreeBSD will instead say
EADDRNOTAVAIL:

     "49 EADDRNOTAVAIL Cannot assign requested address.  Normally results
     from an attempt to create a socket with an address not on this
     machine." (FreeBSD 4.7-PRERELEASE errno(2) man page)

While the routing decision seems right with automatic routes, it's
strange that Linux accepts a connection on an IP that is not configured.
Would it be feasible that Linux looks at the destination IP before
accepting a connection on the lo interface?


This may also be related to the issue raised some time ago that Linux
lets you connect to any local IP from any interface by default, so that
eth0 clients can connect to the eth2 IP even when the route is removed.
I believe Felix von Leitner complained about this behaviour.


I'd appreciate documentation pointers on this discussion as I believe
this has been mentioned before, yet I don't recall enough to feed Google
with a decent search.

-- 
Matthias Andree
