Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWAYIh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWAYIh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWAYIh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:37:27 -0500
Received: from [218.25.172.144] ([218.25.172.144]:58629 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750932AbWAYIh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:37:26 -0500
Date: Wed, 25 Jan 2006 16:37:28 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Block device API
Message-ID: <20060125083728.GA16593@localhost.localdomain>
References: <bda6d13a0601241858g260b915bs5370d34ac90321de@mail.gmail.com> <1e62d1370601241917l4c53cf3fud34835c4dc5c1526@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e62d1370601241917l4c53cf3fud34835c4dc5c1526@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 08:17:02AM +0500, Fawad Lateef wrote:
> On 1/25/06, Joshua Hudson <joshudson@gmail.com> wrote:
> > I am working on a kernel filesystem driver. I have found plenty of
> > documentation on
> > how to communicate between the VFS and the filesystem driver, but nothing
> > on how to communicate between the block device and the filesystem driver.
> >
> 
> AFAIK there isn't any documentation/article for block and filesystem
> layer interaction (or till now me also not able to find any) :)
> 
> > I found sb_bread() but there is no corrisponding sb_bwrite().
> > I presume that if ((struct superblock *)s) -> bdev is the block
> > device handle, but I cannot find the read/write pair of functions.
> > -
> 
> sb_bread is the function used for reading a block (especially
> superblock) from the storage. For reading/writing do look at

Does __bread() contribute to page cache? I think not. And we don't
care the work done by __bread().

> generic_file_read/write functions found in mm/filemap.c and when going
> through the code you will see its ends up in calling
> mappings->a_ops->readpage(s)/writepage(s) of filesystem in which
> normal filesystems (like ext2) just call function
> mpage_readpages/writepages found in fs/mpage.c which performs actual
> read/write on the block device.
-- 
Coywolf Qi Hunt
