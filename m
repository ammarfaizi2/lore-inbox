Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSEURrZ>; Tue, 21 May 2002 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSEURrY>; Tue, 21 May 2002 13:47:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315257AbSEURrY>;
	Tue, 21 May 2002 13:47:24 -0400
Message-ID: <3CEA8917.7A52176C@zip.com.au>
Date: Tue, 21 May 2002 10:51:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffermem_pages removal (5/5)
In-Reply-To: <20020521141015.E15796@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> No more users of buffermem_pages are left, remove it.

Yeah, may as well.

The buffermem_pages accounting is vaguely interesting because
it tells us how much of ZONE_NORMAL is being usefully used for
blockdev pagecache.  And ZONE_NORMAL utilisation is a bit of a
hot topic at present.

But the same information can be obtained on-demand by running
around the bdev superblock's inodes adding up nr_pages.  That
approach is better than the per-page atomic ops in buffer.c.

-
