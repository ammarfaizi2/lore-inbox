Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbRFADoY>; Thu, 31 May 2001 23:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFADoO>; Thu, 31 May 2001 23:44:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62645 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263341AbRFADoG>;
	Thu, 31 May 2001 23:44:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15127.3906.773953.16829@pizda.ninka.net>
Date: Thu, 31 May 2001 20:42:58 -0700 (PDT)
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] save source address on accept()
In-Reply-To: <3B16EFE0.D0C44FB8@sun.com>
In-Reply-To: <3B16EFE0.D0C44FB8@sun.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Hockin writes:
 > attached is a (small) patch which saves the src address on tcp_accept(). 
 > Please let me know if there are any problems taking this for general
 > inclusion.
 ..
 > --- dist-2.4.5/net/ipv4/tcp.c	Wed May 16 10:31:27 2001
 > +++ cobalt-2.4.5/net/ipv4/tcp.c	Thu May 31 14:33:23 2001
 > @@ -2138,6 +2138,7 @@
 >  		tp->accept_queue_tail = NULL;
 >  
 >   	newsk = req->sk;
 > +	newsk->rcv_saddr = req->af.v4_req.loc_addr;
 >  	tcp_acceptq_removed(sk);
 >  	tcp_openreq_fastfree(req);
 >  	BUG_TRAP(newsk->state != TCP_SYN_RECV);

Tim, this is in fact completely bogus, it is already being done
in tcp_v{4,6}_syn_recv_sock(), so there is no reason to do the
exact same thing again here in tcp_accept().

Later,
David S. Miller
davem@redhat.com
