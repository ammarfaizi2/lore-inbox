Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSDVGxd>; Mon, 22 Apr 2002 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314072AbSDVGxc>; Mon, 22 Apr 2002 02:53:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314061AbSDVGxb>;
	Mon, 22 Apr 2002 02:53:31 -0400
Message-ID: <3CC3B372.A219A7AE@zip.com.au>
Date: Sun, 21 Apr 2002 23:53:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: updated writeback patches for 2.5.8
In-Reply-To: <3CC3AD8C.630D4B74@zip.com.au> <20020422074231.A8247@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sun, Apr 21, 2002 at 11:28:28PM -0700, Andrew Morton wrote:
> > Minix and sysvfs are broken - fixing those will happen shortly
> 
> I will do sysvfs - there's a large number of changes pending and it'd
> rather appliy them in the right order..
> 

Thanks.  It looks to be very similar to the ext2 changes.

We also need to not go BUG() if ->prepare_write returns
an error.  It's pretty unlikely - it'd need an IO error
against an indirect which had already been successfully
read and then evicted (I think).  But proper recovery there
would be better.

-
