Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbUKTB6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUKTB6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUKTB6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:58:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:14215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262743AbUKTB5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:57:14 -0500
Date: Fri, 19 Nov 2004 17:56:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <419E98E7.1080402@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0411191753130.2222@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <419E98E7.1080402@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, Nick Piggin wrote:
> 
> The per thread rss may wrap (maybe not 64-bit counters), but even so,
> the summation over all threads should still end up being correct I
> think.

Yes. As long as the total rss fits in an int, it doesn't matter if any of
them wrap. Addition is still associative in twos-complement arithmetic 
even in the presense of overflows. 

If you actually want to make it proper standard C, I guess you'd have to 
make the thing unsigned, which gives you the mod-2**n guarantees even if 
somebody were to ever make a non-twos-complement machine.

		Linus
