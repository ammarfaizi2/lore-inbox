Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRKSS41>; Mon, 19 Nov 2001 13:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280606AbRKSS4S>; Mon, 19 Nov 2001 13:56:18 -0500
Received: from mons.uio.no ([129.240.130.14]:52453 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S276759AbRKSS4I>;
	Mon, 19 Nov 2001 13:56:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15353.21949.239139.993379@charged.uio.no>
Date: Mon, 19 Nov 2001 19:55:57 +0100
To: kuznet@ms2.inr.ac.ru
Cc: b.lammering@science-computing.de, linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <200111191849.VAA21085@ms2.inr.ac.ru>
In-Reply-To: <15353.19920.461805.879956@charged.uio.no>
	<200111191849.VAA21085@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > No. sock_writable() is for datagram sockets, TCP never used or
     > satisfied this predicate, it used(s) more interesting one.

     > BTW applications need not use this anyway, we do not awake
     > people for no reasons. If a write failed with EAGAIN, wakeup
     > will happen only when there is some room for write. And it will
     > not be awaken again until the next write will fail. So, if you
     > rejected wakeup (due to wrong predicate), nobody will remind
     > you again.

Thanks... Then the patch I sent Birger is very likely the correct one.

Originally I had a test for whether sock_wspace(sk) was greater than
some minimal value. We need this for UDP in order to avoid waking up
'rpciod' before the socket buffer is large enough to accommodate the
RPC datagram. As the same code worked in 2.2.x for TCP, I had assumed
it was OK...

Cheers,
   Trond
