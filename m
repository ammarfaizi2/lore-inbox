Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbRBAL26>; Thu, 1 Feb 2001 06:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbRBAL2w>; Thu, 1 Feb 2001 06:28:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:17368 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129080AbRBAL2l>;
	Thu, 1 Feb 2001 06:28:41 -0500
Date: Thu, 1 Feb 2001 11:26:01 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Gould <dg@suse.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010201112601.K11607@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101310636530.16408-100000@freak.distro.conectiva> <m18znrcxx7.fsf@frodo.biederman.org> <20010131162424.E9053@archimedes.oak.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010131162424.E9053@archimedes.oak.suse.com>; from dg@suse.com on Wed, Jan 31, 2001 at 04:24:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 31, 2001 at 04:24:24PM -0800, David Gould wrote:
> 
> I am skeptical of the argument that we can win by replacing "the least
> desirable" pages with pages were even less desireable and that we have
> no recent indication of any need for. It seems possible under heavy swap
> to discard quite a portion of the useful pages in favor of junk that just
> happenned to have a lucky disk address.

When readin clustering was added to 2.2 for swap and paging,
performance for a lot of VM-intensive tasks more than doubled.  Disk
seeks are _expensive_.  If you read in 15 neighbouring pages on swapin
and on average only one of them turns out to be useful, you have still
halved the number of swapin IOs required.  The performance advantages
are so enormous that easily compensate for the cost of holding the
other, unneeded pages in memory for a while.

Also remember that the readahead pages won't actually get mapped into
memory, so they can be recycled easily.  So, under swapping you tend
to find that the extra readin pages are going to be replacing old,
unneeded readahead pages to some extent, rather than swapping out
useful pages.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
