Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUCVObR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCVObR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:31:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:56729 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262008AbUCVObP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:31:15 -0500
Date: Mon, 22 Mar 2004 14:31:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa1
In-Reply-To: <20040322141439.GY3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403221421410.11500-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> On Mon, Mar 22, 2004 at 09:07:54AM -0500, Rik van Riel wrote:
> > 
> > Most people seem to be talking about "pte based rmap" vs
> > "object based rmap".  So far you're the only one who I've
> > seen using "rmap" to mean just "pte based rmap" and not
> > also "object based rmap".
> 
> then I'm the only one and I could have been biased because rmap.c is
> including 99% of code for the pte based rmap, and my objrmap.c is including
> 99% of code for the objrect based _reverse_mappings_, still objrmap.c is
> a more appropriate name for that stuff IMO (especially if somebody else
> is mistaken as I am using the word rmap to mean the current 2.6 code in
> mm/rmap.c).

I agree with Rik and Christoph (I agreed with all of Christoph's points,
but most can be left until later on): mm/rmap.c and include/linux/rmap.h
(the latter a name change from include/linux/rmap-locking.h).

objrmap is the particular implementation found within that file in your
tree, but Rik imagined right from the start that there would be various
implementations:

 * This is kept modular because we may want to experiment
 * with object-based reverse mapping schemes.

(Aaargh, now we can expect someone to propose
CONFIG_PTE_CHAIN_RMAP, CONFIG_ANON_VMA_RMAP, CONFIG_ANONMM_RMAP etc)

Hugh

