Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIQBAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIQBAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIQBAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:00:38 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:64956 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265029AbUIQBAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:00:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16714.14118.212946.499226@wombat.chubb.wattle.id.au>
Date: Fri, 17 Sep 2004 11:00:22 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <260353727@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:


Andrew> All the struct needs is `head', `tail' and
Andrew> `number_of_bytes_at_buf', all unsigned.

Andrew> add(char c) {
Andrew>       p-> buf[p->head++ % p->number_of_bytes_at_buf] = c;
Andrew> }

This depends on how expensive % is.  On IA64, something like this:

     add(char c) {
	     int i = p->head == p->len ? p->head++ : 0;
	     p->buf[i] = c;
     }

is cheaper, as % generates a subroutine call to __modsi3.  It also is
shorter =-- 12 bundles as opposed to 15.
     


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
