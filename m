Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSEUS2s>; Tue, 21 May 2002 14:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEUS2r>; Tue, 21 May 2002 14:28:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315414AbSEUS2r>;
	Tue, 21 May 2002 14:28:47 -0400
Message-ID: <3CEA9193.10F45174@zip.com.au>
Date: Tue, 21 May 2002 11:27:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffermem_pages removal (5/5)
In-Reply-To: <20020521141015.E15796@infradead.org> <3CEA8917.7A52176C@zip.com.au> <20020521185340.A694@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, May 21, 2002 at 10:51:19AM -0700, Andrew Morton wrote:
> > The buffermem_pages accounting is vaguely interesting because
> > it tells us how much of ZONE_NORMAL is being usefully used for
> > blockdev pagecache.  And ZONE_NORMAL utilisation is a bit of a
> > hot topic at present.
> 
> Yho sais all blockdev mapping have to stay ZONE_NORMAL?

Three trillion filesystems for which we don't have a mkfs which
access bh->b_data all over the place :(

>  If filesystems
> access them without buffer_heads there is no reason to not put the
> pages in high memory. 

They'd create a separate address_space in that case.  The blockdev
mappings are pretty unambiguously tied to ZONE_NORMAL in bdget().

> I also remember vaguely that you intend to move
> buffer_heads to high memory in the longer term..

s/buffer_heads/blockdev pages/

Yes, vaguely.  Haven't thought about it a lot.  I suspect the
present kmap() infrastructure would collapse under the load,
so surgery there would be needed first.
 
> > But the same information can be obtained on-demand by running
> > around the bdev superblock's inodes adding up nr_pages.  That
> > approach is better than the per-page atomic ops in buffer.c.
> 
> *nod*

In which case one could trivially report the number of active pages
against all superblocks.  Let's park this one until a need
is demonstrated though...

-
