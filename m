Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSEPCHL>; Wed, 15 May 2002 22:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSEPCHK>; Wed, 15 May 2002 22:07:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49163 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316541AbSEPCHJ>; Wed, 15 May 2002 22:07:09 -0400
Date: Wed, 15 May 2002 23:06:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020516020134.GC1025@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Andrea Arcangeli wrote:
> On Wed, May 15, 2002 at 07:30:18PM -0300, Rik van Riel wrote:
> > On Wed, 15 May 2002, Andrea Arcangeli wrote:
> >
> > > Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
> > >
> > > 	Make sure to always try mounting with ext3 before ext2 (otherwise
> > > 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> > > 	loaded by an initrd and ext2 is linked into the kernel).
> >
> > Funny, I've been doing this for months.
> >
> > Maybe you should look into pivot_mount(2) and pivot_mount(8)
> > some day ?

> First of all there's no pivot_mount but there's only pivot_root (never
> mind, it is clear you meant pivot_root).
>
> Secondly pivot_root has nothing to do with handle_initrd.
>
> Go read init/do_mounts.c::handle_initrd. There are only two ways:

There's a third way, which is used on the initrd of most
distros:

--- snip from linuxrc ----
mount --ro -t $rootfs $rootdev /sysroot
pivot_root /sysroot /sysroot/initrd
------

This way you can specify both the root fs and - if wanted -
special mount options to the root fs. Then you pivot_root(2)
to move the root fs to / and the (old) initrd to /initrd.

The initscripts then umount /initrd, after which the initrd
data gets freed.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

