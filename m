Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289229AbSAVKN1>; Tue, 22 Jan 2002 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289231AbSAVKNT>; Tue, 22 Jan 2002 05:13:19 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:44590 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S289229AbSAVKMb>;
	Tue, 22 Jan 2002 05:12:31 -0500
Date: Tue, 22 Jan 2002 12:09:32 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: lk@behemoth.ts.ray.fi
To: Andreas Dilger <adilger@turbolabs.com>
cc: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
        Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <20020121230249.P4014@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.44.0201221201420.29540-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Andreas Dilger wrote:
> On Jan 21, 2002  16:53 -0500, Chris Mason wrote:
> > On Monday, January 21, 2002 11:41:44 PM +0300 Hans Reiser wrote:
> > > If you think that VM should tell the FS when it has too many pages, does
> > > that mean that the VM understands that a particular page in the subcache
> > > has not been accessed recently enough?  Is that the pivot point of our
> > > disagreement?
> > 
> > Pretty much.  I don't think the VM should say 'you have too many pages', I
> > think it should say 'free this page'.  
> 
> As above, it should have the capability to do both, depending on the
> circumstances.  The FS can obviously make better judgements locally about
> what to write under normal circumstances, so it should be given the best
> chance to do so.
> 
> The VM can make better _specific_ judgements when it needs to (e.g. free
> a DMA page or another specific page to allow a larger contiguous chunk
> of memory to be allocated), but in the cases where it just wants _some_
> page(s) to be freed, it should allow the FS to decide which one(s), if
> it cares.

Which is pretty close to what Anton said. It seems obvious that the VM 
needs to use also a (hopefully rare-case) write_page where FS 
should comply, wether it's suboptimal or not for that particular FS.

But wouldn't Anton's suggestion about having a sperate (hopefully more 
common case) write_some_page that'd give some leash to FS developers to 
optimize their page releasing based on their own demands ?

It'd atleast allow centralized VM and keeping the other filesystems 
intact.

-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */


