Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbTC0JXY>; Thu, 27 Mar 2003 04:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbTC0JXY>; Thu, 27 Mar 2003 04:23:24 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:64198 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S261831AbTC0JXX>; Thu, 27 Mar 2003 04:23:23 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Jordi Ros <jros@xiran.com>, linux-kernel@vger.kernel.org
Date: Thu, 27 Mar 2003 01:32:03 -0800 (PST)
Subject: Re: page size bigger than 4 KB for ext2
In-Reply-To: <20030327092748.GF29167@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0303270128240.24784-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the past I have attempted to format ext2 filesystems with larger the 4K
blocksizes on x86 systems, I had no problem doing so except that I could
not use the resulting filesystem as my root.  I didn't test it very
extensivly before shrugging and going with 4K blocksizes, but the process
of building systems didn't spot any problems with it. they never went into
production this way so I can't comment on long term stability either (on
those systems I was only useing a single partition so since I couldn't
boot to it I just reformatted it)

David Lang


 On Thu, 27 Mar 2003, Matti Aarnio wrote:

> Date: Thu, 27 Mar 2003 11:27:48 +0200
> From: Matti Aarnio <matti.aarnio@zmailer.org>
> To: Jordi Ros <jros@xiran.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: page size bigger than 4 KB for ext2
>
> On Wed, Mar 26, 2003 at 03:24:23PM -0800, Jordi Ros wrote:
> > Hi all,
> >
> > I am trying to bring up a hard drive formated to 8KB page size using
> > ext2. It seems that i may need to recompile the kernel, as default
> > PAGE_SIZE is 4KB. I have 2 questions:
>
>   The last time I looked at it, it should not be possible to have EXT2
>   filesystem formatted with FILESYSTEM BLOCK SIZE of 8k.  Primary reason
>   for this is that i386 machines have page size of 4k, and system has
>   been kept limited to that for ease of memory reference handling, and
>   to keep filesystems compatible in between machines, lowest limits
>   have been taken into use.
>
>   Notable thing is, that in BSD world the UFS (close relative of EXT2)
>   can support FILESYSTEM block sizes of at least up to 64k.
>   Referring to a bit of data within such blocks is a lot more
>   convoluted, than it is in current incarnation of EXT2.
>
> > 1) What is the procedure to build a kernel that can support hard drives
> >    formatted to 8KB ext2?
>
>   You might need changes in block-layer, not (only) in filesystems.
>   The PHYSICAL BLOCK SIZE of 8k will need reading and writing the
>   disk in that size of chunks, which means in i386 type machines
>   two memory pages, preferrably contiguous. Some limits from
>   device drivers (like DMA must not go over 64k boundary) might
>   also assert themselves.
>
> > 2) What is the procedure to format a hard drive to 8KB ext2?
>
>   Presently it can not be done.
>
> > Thank you so much,
> > Jordi
>
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
