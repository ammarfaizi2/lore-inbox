Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290817AbSBFV2Y>; Wed, 6 Feb 2002 16:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSBFV2P>; Wed, 6 Feb 2002 16:28:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25219 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290817AbSBFV2J>; Wed, 6 Feb 2002 16:28:09 -0500
Date: Wed, 6 Feb 2002 15:56:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <3C6192A5.911D5B4F@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020206154220.29419A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Chris Friesen wrote:

[SNIPPED...]


> 
> I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
> was calling sendto() on 217000 packets/sec, even though the wire could only
> handle about 127000 packets/sec.  I got no errors at all in sendto, even though
> over a third of the packets were not actually being sent.
> 

In principle, sendto() will always succeed unless you provided the
wrong parameters in the function call, or the machines crashes, at
which time your task won't be there to receive the error code anyway.

Hackers code sendto as:
	sendto(s,...);
Professional programmers use:
	(void)sendto(s,...);

checking the return value is useless.

Note that the man-page specifically states that ENOBUFS can't happen.

You cannot assume that any sendto() data actually gets on the wire, much
less to its destination. With any user-datagram-protocol, both ends,
sender and receiver, have to work out what they will do with missing
packets and packets received out-of-order.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


