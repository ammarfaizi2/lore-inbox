Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCBJ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCBJ6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWCBJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:58:01 -0500
Received: from souterrain.chygwyn.com ([194.39.143.233]:28098 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S932232AbWCBJ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:58:00 -0500
Date: Thu, 2 Mar 2006 10:12:19 +0000
From: Steven Whitehouse <steve@chygwyn.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [0/16]
Message-ID: <20060302101219.GA22243@souterrain.chygwyn.com>
References: <1140792511.6400.707.camel@quoit.chygwyn.com> <20060224213553.GA8817@infradead.org> <440485E7.4090702@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440485E7.4090702@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Organization: ChyGwyn Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 28, 2006 at 12:18:31PM -0500, Phillip Susi wrote:
> I'm a bit confused.  Why exactly is this unacceptable, and what exactly 
> do you propose instead?  Having an entirely separate mount point that is 
> sort of parallel to the main one, but with extra metadata exposed?  So 
> instead of /path/to/foo/.gfs2_admin/metafile you'd prefer having a 
> separate mount point like /proc/fs/gfs/path/to/foo/metafile?
>
I believe that is what Christoph is proposing. It does simplify certain
things, not least preventing someone from moving the .gfs2_admin directory
to somewhere other than the root directory of the filesystem or even
removing it completely which would otherwise need to be added as special
cases.

On the otherhand, its not clear to me at the moment, exactly how to
implement this bearing in mind that both the "normal" filesystem and
the metadata filesystem are really one and the same as far as journaling
and locking are concerned. Perhaps what's needed is one fs with two
different roots. I'm still looking into the best way to do this,

Steve.
 
> 
> Christoph Hellwig wrote:
> >> b) The .gfs2_admin directory exposes the internal files that GFS uses
> >>    to store various bits of file system related information. This means
> >>    that we've been able to remove virtually all the ioctl() calls from
> >>    GFS2. There is one ioctl() call left which relates to
> >>    getting/setting GFS2 specific flags on files. The various GFS2 tools
> >>    will be updated in due course to use this new interface.
> >
> >Without even looking at the code a strong NACK here.  This is polluting
> >the namespace which is not acceptable.  Please implement a second
> >filesystem type gfsmeta to do this kind of admin work.  Search for ext2meta
> >which did something similar.  Or use a completely different approach,
> >I'd need to look at the actual functionality provided to give a better
> >advice, but currently I'm lacking the time for that.
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
