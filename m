Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269936AbRHMXvP>; Mon, 13 Aug 2001 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269934AbRHMXvF>; Mon, 13 Aug 2001 19:51:05 -0400
Received: from [216.102.46.130] ([216.102.46.130]:53794 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S269930AbRHMXuz>; Mon, 13 Aug 2001 19:50:55 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Requesting clarification on IPTOS_* values w/regard to RFC-1349
In-Reply-To: <3B7862FD.BBDF0C51@candelatech.com>
From: Roland Dreier <roland@topspincom.com>
Date: 13 Aug 2001 16:50:47 -0700
In-Reply-To: Ben Greear's message of "Mon, 13 Aug 2001 16:30:05 -0700"
Message-ID: <523d6vldt4.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Ben Greear <greearb@candelatech.com> writes:

    Ben> I have a hard time believing that the kernel is wrong on
    Ben> something so basic, but I cannot reconcile RFC-1349 with
    Ben> include/linux/ip.h

    Ben> Here is the snippet from RFC-1349, found here:
    Ben> http://www.cis.ohio-state.edu/cgi-bin/rfc/rfc1349.html

****************************************************************************
3 Specification of the Type of Service Octet

    The TOS facility is one of the features of the Type of Service
    octet in the IP datagram header. The Type of Service
    octet consists of three fields: 

                    0     1     2     3     4     5     6     7
                 +-----+-----+-----+-----+-----+-----+-----+-----+
                 |                 |                       |     |
                 |   PRECEDENCE    |          TOS          | MBZ |
                 |                 |                       |     |
                 +-----+-----+-----+-----+-----+-----+-----+-----+

****************************************************************************


    Ben> However, include/linux/ip.h defines the values as if RFC-1349
    Ben> numbered the bits backwards.  (It appears to me, for example,
    Ben> that the TOS_MASK should be, in binary: 0111 1000, not 0001
    Ben> 1110 as ip.h shows.)

#define IPTOS_TOS_MASK		0x1E

Actually, this is correct.  The RFC shows bits inside an octect in
"network order".  In other words the high-order bit of an octect
appears at the left, just as the high-order octet of a word appears at
the left.  The way I always remember it is that network order writes
bits the way you would write a binary number by hand.

For further confirmation, you can see RFC 1122, which says:

  The "Type-of-Service" byte in the IP header is divided into two
  sections: the Precedence field (high-order 3 bits), and a field that
  is customarily called "Type-of-Service" or "TOS" (low-order 5 bits).
  In this document, all references to "TOS" or the "TOS field" refer
  to the low-order 5 bits only.

Roland


