Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbTC0JQh>; Thu, 27 Mar 2003 04:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbTC0JQh>; Thu, 27 Mar 2003 04:16:37 -0500
Received: from mail.zmailer.org ([62.240.94.4]:6564 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S261837AbTC0JQg>;
	Thu, 27 Mar 2003 04:16:36 -0500
Date: Thu, 27 Mar 2003 11:27:48 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jordi Ros <jros@xiran.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page size bigger than 4 KB for ext2
Message-ID: <20030327092748.GF29167@mea-ext.zmailer.org>
References: <E3738FB497C72449B0A81AEABE6E713C027904@STXCHG1.simpletech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3738FB497C72449B0A81AEABE6E713C027904@STXCHG1.simpletech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 03:24:23PM -0800, Jordi Ros wrote:
> Hi all,
> 
> I am trying to bring up a hard drive formated to 8KB page size using 
> ext2. It seems that i may need to recompile the kernel, as default 
> PAGE_SIZE is 4KB. I have 2 questions:

  The last time I looked at it, it should not be possible to have EXT2
  filesystem formatted with FILESYSTEM BLOCK SIZE of 8k.  Primary reason
  for this is that i386 machines have page size of 4k, and system has
  been kept limited to that for ease of memory reference handling, and
  to keep filesystems compatible in between machines, lowest limits
  have been taken into use.

  Notable thing is, that in BSD world the UFS (close relative of EXT2)
  can support FILESYSTEM block sizes of at least up to 64k.
  Referring to a bit of data within such blocks is a lot more
  convoluted, than it is in current incarnation of EXT2.

> 1) What is the procedure to build a kernel that can support hard drives 
>    formatted to 8KB ext2?

  You might need changes in block-layer, not (only) in filesystems.
  The PHYSICAL BLOCK SIZE of 8k will need reading and writing the
  disk in that size of chunks, which means in i386 type machines
  two memory pages, preferrably contiguous. Some limits from
  device drivers (like DMA must not go over 64k boundary) might
  also assert themselves.

> 2) What is the procedure to format a hard drive to 8KB ext2?

  Presently it can not be done.

> Thank you so much,
> Jordi

/Matti Aarnio
