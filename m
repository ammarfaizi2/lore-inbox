Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTIHJog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTIHJog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:44:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22927 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262234AbTIHJob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:44:31 -0400
Date: Mon, 8 Sep 2003 10:44:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030908094413.GB25176@mail.jlokier.co.uk>
References: <20030907132010.GB19977@mail.jlokier.co.uk> <20030908020812.4EC372C609@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908020812.4EC372C609@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <20030907132010.GB19977@mail.jlokier.co.uk> you write:
> > I don't see a problem, as long as it is documented.  Anybody grokking
> > the old futex code would expect futexes to move with mappings.
> 
> BTW, I don't know of anyone *doing* this, but IMHO it's not worth a
> single line of kernel code, since if you don't adjust your futex
> addresses when you mremap, the try_down_futex will segv after the poll
> or whatever.  As a programmer, I would *expect* to have to reset the
> futexes (along with every other pointer into the map) when mremap
> happens: after all, I told the kernel to watch the old address.  If it
> still works, great, but I'd not expect it.

Sure.  As long as it's documented, because my expectation is the
opposite of yours :)

(Some uses of futex don't read the memory after they are woken, until
they have re-tested some other condition and can recalculate the
address, so segv and pointers-into-the-map don't occur in these uses).

-- Jamie
