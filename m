Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSGJVYW>; Wed, 10 Jul 2002 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317629AbSGJVYV>; Wed, 10 Jul 2002 17:24:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34261 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317628AbSGJVYT>; Wed, 10 Jul 2002 17:24:19 -0400
Message-ID: <1026336421.3d2ca6a50d35b@imap.linux.ibm.com>
Date: Wed, 10 Jul 2002 14:27:01 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: "Hurwitz Justin W." <hurwitz@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How many copies to get from NIC RX to user read()?
References: <Pine.LNX.4.44.0207101509240.17835-100000@alvie-mail.lanl.gov>
In-Reply-To: <Pine.LNX.4.44.0207101509240.17835-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, to make sure I have this right:
> 
> When the data is processed from the NIC
>   tcp_rcv_established() is called in processing it
>     if a user process is waiting on the socket
>       iovec copy data to the user
>     else
>       copy it to receive_queue or backlog_queue

well, we append the skb to the tail of the queue.
this is not a copy operation. (just a few instructions).

> When the user tries read (in any way) a socket
>   iovec copy from receive_queue or backlog_queue
> 
> 
> E.g., if the user is ready for the data, dump it straight from
> SKBs. Else, 
> don't waste SKBs on a lazy (or busy) user and copy the data to a
> queue.

yep.

> If this is right, I'm happy :) If it's wrong, please correct. 
> 
> Thx,
> --Gus

I should add that my reading of the code is hardly
authoritative :). caveat emptor...

thanks,
Nivedita



