Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbULLJdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbULLJdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbULLJdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 04:33:41 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52954 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262057AbULLJdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 04:33:37 -0500
Date: Sun, 12 Dec 2004 09:33:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <41BBF923.6040207@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, Nick Piggin wrote:
> Christoph Lameter wrote:
> > On Thu, 9 Dec 2004, Hugh Dickins wrote:
> 
> >>probably others (harder to think through).  Your 4/7 patch for i386 has
> >>an unused atomic get_64bit function from Nick, I think you'll have to
> >>define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.
> > 
> > That would be a performance issue.
> 
> Problems were pretty trivial to reproduce here with non atomic 64-bit
> loads being cut in half by atomic 64 bit stores. I don't see a way
> around them, unfortunately.

Of course, it'll only be a performance issue in the 64-on-32 cases:
the 64-on-64 and 32-on-32 macro should reduce to exactly the present
"entry = *pte".

I've had the impression that Christoph and SGI have to care a great
deal more about ia64 than the others; and as x86_64 advances, so
i386 PAE grows less important.  Just so long as a get_64bit there
isn't a serious degradation from present behaviour, it's okay.

Oh, hold on, isn't handle_mm_fault's pmd without page_table_lock
similarly racy, in both the 64-on-32 cases, and on architectures
which have a more complex pmd_t (sparc, m68k, h8300)?  Sigh.

Hugh

