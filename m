Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264662AbRFTXBB>; Wed, 20 Jun 2001 19:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFTXAv>; Wed, 20 Jun 2001 19:00:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264662AbRFTXAe>;
	Wed, 20 Jun 2001 19:00:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15153.11018.776005.851455@pizda.ninka.net>
Date: Wed, 20 Jun 2001 16:00:26 -0700 (PDT)
To: Bob Matthews <bob@CS.WM.EDU>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION]: sk->data_ready/state_change callbacks in struct sock
In-Reply-To: <Pine.LNX.4.33.0106201812040.11104-100000@me.cs.wm.edu>
In-Reply-To: <Pine.LNX.4.33.0106201812040.11104-100000@me.cs.wm.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bob Matthews writes:
 > So, here are my questions:
 > 
 > - My understanding from the code is that sk->state_change is called when a
 > struct sock transits from SYN_RCVD to ESTABLISHED and from ESTABLISHED to
 > {CLOSE_WAIT,FIN_WAIT_1}.  Is this correct?

This happens for the CHILD socket, not the listening one.

 > - sk->data_ready is called whenever any new data is deposited in the
 > associated sk_buff.  Is this correct?

Yes, and for listening sockets this is the callback made when a new
connection comes in.  See net/sunrpc/svcsock.c function
svc_tcp_listen_data_ready(), it's doing what you want to do.  Make
sure to check in a recent kernel because this used to make the same
mistake you are making, using state_change instead of data_ready on a
listening socket.

Later,
David S. Miller
davem@redhat.com

