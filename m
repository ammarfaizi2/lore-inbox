Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280703AbRK1VNe>; Wed, 28 Nov 2001 16:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRK1VN0>; Wed, 28 Nov 2001 16:13:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:8968 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280703AbRK1VNQ>; Wed, 28 Nov 2001 16:13:16 -0500
Message-ID: <3C05533D.98DCE6D1@zip.com.au>
Date: Wed, 28 Nov 2001 13:12:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C03FE2F.63D7ACFD@zip.com.au> <Pine.LNX.4.21.0111281604390.15571-100000@freak.distro.conectiva> <3C054992.48F5C9E7@zip.com.au>,
		<3C054992.48F5C9E7@zip.com.au>; from akpm@zip.com.au on Wed, Nov 28, 2001 at 12:31:14PM -0800 <20011128135611.D856@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 28, 2001  12:31 -0800, Andrew Morton wrote:
> > write-cluster.patch
> >       ext2 metadata prereading and various other hacks which
> >       prevent writes from stumbling over reads, and thus ruining
> >       write clustering.  This patch is in the early prototype stage
> 
> Shouldn't the ext2_inode_preread() code use "ll_rw_block(READ_AHEAD,...)"
> just to be proper?
> 

Yes, especially now the request queues are shorter than they have
historically been.  READA also needs to be propagated through the
pagecache readhead, which may prove tricky.

But so little code is actually using READA at this stage that I didn't
bother - I first need to go through those paths and make sure that they
are in fact complete, working and useful...

-
