Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290083AbSAWVDb>; Wed, 23 Jan 2002 16:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSAWVDT>; Wed, 23 Jan 2002 16:03:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39693 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290084AbSAWVDD>; Wed, 23 Jan 2002 16:03:03 -0500
Message-ID: <3C4F2340.57E597DF@zip.com.au>
Date: Wed, 23 Jan 2002 12:55:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Rik van Riel <riel@conectiva.com.br>, Hans Reiser <reiser@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DB256.172F8D6A@zip.com.au> <Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com>,
		<Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Jan 22, 2002 at 05:03:02PM -0200 <20020123203500.L1930@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Tue, Jan 22, 2002 at 05:03:02PM -0200, Rik van Riel wrote:
> > On Tue, 22 Jan 2002, Andrew Morton wrote:
> > > Hans Reiser wrote:
> > >
> > > Note that writepage() doesn't get used much.  Most VM-initiated
> > > filesystem writeback activity is via try_to_release_page(), which
> > > has somewhat more vague and flexible semantics.
> >
> > We may want to change this though, or at the very least get
> > rid of the horrible interplay between ->writepage and
> > try_to_release_page() ...
> 
> This is actually really important --- writepage on its own cannot
> distinguish between requests to flush something to disk (eg. msync or
> fsync), and requests to evict dirty data from memory.
> 
> This is really important for ext3's data journaling mode --- syncing
> to disk only requires flushing as far as the journal, but evicting
> dirty pages requires a full writeback too.  That's one place where our
> traditional VM notion of writepage just isn't quite fine-grained
> enough.

And we use currently use PF_MEMALLOC to work out which context
we're being called from.  Sigh.

I wish I'd taken better notes of all the square pegs which
ext3 had to push into the kernel's round holes.  But there
were so many :)

-
