Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266358AbSKGEGx>; Wed, 6 Nov 2002 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSKGEGx>; Wed, 6 Nov 2002 23:06:53 -0500
Received: from thunk.org ([140.239.227.29]:14499 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266358AbSKGEGs>;
	Wed, 6 Nov 2002 23:06:48 -0500
Date: Wed, 6 Nov 2002 23:13:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2 corruption -- After running 2.5.46, my root partition cannot be mounted by older kernels
Message-ID: <20021107041325.GB11010@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miles Lane <miles.lane@attbi.com>, linux-kernel@vger.kernel.org
References: <3DC9D145.6040109@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC9D145.6040109@attbi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 06:34:45PM -0800, Miles Lane wrote:
>
> I am not sure how to diagnose the problem.  When I try to boot
> the latest RH 8.0 kernel, I am informed that some unsupported
> extensions are present on /dev/hda12 at boot time.  The partition
> fails to mount and the boot process halts.
> 
> I have no trouble booting with 2.5.46.

Send the output of dumpe2fs -h to be sure, but it's almost certainly
one of two things: 

1) You didn't unmount the filesystem cleanly when you previously
booted a kernel with ext3 compiled in , and your 2.4 kernel has ext3
as a module, but you either don't have an initrd or the initrd doesn't
have the ext3 module in it.

2) You managed to enable a new ext3 feature, such as htree, or
extended attributes which was supported in the newer kernel, but not
in the 2.4 kernel.

(1) tends to be the most likely cause, given the confused users who
ask these sorts of questions on th ext3-users mailing list.  As a
result, I've developed a very strong distaste for initrd, and
generally strongly encourage people to compile ext3 and whatever
device drivers you require into the kernel, and to not try to use
initrd.  initrd turns out to be a confusing stumbling block for far
too many users.

						- Ted
