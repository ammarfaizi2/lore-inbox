Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUADXpr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUADXpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:45:47 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:45252 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265804AbUADXpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:45:39 -0500
Date: Sun, 4 Jan 2004 15:45:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ornati@lycos.it, gandalf@wlug.westbo.se, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Buffer and Page cache coherent? was: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040104234523.GX1882@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, ornati@lycos.it,
	gandalf@wlug.westbo.se, linuxram@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <20040102213228.GH1882@matchmail.com> <1073082842.824.5.camel@tux.rsn.bth.se> <200401031213.01353.ornati@lycos.it> <20040103144003.07cc10d9.akpm@osdl.org> <20040104171545.GR1882@matchmail.com> <20040104141030.02fbcce5.akpm@osdl.org> <20040104232231.GV1882@matchmail.com> <20040104153258.0408a197.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104153258.0408a197.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 03:32:58PM -0800, Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > On Sun, Jan 04, 2004 at 02:10:30PM -0800, Andrew Morton wrote:
> > > Mike Fedyk <mfedyk@matchmail.com> wrote:
> > > >
> > > > On Sat, Jan 03, 2004 at 02:40:03PM -0800, Andrew Morton wrote:
> > > > > No effort was made to optimise buffered blockdev reads because it is not
> > > > > very important and my main interest was in data coherency and filesystem
> > > > > metadata consistency.
> > > > 
> > > > Does that mean that blockdev reads will populate the pagecache in 2.6?
> > > 
> > > They have since 2.4.10.  The pagecache is the only cacheing entity for file
> > > (and blockdev) data.
> > 
> > There was a large thread after 2.4.10 was released about speeding up the
> > boot proces by reading the underlying blockdev of the root partition in
> > block order.
> > 
> > Unfortunately at the time reading the files through the pagecache would
> > cause a second read of the data even if it was already buffered.  I don't
> > remember the exact details.
> 
> The pagecache is a cache-per-inode.  So the cache for a regular file is not
> coherent with the cache for /dev/hda1 is not coherent with the cache for
> /dev/hda.

That's what I remember from the old thread.  Thanks.

Duffers are attached to a page, and blockdev reads will not save
pagecache reads.

So in what way is the buffer cache coherent with the pagecache?

> > Are you saying this is now resolved?  And the above optimization will work?
> 
> It will not.  And I doubt if it will make much difference anyway.  I once
> wrote a gizmo which a) generated tables describing pagecache contents
> immediately after bootup and b) used that info to prepopulate pagecache
> with an optimised seek pattern after boot.  It was only worth 10-15%.  One
> would need an intermediate step which relaid-out the relevant files to get
> useful speedups.

Any progress on that pagecache coherent block relocation patch you had for
ext3? :)
