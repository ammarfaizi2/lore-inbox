Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132358AbQLRSkl>; Mon, 18 Dec 2000 13:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbQLRSkb>; Mon, 18 Dec 2000 13:40:31 -0500
Received: from icarus.weber.edu ([137.190.16.17]:10375 "HELO icarus.weber.edu")
	by vger.kernel.org with SMTP id <S130017AbQLRSkL>;
	Mon, 18 Dec 2000 13:40:11 -0500
Date: Mon, 18 Dec 2000 11:00:58 -0700 (MST)
From: Phillip Neiswanger <phil@icarus.weber.edu>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Steeling TCP packets...
Message-ID: <Pine.GSO.3.96.1001218103002.7475D-100000@icarus.weber.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am in the process of writing a kernel driver to support some
client/server software.  This software dealing mainly with packets that it
sends/receives via tcp and udp.  I can't really go into the architecture
of that software, but for various performance reasons it has been decided
we should move some of our server code into the kernel.  The job of this
code is mainly to route incoming client packets to the appropriate server
and to route outgoing packets to the appropriate client connection.  To
improve the performance of the read-side we would like to grab packets
early from the TCP stack.  I have looked over the TCP code and have found
spots in tcp_ofo_queue(), tcp_data_queue() and tcp_rcv_established() that
queue incoming packets onto a sockets buffer with a call to
__skb_queue_tail(&sk->receive_queue, skb).  I would like to wrap this
function call with code that checks if it is one of our sockets and queue
it up on our buffers rather than TCPs.  The sockets themselves will never
experience read() calls, but they will experience write() calls from our
code.

My question is what are the consequences of taking data at this point?  It
looks like the tcp code has handled all of the acknowledging by the time
the queueing occurs, but I'm not totally sure of this.  Since all data
received from the client are in the form of 512 byte packets each sk_buf
should contain a complete packet and thus out of order packets are not a
concern.

Any comments?
--

                                phil
                                email:  phil@icarus.weber.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
