Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBFJ1w>; Tue, 6 Feb 2001 04:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129553AbRBFJ1n>; Tue, 6 Feb 2001 04:27:43 -0500
Received: from mons.uio.no ([129.240.130.14]:61603 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129154AbRBFJ1e>;
	Tue, 6 Feb 2001 04:27:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14975.50036.444871.571598@charged.uio.no>
Date: Tue, 6 Feb 2001 10:27:16 +0100 (CET)
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
In-Reply-To: <14975.15829.623996.534161@notabene.cse.unsw.edu.au>
In-Reply-To: <Pine.LNX.4.21.0102051728340.1460-100000@winds.org>
	<14975.15829.623996.534161@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Neil Brown <neilb@cse.unsw.edu.au> writes:

     > The attached patch might fix it, so if you are having
     > reproducable problems, it might be worth applying this patch.

     > Trond: any comments?


     > +
     > + spin_lock_bh(&serv->sv_lock);
     >  	if (!--(svsk->sk_inuse) && svsk->sk_dead) {
     > + spin_unlock_bh(&serv->sv_lock);
     >  		dprintk("svc: releasing dead socket\n");
     >  		sock_release(svsk->sk_sock);
     >  		kfree(svsk);
     >  	}
     > + else
     > + spin_unlock_bh(&serv->sv_lock);
     >  }
 
Looks correct, but there's a similar problem in svc_delete_socket()
(see the setting of sk_dead, and subsequent test for sk_inuse).

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
