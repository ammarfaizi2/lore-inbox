Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSG1SCY>; Sun, 28 Jul 2002 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSG1SCY>; Sun, 28 Jul 2002 14:02:24 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:12037 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316994AbSG1SCY>; Sun, 28 Jul 2002 14:02:24 -0400
Date: Sun, 28 Jul 2002 19:05:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
Message-ID: <20020728190544.A14314@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D439E43.5F2DEE3D@zip.com.au> <20020728120611.A7332@infradead.org> <3D44302C.1082D6DC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D44302C.1082D6DC@zip.com.au>; from akpm@zip.com.au on Sun, Jul 28, 2002 at 10:55:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 10:55:56AM -0700, Andrew Morton wrote:
> > I think I prefer option 3, it's the cleanest way of doing it.
> 
> It could be time to separate out a __generic_file_write() which
> doesn't take i_sem at all.  The ext3 tree was doing that for a
> while, to permit multipage transactions in journalled data mode.

In fact we we already have that already in the XFS tree (Steve called it
do_generic_file_write although I'd really prefer __generic_file_write).

> > A little unrelated, but as you touch the code:  what about removing the two
> > existing special cases for S_ISBLK() in generic_file_write()?  they're
> > present only to provide the old (pre-LFS) blockdevice semantics on 2.4,
> > we shouldn't keept them around forever..
> 
> hm.  Are you sure about that?  They look fairly useful to me?

The O_APPEND special casing is certainly very, very ugly - application
should use it on block devices at all - if they're screwed when doing it
anyway it's their problem.

And I think we can expect reasonable ulimits for root nowdays, although
I'm open for discussions on that one.

