Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTIERyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbTIERyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:54:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43149 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265911AbTIERyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:54:03 -0400
Date: Fri, 5 Sep 2003 18:53:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Unpinned futexes v2 - part 1: indexing changes
Message-ID: <20030905175324.GA4588@mail.jlokier.co.uk>
References: <20030905045738.GA2197@mail.jlokier.co.uk> <Pine.LNX.4.44.0309050800410.25313-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309050800410.25313-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > (The next patch in this series fixes mremap()).
> 
> I don't think this one is worth it. If the user unmaps or changes the 
> mapping from under the futex, I just think that is "user error". And the 
> same way it is totally undefined what happens if one thread re-organizes 
> the VM space while another thread may be doing some other operation 
> (read() or similar), we just don't care. 

I agree for synchronous futexes, the inherent race conditions do
make it "user error".

For async futexes (FUTEX_FD), I think it has a well-defined and
potentially useful meaning to move futexes on remapping, if that's
what the program wants to do.

It's well-defined for shared mappings, and then it's even useful
(think database with locks distributed in an 8GB file).  So it's a
little odd for it to fail for private mappings.

I'm not wedded to the idea.  Just so long as it's mentioned in "man
futex" under "don't do this".

-- Jamie
