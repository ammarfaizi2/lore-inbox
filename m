Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUIICJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUIICJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 22:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUIICJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 22:09:59 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:3557 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269329AbUIICJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 22:09:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16703.47979.243728.396215@wombat.chubb.wattle.id.au>
Date: Thu, 9 Sep 2004 12:09:47 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Duncan Sands <baldrick@free.fr>
Cc: Matt Mackall <mpm@selenic.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netpoll endian fixes
In-Reply-To: <77423609@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Duncan" == Duncan Sands <baldrick@free.fr> writes:

Duncan> Hi Matt, I agree that it should be 0x45 everywhere.  After
Duncan> thinking a bit I concluded that the

Duncan> #if defined(__LITTLE_ENDIAN_BITFIELD) 
Duncan>        __u8 ihl:4, version:4;
Duncan> #elif defined (__BIG_ENDIAN_BITFIELD) 
Duncan>        __u8 version:4, ihl:4;

Duncan> in the definition of struct iphdr is to make sure that
Duncan> compiler uses the first four bits of the byte to refer to
Duncan> version, rather than the last four; and this only matters when
Duncan> you are accessing the nibbles via the ihl or version structure
Duncan> fields.  Thus it makes sure that if you write 0x45 to the
Duncan> byte, then version will return 4 and ihl will return 5.
Duncan> Presumably the C standard specifies how bitfield expressions
Duncan> should be laid out in the byte, and ihl:4, version:4; gives
Duncan> opposite results on little-endian and big-endian machines...

Actually, the C standard

	  -- leaves unspecified whether bitfields start at the low or
	  high address of the word they're in, and

	  -- states that the type of a bitfield may be ignored (except
	  for signed/unsigned), and that the size of the object
	  containing a bitfield is the same as the size of an int.

It's a GCC extension that allows 
     __u8 ihl:4;
to allocate only 8 bits and use four of them; GCC still assumes
integer alignment for the whole bitfield block.  Other compilers could
allocate 32 bits.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
