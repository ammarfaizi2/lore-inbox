Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRHPA7y>; Wed, 15 Aug 2001 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRHPA7o>; Wed, 15 Aug 2001 20:59:44 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:26019 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S268582AbRHPA7e>; Wed, 15 Aug 2001 20:59:34 -0400
From: Manfred Bartz <mbartz@optushome.com.au>
Message-ID: <20010816005902.16224.qmail@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: connect() does not return ETIMEDOUT
In-Reply-To: <Pine.LNX.4.21.0108151123510.4809-100000@w-sridhar2.des.sequent.com>
In-Reply-To: Sridhar Samudrala's message of "Wed, 15 Aug 2001 14:41:15 -0700 (PDT)"
Organization: yes
Date: 16 Aug 2001 10:59:02 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala <samudrala@us.ibm.com> writes:

> linux has 2 queues associated with a listening socket...
> The second one is called accept queue which hold the complete
> connections ... The length of this queue ... is actually backlog+1.
> 
> When the accept queue is full, new incoming SYNs are accepted in a burst of 
> 2 at a time. These are put in the SYN table expecting that the accept queue
> will open up by the time we receive the ACK. If the accept queue doesn't get
> open up, the ACK is simply dropped and SYN-ACK is sent again after a certain
> timeout period. 

Thanks for the explanation, I appreciate it.

> In your example, 6 connections succeed immediately.
> But only 4 enter ESTABLISHED state.
> 2 are accepted by the server. 2 remain in the accept queue (backlog+1).

Ok, that part makes sense.

> 2 of them are added to the SYN table. 

So, the connections in the SYN table should be half open?
No server SYN should have been returned?
I just re-discovered ``TCP/IP Illustrated'' Vol.1 by W.R.Stevens and
it confirms this in section 18.11 under ``Incoming Connection Request
Queue''.  The book says:

    5. If there is not room on the queue for the new connection, TCP
    just ignores the received SYN.  Nothing is sent back (i.e. no RST
    segment).  ...

But in reality and going by the tcpdump, an unlimited number of
connections is accepted because the server side completes the 3-way
handshake regardless.  The connections are then lost later (with a
different error message).  This does not look right to me.

Comments?

-- 
Manfred
