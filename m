Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290862AbSBFWQq>; Wed, 6 Feb 2002 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290860AbSBFWQi>; Wed, 6 Feb 2002 17:16:38 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:37809 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S290852AbSBFWQT>; Wed, 6 Feb 2002 17:16:19 -0500
Message-ID: <3C61ACDB.6759302F@nortelnetworks.com>
Date: Wed, 06 Feb 2002 17:23:23 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <Pine.LNX.3.95.1020206154220.29419A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

[snip]
> Hackers code sendto as:
>         sendto(s,...);
> Professional programmers use:
>         (void)sendto(s,...);
> 
> checking the return value is useless.
> 
> Note that the man-page specifically states that ENOBUFS can't happen.

I don't know what your manpage says, but my manpage doesn't say anything about
ENOBUFS not being possible.  From the man page: 

"ENOBUFS The system was unable to allocate an internal memory block.  The
operation may succeed when buffers become available."

> You cannot assume that any sendto() data actually gets on the wire, much
> less to its destination. With any user-datagram-protocol, both ends,
> sender and receiver, have to work out what they will do with missing
> packets and packets received out-of-order.

Hmm.  I knew you couldn't assume it was delivered (the man page says so), but I
didn't know it doesn't guarantee it getting to the wire.  The man page says that
"locally detected errors are indicated by a return value  of -1".  Furthermore,
it also says "When the  message does not fit into the send buffer of the socket,
send normally blocks, unless the socket has been placed in non-blocking I/O
mode."

I would suggest that if the packet doesn't make it onto the wire, sendto()
should either a) block until it can send the packet (or return with EAGAIN, as
appropriate), or b) return an error.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
