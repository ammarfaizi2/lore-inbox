Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVAVB0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVAVB0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVAVB0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:26:02 -0500
Received: from ozlabs.org ([203.10.76.45]:7147 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262358AbVAVBZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:25:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.43936.632734.780383@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 12:25:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, davem@davemloft.net, hugh@veritas.com,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <20050121164353.6f205fbc.akpm@osdl.org>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
	<16881.33367.660452.55933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0501211545080.27045@schroedinger.engr.sgi.com>
	<16881.40893.35593.458777@cargo.ozlabs.ibm.com>
	<20050121164353.6f205fbc.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> It is, actually, from the POV of the page allocator.  It's a "higher order
> page" and is controlled by a struct page*, just like a zero-order page...

So why is the function that gets me one of these "higher order pages"
called "get_free_pages" with an "s"? :)

Christoph's patch is bigger than it needs to be because he has to
change all the occurrences of clear_page(x) to clear_page(x, 0), and
then he has to change a lot of architectures' clear_page functions to
be called _clear_page instead.  If he picked a different name for the
"clear a higher order page" function it would end up being less
invasive as well as less confusing.

The argument that clear_page is called that because it clears a higher
order page won't wash; all the clear_page implementations in his patch
are perfectly capable of clearing any contiguous set of 2^order pages
(oops, I mean "zero-order pages"), not just a "higher order page".

Paul.
