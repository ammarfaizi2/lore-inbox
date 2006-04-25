Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWDYMi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWDYMi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDYMi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:38:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44440 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932203AbWDYMi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:38:56 -0400
Date: Tue, 25 Apr 2006 13:38:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
Message-ID: <20060425123847.GA32678@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1145636030.3856.102.camel@quoit.chygwyn.com> <20060423075525.GP6075@schatzie.adilger.int> <1145886796.3856.161.camel@quoit.chygwyn.com> <20060425102628.GA26219@infradead.org> <1145963698.3856.193.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145963698.3856.193.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:14:58PM +0100, Steven Whitehouse wrote:
> Hi,
> 
> On Tue, 2006-04-25 at 11:26 +0100, Christoph Hellwig wrote:
> > On Mon, Apr 24, 2006 at 02:53:16PM +0100, Steven Whitehouse wrote:
> > > > Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
> > > > extents for a while already.  AFAICS, there are no other flags in the
> > > > current e2fsprogs that aren't listed above.
> > > > 
> > > So if I call that one IFLAG_EXTENT, then I presume that will be ok?
> > > What about the 0x00040000 flag? That would seem to be a gap in the
> > > sequence (ignoring GFS flags for now), so should I leave that reserved
> > > for use by ext2/3 as well?
> > 
> > note that at least reiserfs, jfs snd xfs seem to use additional flags aswell.
> > It would be really helpful if we could get a linux/fflags.h that collects all
> > of having them spread all over.  Anyone volunteering to create it?
> > 
> Thats basically what I was proposing with iflags.h, if you think it
> would be better renamed to fflags.h and s/IFLAG/FFLAG/g then I'll do
> that.

oops, I completly missed this was in generic code.  Yeah, this looks good.
We should also add comments to all the per-fs headers that those values
are deprecated and people should look at iflags.h instead.

> Perhaps I should "dig this out" from the GFS2 code and submit it as a
> separate patch.... ?

Yes, that would be good.

> XFS appears to support the immutable, append, no atime, no dump and sync
> flags only, judging by the test in the xfs ioctl code, I don't see any
> extra flags:
> 
> if (flags & ~(LINUX_XFLAG_IMMUTABLE | LINUX_XFLAG_APPEND | \
> 	      LINUX_XFLAG_NOATIME | LINUX_XFLAG_NODUMP | \                
>  	      LINUX_XFLAG_SYNC)) {
>                         error = -EOPNOTSUPP;
>                         break;
>               }

indeed.  I remembered it had more but those were only exposed through xfs-private
interfaces.

