Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970893-3215>; Sat, 9 May 1998 22:02:30 -0400
Received: from miranda.uwaterloo.ca ([129.97.130.69]:4329 "EHLO enrico.ied.com" ident: "root") by vger.rutgers.edu with ESMTP id <970900-3215>; Sat, 9 May 1998 22:02:15 -0400
Date: Sat, 9 May 1998 22:08:10 -0400 (EDT)
From: Jan Vicherek <honza@ied.com>
Reply-To: Jan Vicherek <honza@ied.com>
To: Marc Lehmann <pcg@goof.com>
cc: linux-kernel@vger.rutgers.edu
Subject: clarification : Re: "renice" netowork usage.
In-Reply-To: <19980509215645.47060@cerebro.laendle>
Message-ID: <Pine.LNX.3.96.980509205921.5258k-100000@ann.ied.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Sat, 9 May 1998, Marc Lehmann wrote:

> 
> You can do this already in 2.1 kernels (TOS), per port. But note that _both_
> sides need to do this, otherwise it would almost have nil effect.

    Suppose the remote side is an HTTP server. The local (linux) side has
the HTTP client. The server doesn't have a clue as to what bandwidth is
available. So when the initial request for, say, a 200MB file is received,
it sends out about 10 (I guess) packets of data. That makes the TCP window
to be 10.

   As of now, the client responds with ACKs as soon as the data come
through the 33.6 pipe. Thus the server figures out that because it has got
the ACKs, it can now send more data. So it fills the pipe with 10 more
packets.

   My understanding of TCP tells me that "if the line conditions are
poor", the server adjusts the TCP window size to something smaller. Now
how the heck would the server knows what kind of line conditions are
ahead?! It doesn't. So how can it adjust the window side then ? By
guessing the line conditions from number and latency of ACKs.

   To regurgitate, WE CAN simulate low-bandwidth link by controlling the
number and latency of ACKs (and maybe even sequence). And this way we
trick the server and so control the flow out of the server.

   Are there any flaws in the above ?

   Please note that this must be implemented in the kernel, since TCP
clients don't currently have a way to control number and latency of ACK
packets to the data that it receives.
   This thread is about implementing such control into kernel.

     Thank you,

          Jan Vicherek

 -- Gospel of Jesus is the saving power of God for all who believe --
Jan Vicherek ## To some, nothing is impossible. ##  www.ied.com/~honza
    >>>    Free Software Union President  ...  www.fslu.org    <<<
Interactive Electronic Design Inc.    -#-    PGP: finger honza@ied.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
