Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSC2BLw>; Thu, 28 Mar 2002 20:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313331AbSC2BLn>; Thu, 28 Mar 2002 20:11:43 -0500
Received: from girardin.cs.stevens-tech.edu ([155.246.89.39]:38879 "HELO
	girardin.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S313328AbSC2BLd>; Thu, 28 Mar 2002 20:11:33 -0500
Newsgroups: comp.programming,comp.protocols.tcp-ip
Date: Thu, 28 Mar 2002 20:11:27 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
Subject: TCP hashing function
Message-ID: <Pine.NEB.4.33.0203281945150.16010-100000@girardin.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In a transport protocol I'm implementing, I've adapted this TCP hashing
function:

 static __inline__ int dcp_hashfn(__u32 laddr, __u16 lport,
                                  __u32 faddr, __u16 fport)
 {
         int h = ((laddr ^ lport) ^ (faddr ^ fport));
         h ^= h>>16;
         h ^= h>>8;
         /* make it always < size : */
         return h & (MY_HTABLE_SIZE - 1);   /* MY_HT... = 128 */
 }

Although I am treating it as a blackbox and it works fine for me, my
professor pointed the following about this function:
[...]
If both IP addresses have the same upper 16 bits (like 155.246.10.5 and
155.246.120.30), then the 1st 4-way XOR will put 16 bits of zero in h.
Then "h ^= h>>16" will preserve the upper 16 bits as zero.  Then
"h ^= h>>8" will preserve the upper 24 bits!
[...]
Also, he says:
[...]
Having the same class B network number seems like a common case.  In
that case, I don't see much difference between doing the last two
XORs and leaving them out.
[...]

It is indeed true that in mentioned case one will end up with many zeros.
Does it mean this function is in-efficient? Having many sockets linked to
the same hash entry means long lookups... Or is there another reason for
this function being implemented this way?
What are yours opinions?

-marek

