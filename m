Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbRBAMnS>; Thu, 1 Feb 2001 07:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRBAMnI>; Thu, 1 Feb 2001 07:43:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:4102 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129804AbRBAMm7>; Thu, 1 Feb 2001 07:42:59 -0500
Date: Thu, 1 Feb 2001 08:53:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: David Gould <dg@suse.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
In-Reply-To: <20010201112601.K11607@redhat.com>
Message-ID: <Pine.LNX.4.21.0102010824000.17822-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Wed, Jan 31, 2001 at 04:24:24PM -0800, David Gould wrote:
> > 
> > I am skeptical of the argument that we can win by replacing "the least
> > desirable" pages with pages were even less desireable and that we have
> > no recent indication of any need for. It seems possible under heavy swap
> > to discard quite a portion of the useful pages in favor of junk that just
> > happenned to have a lucky disk address.
> 
> When readin clustering was added to 2.2 for swap and paging,
> performance for a lot of VM-intensive tasks more than doubled.  Disk
> seeks are _expensive_.  If you read in 15 neighbouring pages on swapin
> and on average only one of them turns out to be useful, you have still
> halved the number of swapin IOs required.  The performance advantages
> are so enormous that easily compensate for the cost of holding the
> other, unneeded pages in memory for a while.
> 
> Also remember that the readahead pages won't actually get mapped into
> memory, so they can be recycled easily.  So, under swapping you tend
> to find that the extra readin pages are going to be replacing old,
> unneeded readahead pages to some extent, rather than swapping out
> useful pages.

If we're under free memory shortage, "unlucky" readaheads will be harmful.

Currently the swapin readahead code can block waiting for memory to do the
readahead, forcing other pages to be aged/freed more aggressively.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
