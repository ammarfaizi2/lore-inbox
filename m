Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277046AbRJQSqd>; Wed, 17 Oct 2001 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276716AbRJQSqX>; Wed, 17 Oct 2001 14:46:23 -0400
Received: from mons.uio.no ([129.240.130.14]:26824 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S277059AbRJQSqP>;
	Wed, 17 Oct 2001 14:46:15 -0400
To: kuznet@ms2.inr.ac.ru
Cc: kalele@veritas.COM (Shirish Kalele), linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFSD over TCP: TCP broken?
In-Reply-To: <200110171758.VAA22159@ms2.inr.ac.ru>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Oct 2001 20:38:31 +0200
In-Reply-To: kuznet@ms2.inr.ac.ru's message of "Wed, 17 Oct 2001 21:58:37 +0400 (MSK DST)"
Message-ID: <shsk7xu5cyg.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > Hello!
    >> where the interleaving gets in.

     > I do not think that you diagnosed the problem correctly.  nfsd
     > used non blocking io and write to tcp is strictly atomic in
     > this case.

Some of the patches that attempted to fix the nfsd server code relied
on making the TCP stuff blocking. I've seen several such patches
floating around that ignore the fact that the socket lock is dropped
when the IPV4 socket code sleeps.

In any case, even with nonblocking TCP, one has to protect the socket
until the entire message has been sent. Otherwise we risk seeing
another thread racing for the socket while we're doing whatever needs
to be done to clear the -EAGAIN.

Cheers,
  Trond
