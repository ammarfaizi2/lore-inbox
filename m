Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUCMSNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUCMSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:13:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22538
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263152AbUCMSNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:13:08 -0500
Date: Sat, 13 Mar 2004 19:13:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
Message-ID: <20040313181352.GN30940@dualathlon.random>
References: <20040313173348.GI30940@dualathlon.random> <Pine.LNX.4.44.0403131743140.3635-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403131743140.3635-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 05:53:36PM +0000, Hugh Dickins wrote:
> On Sat, 13 Mar 2004, Andrea Arcangeli wrote:
> > 
> > I certainly agree it's simpler. I'm quite undecided if to giveup on the
> > anon_vma and to use anonmm plus your unshared during mremap at the
> > moment, while it's simpler it's also a definitely inferior solution
> 
> I think you should persist with anon_vma and I should resurrect
> anonmm, and let others decide between those two and pte_chains.
> 
> But while in this trial phase, can we both do it in such a way as to
> avoid too much trivial change all over the tree?  For example, I'm
> thinking I need to junk my irrelevant renaming of put_dirty_page to
> put_stack_page, and for the moment it would help if you cut out your
> mapping -> as.mapping changes (when I came to build yours, I had to
> go through various filesystems I had in my config updating them
> accordingly).  It's a correct change (which I was too lazy to do,
> used evil casting instead) but better left as a tidyup for later?

yes, we should split in two patches, one is the "peparation" for a
reused page->as.mapping, you know I did it differently to retain the
swapper_space and avoiding to hook explicit "if (PageSwapCache)" checks
into things like sync_page.

About using the union, I still prefer it, I've seen Linus in the
pseudocode used an explicit cast too, but I don't feel safe with
explicit casts, I prefer more breakage, than risking to forget
converting any page->mapping into page_maping or similar issues with the
casts ;)

I'll return working on this after the weekend. You can find my latest
status on the ftp, if you extract any interesting "common" bit from
there just send it to me too. thanks.
