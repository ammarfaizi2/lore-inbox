Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154410-19607>; Sat, 23 Jan 1999 10:07:21 -0500
Received: by vger.rutgers.edu id <154007-19608>; Sat, 23 Jan 1999 10:07:11 -0500
Received: from noc.nyx.net ([206.124.29.3]:2930 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <154582-19608>; Sat, 23 Jan 1999 10:05:59 -0500
Date: Sat, 23 Jan 1999 08:12:29 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199901231512.IAA03481@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sat Jan 23 08:12:29 1999, Sender=colin, Recipient=, Valsender=colin@localhost
To: alan@packetengines.com
Subject: Re: Random number generator for skiplists
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Skip lists are a handy data structure, but the fact that the nodes
are variable-sized is something of an implementation hassle.

An RNG for the purpose is not hard to concoct; George Marsaglia
recently posted some good building blocks to a few relevant newsgroups
(sci.stat.math,sci.math,sci.math.num-analysis,sci.crypt,sci.physics).

Here's his KISS (keep it simple, stupid) generator.
All variables are 32-bit quantities.  You can use any of the
three sub-generators as well.

static unsigned z=362436069, w=521288629, jsr=123456789, jcong=380116160;
/* Any non-zero seeds will do */
#define znew  ((z=36969*(z&65535)+(z>>16))<<16)
#define wnew  ((w=18000*(w&65535)+(w>>16))&65535)
#define MWC   (znew+wnew)
#define SHR3  (jsr ^= jsr<<17, jsr ^= jsr>>13, jsr ^= jsr<<5)
#define CONG  (jcong=69069*jcong+1234567)
#define KISS  ((MWC^CONG)+SHR3)

He also has some longer-period table-driven generators.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
