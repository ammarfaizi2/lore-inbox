Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUBYKTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUBYKTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:19:07 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:65214 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261190AbUBYKTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:19:05 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16444.30315.59303.753417@wombat.chubb.wattle.id.au>
Date: Wed, 25 Feb 2004 21:18:19 +1100
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
In-Reply-To: <20040225005804.GE18070@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com>
	<20040223225659.4c58c880.akpm@osdl.org>
	<403B8C78.2020606@colorfullife.com>
	<20040225005804.GE18070@cse.unsw.EDU.AU>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Darren" == Darren Williams <dsw@gelato.unsw.edu.au> writes:

Darren> Hi Manfred I have updated to the latest bk and new output can
Darren> be found at:
Darren> http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
Darren> kern-log-bk

Intersting.  Offset 0x620 is well off the end of the struct skb, which
is only 256 bytes big (I think), yet the object that's having problems
is a 2k object.

Darren> I took a look at alloc_skb(..) and there is a reference to an
Darren> atomic_t token with this being the most suspect

150> atomic_set(&(skb_shinfo(skb)->dataref), 1);

No, the skb_shinfo is off in kmalloced space, not part of the slab.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
