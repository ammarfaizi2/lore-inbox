Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTCEWoS>; Wed, 5 Mar 2003 17:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTCEWoS>; Wed, 5 Mar 2003 17:44:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28649 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266473AbTCEWoR>; Wed, 5 Mar 2003 17:44:17 -0500
Date: Wed, 5 Mar 2003 23:54:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: davem@redhat.com, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Chaotic structure of the net headers?
Message-ID: <20030305225441.GO20423@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if all I'm describing is completely logical and I'm only too dumb to see 
the logic please forgive me.  ;-)

In 2.5.64 there are networking headers both under include/linux/ and 
include/net/. I don't understand whether there's a deeper logic why e.g. 
the netfilter headers are under include/linux/.

There's some duplication, e.g. include/linux/in6.h contains

<--   snip  -->

/*
 *      IPV6 extension headers
 */
#define IPPROTO_HOPOPTS         0       /* IPv6 hop-by-hop options      */
#define IPPROTO_ROUTING         43      /* IPv6 routing header          */
#define IPPROTO_FRAGMENT        44      /* IPv6 fragmentation header    */
#define IPPROTO_ICMPV6          58      /* ICMPv6                       */
#define IPPROTO_NONE            59      /* IPv6 no next header          */
#define IPPROTO_DSTOPTS         60      /* IPv6 destination options     */

<--  snip  -->

and include/net/ipv6.h contains:

<--  snip  -->

/*
 *      NextHeader field of IPv6 header
 */

#define NEXTHDR_HOP             0       /* Hop-by-hop option header. */
#define NEXTHDR_TCP             6       /* TCP segment. */
#define NEXTHDR_UDP             17      /* UDP message. */
#define NEXTHDR_IPV6            41      /* IPv6 in IPv6 */
#define NEXTHDR_ROUTING         43      /* Routing header. */
#define NEXTHDR_FRAGMENT        44      /* Fragmentation/reassembly header. */
#define NEXTHDR_ESP             50      /* Encapsulating security payload. */
#define NEXTHDR_AUTH            51      /* Authentication header. */
#define NEXTHDR_ICMP            58      /* ICMP for IPv6. */
#define NEXTHDR_NONE            59      /* No next header */
#define NEXTHDR_DEST            60      /* Destination options header. */

<--  snip  -->

Two different #define's for the same thing doesn't sound like a good 
idea?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

