Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319046AbSHMVIr>; Tue, 13 Aug 2002 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319064AbSHMVIr>; Tue, 13 Aug 2002 17:08:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319046AbSHMVIr>;
	Tue, 13 Aug 2002 17:08:47 -0400
Message-ID: <3D5975B2.66B4B215@zip.com.au>
Date: Tue, 13 Aug 2002 14:10:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] simplify b_inode usage
References: <20020813171024.A4365@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Current the b_inode of struct buffer_head is a pointer to an inode, but
> it only always used as bool value.  This patch changes it to an simple
> int (yes, I know some people have ideas for a flag that uses less space,
> but that can be easily done ontop of this cleanup).  The advantage is
> that we don't have to pass in the inode into buffer_insert_inode_queue/
> buffer_insert_inode_data_queue and can merge them into a more general
> buffer_insert_list, with inline wrappers around it.  reiserfs can now
> use buffer_insert_list directly and embedd a simple list_head instead
> of a full static inode into it's journal.
> 
> A similar cleanup has already been done in early 2.5, but the b_inode
> flag is completly gone there now.
> 

Current ext3 CVS (ie: 2.4.20 candidate code) is using b_inode
as an inode *.   Stephen has acked a proposal to stop doing that,
but let's double check with him first.

Also, Joe Thornber needs to add another pointer to struct buffer_head
for LVM2 reasons.  If we collapse b_inode into a b_flags bit then
Joe gets his pointer for free (bh stays at 48 bytes on ia32).

So I'd suggest you just go ahead and do it that way.  (I had a patch
for that but seem to have misplaced it).
