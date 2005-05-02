Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVEBASY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVEBASY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVEBASY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:18:24 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:10191 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261536AbVEBASQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:18:16 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17013.29103.249971.866326@wombat.chubb.wattle.id.au>
Date: Mon, 2 May 2005 10:17:51 +1000
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Chris Friesen <cfriesen@nortel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       pauld@gelato.unsw.edu.au
Subject: Re: [PATCH] ppc64: update to use the new 4L headers
In-Reply-To: <4270472E.9050708@yahoo.com.au>
References: <1114652039.7112.213.camel@gaston>
	<42704130.9050005@yahoo.com.au>
	<427044AA.5030402@nortel.com>
	<4270472E.9050708@yahoo.com.au>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nick" == Nick Piggin <nickpiggin@yahoo.com.au> writes:

Nick> Chris Friesen wrote:
>> I needed something like:
>> 
>> pte_t *va_to_ptep_map(struct mm_struct *mm, unsigned int addr)
>> 
>> There was code in follow_page() that did basically what I needed,
>> but it was all contained within that function so I had to
>> re-implement it.
>> 

Nick> If you can break out exactly what you need, and make that inline
Nick> or otherwise available via the correct header, I'm sure it would
Nick> have a good chance of being merged.

We're currently working on this, so as to be able to provide
interfaces to alternative page tables.  We want to be able to slot in
Liedtke's `Guarded Page Tables', or B-trees, or a hash table to see
what happens.

Except we've called the function:
       pte_t * lookup_page_table(unsigned long address, struct mm_struct *mm);


follow_page() is essentially the same after inline expansion happens;
but we're seeing a regression in clear_page_range() that we want to
fix before release.

If you want to take a look (warning: it's still fairly rough
work-in-progress) there's high level design being worked on at
http://www.gelato.unsw.edu.au/IA64wiki/PageTableInterface 
and patches from our CVS repository.  The only patch of interst is pti.patch.

cvs -d :pserver:anoncvs@gelato.unsw.edu.au:/gelato login
Logging in to :pserver:anoncvs@lemon:2401/gelato
CVS password:[enter anoncvs]
$ cvs -d:pserver:anoncvs@gelato.unsw.edu.au:/gelato co kernel/page_table_interface

or from

 http://www.gelato.unsw.edu.au/cgi-bin/viewcvs.cgi/cvs/kernel/page_table_interface/

Peter C
