Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131616AbRBATAB>; Thu, 1 Feb 2001 14:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131639AbRBAS7v>; Thu, 1 Feb 2001 13:59:51 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:61188 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S131616AbRBAS7i>;
	Thu, 1 Feb 2001 13:59:38 -0500
Date: Thu, 1 Feb 2001 10:59:33 -0800
From: David Gould <dg@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: David Gould <dg@suse.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010201105933.A12074@archimedes.oak.suse.com>
In-Reply-To: <Pine.LNX.4.21.0101310636530.16408-100000@freak.distro.conectiva> <m18znrcxx7.fsf@frodo.biederman.org> <20010131162424.E9053@archimedes.oak.suse.com> <20010201112601.K11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010201112601.K11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 11:26:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 11:26:01AM +0000, Stephen C. Tweedie wrote:
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

Ok. I am convinced. I would have even thought of this myself eventually...

Thanks

-dg
 
-- 
David Gould                                                 dg@suse.com
SuSE, Inc.,  580 2cd St. #210,  Oakland, CA 94607          510.628.3380
You left them alone in a room with a penguin?!  Mr Gates, your men are
already dead.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
