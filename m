Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTICOj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTICOj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:39:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57227 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263108AbTICOir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:38:47 -0400
Date: Wed, 3 Sep 2003 15:38:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030903143810.GB21530@mail.jlokier.co.uk>
References: <20030903073628.GA19920@mail.jlokier.co.uk> <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> Will it be worth the code added to handle it?  I wonder the same of
> non-linear (sys_mremap and sys_remap_file_pages, familiar troublemakers).
> But all credit for handling them, good to reduce "undefined behaviour"s.

I dismissed remap_file_pages the same as you at first, but since
Andrew mentioned it, I think it's a fair point.  As long as it's
there, programmers should get the natural behaviour from it.

Databases (tdb I think) use futexes in database files, and
remap_file_pages is used to look at different views of database files,
and for huge files, so...  It seems reasonable.  That's quite an easy
bit of code anyway.  The futexes nicely stay persistent even when
their particular offset into the file isn't mapped.

mremap() is used for moving anonymous data structures around mainly.
Applications don't really need to depend on the futexes moving in
that, but it is what the current implementation does so they might
exist by now.  The code for this is less defensible as it is more
complicated.

-- Jamie

