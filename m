Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbREOVxs>; Tue, 15 May 2001 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbREOVxj>; Tue, 15 May 2001 17:53:39 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:55012 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261611AbREOVxN>; Tue, 15 May 2001 17:53:13 -0400
Date: Tue, 15 May 2001 17:53:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
Message-ID: <20010515175302.B5508@cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3B018EF3.F9DF7207@transmeta.com> <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu> <9ds5h5$2i6$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <9ds5h5$2i6$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 02:02:29PM -0700
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 02:02:29PM -0700, Linus Torvalds wrote:
> In article <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu>,
> Alexander Viro  <viro@math.psu.edu> wrote:
> >On Tue, 15 May 2001, H. Peter Anvin wrote:
> >
> >> Alexander Viro wrote:
> >> > >
> >> > > None whatsoever.  The one thing that matters is that noone starts making
> >> > > the assumption that mapping->host->i_mapping == mapping.

Don't worry too much about that, that relationship has been false for
Coda ever since i_mapping was introduced.

The only problem that is still lingering is related to i_size. Writes
update inode->i_mapping->host->i_size, and stat reads inode->i_size,
which are not the same.

I sent a small patch to stat.c for this a long time ago (Linux
2.3.99-pre6-7), which made the assumption in stat that i_mapping->host
was an inode. (effectively tmp.st_size = inode->i_mapping->host->i_size)

Other solutions were to finish the getattr implementation, or keep a
small Coda-specific wrapper for generic_file_write around.

> >> > One actually shouldn't assume that mapping->host is an inode.
> >> 
> >> What else could it be, since it's a "struct inode *"?  NULL?
> >
> >struct block_device *, for one thing. We'll have to do that as soon
> >as we do block devices in pagecache.
> 
> No, Al. It's an inode. It was a major mistake to ever think anything
> else.

So is anyone interested in a small patch for stat.c? It fixes, as far as
I know, the last place that 'assumes' that inode->i_mapping->host is
identical to &inode.

Jan

