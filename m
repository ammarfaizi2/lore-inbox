Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315154AbSENC6x>; Mon, 13 May 2002 22:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315137AbSENC6w>; Mon, 13 May 2002 22:58:52 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:5615 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315133AbSENC6v>; Mon, 13 May 2002 22:58:51 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15584.32089.872754.245023@wombat.chubb.wattle.id.au>
Date: Tue, 14 May 2002 12:58:33 +1000
To: Andrew Morton <akpm@zip.com.au>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <3CE071F7.347C78B5@zip.com.au>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> Peter Chubb wrote:
>> ...
Christoph> - why is the get_block block argument a sector_t?  It
Christoph> presents a logical filesystem block which usually is larger
Christoph> than the sector, not to mention that for the usual
Christoph> blocksize == PAGE_SIZE case a ulong is enough as that is
Christoph> the same size the pagecache limit triggers.
>> For filesystems that *can* handle logical filesystem blocks beyond
>> the 2^32 limit (i.e., that use >32bit offsets in their on-disc
>> format), the get_block() argument has to be > 32bits long.  At the
>> moment that's only JFS and XFS, but reiserfs version 4 looks as if
>> it might go that way.  We'll need this especially when the
>> pagecache limit is gone.

Andrew> I think Christoph's point is that a pagecache index is not a
Andrew> sector number.  We agree that we need to plan for taking it to
Andrew> 64 bits, but it should be something different. Like
Andrew> pageindex_t, or whatever.


I'll let Christoph speak for himself, but my point is that
get_block() is an interface exported from the filesystem.  It should
be possible to specify any logical block number that the filesystem
supports.   That the current VM system on 32-bit machines will never
request a block beyond 2^32 is a (one-day-soon-to-be-removed) current
limitation. 

Peter C
