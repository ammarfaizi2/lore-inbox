Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281308AbRKTUF4>; Tue, 20 Nov 2001 15:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281320AbRKTUFq>; Tue, 20 Nov 2001 15:05:46 -0500
Received: from mons.uio.no ([129.240.130.14]:63136 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281308AbRKTUFb>;
	Tue, 20 Nov 2001 15:05:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15354.46981.205894.631707@charged.uio.no>
Date: Tue, 20 Nov 2001 21:05:25 +0100
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <200111201945.WAA03637@ms2.inr.ac.ru>
In-Reply-To: <15354.45419.978323.438540@charged.uio.no>
	<200111201945.WAA03637@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > Hello!
    >> Deadlock - in exactly the same way as with the xprt code...

     > Soooory! Delete from the picture all except for containing
     > QDIO:


     > (Call QDIO bottom half code) spin_lock(&QDIO_lock);
     >                                                  <QDIO hard
     >                                                  interrupt>
    -> spin_lock(&QDIO_lock)
     >                                                               (spins...)

     > with the same result. No help of nfs is required. :-)

     > So, you have drawn wrong picture.

>From the mail I received, I gathered that they were protected against
this. The hard interrupt could only occur on another processor.

In any case, my point is that the xprt stuff does *nothing* that is
not also done in the fasync code. If a spinlock deadlock scenario is
possible in one, then it is also possible in the other.

Cheers,
  Trond
