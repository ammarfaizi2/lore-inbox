Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290048AbSAWUgE>; Wed, 23 Jan 2002 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSAWUfz>; Wed, 23 Jan 2002 15:35:55 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:49797 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S290048AbSAWUfp>; Wed, 23 Jan 2002 15:35:45 -0500
Date: Wed, 23 Jan 2002 20:35:00 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Hans Reiser <reiser@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Stephen Tweedie <sct@redhat.com>
Subject: Re: [Ext2-devel] Re: Possible Idea with filesystem buffering.
Message-ID: <20020123203500.L1930@redhat.com>
In-Reply-To: <3C4DB256.172F8D6A@zip.com.au> <Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Jan 22, 2002 at 05:03:02PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2002 at 05:03:02PM -0200, Rik van Riel wrote:
> On Tue, 22 Jan 2002, Andrew Morton wrote:
> > Hans Reiser wrote:
> >
> > Note that writepage() doesn't get used much.  Most VM-initiated
> > filesystem writeback activity is via try_to_release_page(), which
> > has somewhat more vague and flexible semantics.
> 
> We may want to change this though, or at the very least get
> rid of the horrible interplay between ->writepage and
> try_to_release_page() ...

This is actually really important --- writepage on its own cannot
distinguish between requests to flush something to disk (eg. msync or
fsync), and requests to evict dirty data from memory.

This is really important for ext3's data journaling mode --- syncing
to disk only requires flushing as far as the journal, but evicting
dirty pages requires a full writeback too.  That's one place where our
traditional VM notion of writepage just isn't quite fine-grained
enough.

Cheers,
 Stephen
