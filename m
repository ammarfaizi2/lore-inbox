Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSGJPuQ>; Wed, 10 Jul 2002 11:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317528AbSGJPuP>; Wed, 10 Jul 2002 11:50:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52673 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317522AbSGJPuO>;
	Wed, 10 Jul 2002 11:50:14 -0400
Message-ID: <1026316367.3d2c584f45ab0@imap.linux.ibm.com>
Date: Wed, 10 Jul 2002 11:52:47 -0400
From: niv@us.ibm.com
To: hurwitz@lanl.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: How many copies to get from NIC RX to user read()?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.0.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I could've sworn I heard the stack was single-copy 
> on both the TX and RX sides. But, it doesn't look to 
> me like it is. Rather, it looks like there is one copy 
> in tcp_rcv_estabilshed() (via tcp_copy_to_iovec()), and a
> second copy in tcp_recvmsg() (which is called when the 
> user calls read()). Both of these copies are, I believe, 
> done by skb_copy_datagram_iovec().

tcp_recvmsg() only does the copy from the receive_queue
or the backlog queue. tcp_rcv_established() does the copy
directly into the iovec or queues it onto the receive_queue 
or backlog queue for tcp_recvmsg() to complete the work. So 
there arent two copies of the same data happening, just a 
question of one or the other function doing the work depending 
on whether there is currently a process doing a read or not..

hth,

thanks,
Nivedita


