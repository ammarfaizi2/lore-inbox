Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEOQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEOQiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVEOQiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:38:05 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:6406 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261695AbVEOQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:37:58 -0400
Date: Sun, 15 May 2005 18:43:07 +0200
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 optimal partition size
Message-ID: <20050515164307.GB26197@hh.idb.hist.no>
References: <20050515160037.GE134@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050515160037.GE134@DervishD>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 06:00:37PM +0200, DervishD wrote:
>     Hi all :)
> 
>     Let's assume I want to partition a hard disk so the partition
> size is optimal for a given block size and bytes per inode ratio in
> an ext2/ext3 filesystem. By 'optimal' I mean that no space in the
> partition is wasted, that is, the metadata and the data blocks fit
> perfectly in the partition, and no space is left unused because that
> space is less than a data block.
> 
>     For example, if disk structures occupy 1024 bytes and each data
> block is 1024 bytes too, the partition size must be a multiple of
> 1024: if I allocate 2049 bytes for the partition, then one byte will
> be lost because ext2/3 cannot have blocks smaller than the block
> size.
> 
>     So: which is the optimal partition size for a given block size
> and a given bytes per inode ratio? Can it be easily calculated?
> 

You can't allocate 2049 bytes for a partition - it is always a
whole number of 512-byte blocks.

ext2/ext3 uses either 1024-byte b�locks or 4096-byte blocks.
(well, you may be able to use 2048-byte blocks, or
8192-byte blocks on systems with 8k pages, but thats another issue.)

Just make sure your partition is a whole number of blocks, ext2/ext3 should
then be able to utilize the partition fully to the last block.

Using a blocksize equal to the pagesize (i.e. 4096) is usually optimal.
1024-byte blocks may be useful if your filesystem is dominated
by files smaller than 2K, otherwise don't bother.

So make sure your partition consist of an integral number of 4k blocks,
it will then be perfect.

Helge Hafting

