Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRHMX2l>; Mon, 13 Aug 2001 19:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269928AbRHMX2c>; Mon, 13 Aug 2001 19:28:32 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:8864 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269926AbRHMX2Z>;
	Mon, 13 Aug 2001 19:28:25 -0400
Message-ID: <3B7862FD.BBDF0C51@candelatech.com>
Date: Mon, 13 Aug 2001 16:30:05 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Requesting clarification on IPTOS_* values w/regard to RFC-1349
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a hard time believing that the kernel is wrong
on something so basic, but I cannot reconcile RFC-1349
with include/linux/ip.h

Here is the snippet from RFC-1349, found here:
http://www.cis.ohio-state.edu/cgi-bin/rfc/rfc1349.html

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

    The first field, labeled "PRECEDENCE" above, is intended to denote the
    importance or priority of the datagram. This
    field is not discussed in detail in this memo. 
****************************************************************************


However, include/linux/ip.h defines the values as if RFC-1349 numbered
the bits backwards.  (It appears to me, for example, that the TOS_MASK
should be, in binary: 0111 1000, not 0001 1110 as ip.h shows.)

*************************************************
/* SOL_IP socket options */

#define IPTOS_TOS_MASK		0x1E
#define IPTOS_TOS(tos)		((tos)&IPTOS_TOS_MASK)
#define	IPTOS_LOWDELAY		0x10
#define	IPTOS_THROUGHPUT	0x08
#define	IPTOS_RELIABILITY	0x04
#define	IPTOS_MINCOST		0x02
*************************************************


Am I even more confused than normal, or is this really a problem?


Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
