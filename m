Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154660-8088>; Wed, 16 Sep 1998 12:12:46 -0400
Received: from dialup191-2-23.swipnet.se ([130.244.191.87]:2068 "HELO braindamage.linux.bogus" ident: "qmailr") by vger.rutgers.edu with SMTP id <154820-8088>; Wed, 16 Sep 1998 10:31:02 -0400
Message-ID: <19980916195349.B7199@braindamage.linux.bogus>
Date: Wed, 16 Sep 1998 19:53:49 +0200
From: Erik Elmgren <erik.elmgren@swipnet.se>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RTO [was Re: my broken TCP is faster on broken networks [Re: Very poor TCP/SACK performance]]
Mail-Followup-To: linux-kernel@vger.rutgers.edu
References: <19980916133745.A28753@castle.nmd.msu.ru> <Pine.LNX.3.96.980916134543.235B-100000@dragon.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.3.96.980916134543.235B-100000@dragon.bogus>; from Andrea Arcangeli on Wed, Sep 16, 1998 at 01:58:39PM +0200
X-Operating-System: Linux 2.1.120
X-Disclaimer: Speaking only for myself.
Sender: owner-linux-kernel@vger.rutgers.edu

Quoting Andrea Arcangeli (andrea@e-mind.com):
> On Wed, 16 Sep 1998, Savochkin Andrey Vladimirovich wrote:
> 
> >> Steven's books and the tcp-impl "known TCP implementation problems"
> >> draft, amongst other places.
> 
> Thanks. I' ll search for the draft (BTW, if anyone has a URL pointer could
> save me the time for the search ;-).

http://www.ietf.org/internet-drafts/draft-ietf-tcpimpl-prob-04.txt

It lists:

     No initial slow start
     No slow start after retransmission timeout
     Uninitialized CWND
     Inconsistent retransmission
     Failure to retain above-sequence data
     Extra additive constant in congestion avoidance
     Initial RTO too low
     Failure of window deflation after loss recovery
     Excessively short keepalive connection timeout
     Failure to back off retransmission timeout
     Insufficient interval between keepalives
     Stretch ACK violation
     Retransmission sends multiple packets
     Failure to send FIN notification promptly
     Failure to send a RST after Half Duplex Close
     Failure to RST on close with data pending
     Options missing from TCP MSS calculation

And is dated August 1998

The other drafts reachable through:

http://www.ietf.org/html.charters/tcpimpl-charter.html

Looks to be interesting too.

And this time I checked that it can be downloaded ;)

> 
> >I have no arguments for a certain initial value of RTO.
> >If 25/4 of the initial RTT is a design decision rather than a misprint
> >I'm quite satisfied.
> 

Abovementioned document quotes RFC1122, the initial RTO SHOULD be tree seconds,
but at that point it talks about RTO being to low and not to high. Neither
does it clearly state that three seconds is still the correct initial RTO.

The RTO is initialized to three seconds, see:

/usr/src/linux/include/net/tcp.h:286:#define TCP_TIMEOUT_INIT (3*HZ)    /* RFC 1122 initial timeout value       */

And in tcp_v4_init_sock():

tcp_ipv4.c:1756:        tp->rto  = TCP_TIMEOUT_INIT;            /*TCP_WRITE_TIME*/

In net/ipv4/tcp.c the following error is found:

    343  * Retransmission Timeout Calculation (4.2.3.1)
    344  *   MUST implement Karn's algorithm and Jacobson's algorithm for RTO
    345  *     calculation. (does, or at least explains them in the comments 8*b)
    346  *  SHOULD initialize RTO to 0 and RTT to 3. (does)
                                     ^            ^

It's the RTO that should be three seconds, and the RTT zero.

Regards Erik ``bigot´´ Elmgren

--

I haven't lost my mind - I've got it backed up on tape somewhere...
--- unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
