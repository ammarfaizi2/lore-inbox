Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946048AbWBOR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946048AbWBOR2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946045AbWBOR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:28:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946044AbWBOR2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:28:52 -0500
Date: Wed, 15 Feb 2006 09:28:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
In-Reply-To: <20060215170935.GE12974@mellanox.co.il>
Message-ID: <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
References: <20060215151649.GA12090@mellanox.co.il>
 <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com>
 <20060215165016.GD12974@mellanox.co.il> <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
 <20060215170935.GE12974@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Feb 2006, Michael S. Tsirkin wrote:
>
> Other numbers look right, dont they?

Suggestion: for each macro name, do

	grep "macroname" patch

and if you see anything that looks even half-way suspicious, check it.

Here's a pipeline from hell which shows that you broke at least 
MADV_REMOVE (which has values 5-9 depending on architecture).

	sed -n '/^[-+].*define[ 	]*/
		{ s/.*define[ 	]*\([A-Za-z_0-9]*\).*/\1/ ; p}'
		patch  |
	sort -u |
	while read i
	do
		echo $i:
		grep "^[-+].*$i" patch
	done |
	less -S

Rule #1: use tools instead of eyeballs whenever you possibly can. Humans 
are bad at noticing changes like this.

		Linus
