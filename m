Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbSKFMpk>; Wed, 6 Nov 2002 07:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbSKFMpj>; Wed, 6 Nov 2002 07:45:39 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:47855 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265015AbSKFMpj>;
	Wed, 6 Nov 2002 07:45:39 -0500
Date: Wed, 6 Nov 2002 23:51:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: 2.5.46 ext3 errors
Message-Id: <20021106235149.0d42dbf5.sfr@canb.auug.org.au>
In-Reply-To: <20021106082658.GD1137@suse.de>
References: <20021106075406.GC1137@suse.de>
	<20021106082658.GD1137@suse.de>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002 09:26:58 +0100 Jens Axboe <axboe@suse.de> wrote:
>
> On Wed, Nov 06 2002, Jens Axboe wrote:
> > Hi,
> > 
> > Doing a kernel compile, the file system suddenly turned read-only.
> > Following messages appeared in log:
> > 
> > EXT3-fs error (device ide1(22,1)): ext3_new_inode: Free inodes count corrupted in group 688 Aborting journal on device ide1(22,1).
> > ext3_new_inode: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide1(22,1)) in ext3_new_inode: Journal has aborted
> > EXT3-fs error (device ide1(22,1)) in ext3_create: Journal has aborted ext3_abort called.
> > EXT3-fs abort (device ide1(22,1)): ext3_journal_start: Detected aborted journal
> > Remounting filesystem read-only
> 
> fsck gave, for that group:
> 
> Free inodes count wrong for group #688 (65534, counted=0)

I got the same error, but on reboot, the journal was played and
then the fsck found no errors.

All I did on that filesystem was
	log in
	make modules_install in a kernel tree
	edit a file in the kernel tree (this file had at least two links)
	make modules - which discovered the files system read only.

After the reboot, the file was as I had changed it, so I lost nothing.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
