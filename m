Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282325AbRKXBRE>; Fri, 23 Nov 2001 20:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282324AbRKXBQy>; Fri, 23 Nov 2001 20:16:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:46351 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S282322AbRKXBQu>;
	Fri, 23 Nov 2001 20:16:50 -0500
Date: Sat, 24 Nov 2001 03:16:25 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Mike Eldridge <diz@cafes.net>
Cc: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
Message-ID: <20011124031625.T2682@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com> <002801c1740f$7372f650$1300a8c0@marcelo> <20011123171157.Q21290@mail.cafes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123171157.Q21290@mail.cafes.net>; from diz@cafes.net on Fri, Nov 23, 2001 at 05:11:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 05:11:57PM -0600, Mike Eldridge wrote:
> ext2 has a 2GB filesize limitation.

  Mike has already realized this, but still...
I have used ext2 at Linux 1.2 with file sizes exceeding 2GB.
The requirement was 64 bit machine in those days, I had Alpha.
(Yes, that was VERY LONG AGO!)

It is very late (2.3/2.4) development that 32-bit machines can
do 2TB files.  Sparse files can indeed be larger up to 4G times
filesystem block size, but ext2 is limited on one physical
partition, and those are still limited on 1 or 2 terabyte range.
(2G * 512 or 4G * 512.)  (long story why that limit is still
in there, mainly because nobody has had need to rework it.)

Limitations on EXT2 (indeed of all "indirect block indexing"
schemes of SysV FS style) are a bit complicated to calculate.
  B = block size in bytes (512 to 4096 bytes)
  addressable_blocks = (B/4)**3 + (B/4)**2 + ...
  max_offset = B * addressable_blocks

So, say:  max_offset = B**4 / 64 + epsilon

That gives you magnitude. Say with 4k blocks (long story why that
is presently maximum block-size) you can have up to 4 TB file size.
(plus a bit over, see the math.)

The 2.5 series may change the underlying block-device layer so that
it can handle larger block devices than 2TB - the 64 bit machines can
handle them, of course, but 32-bit i386 is a bit limited...


> -mike
>           radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd           


/Matti Aarnio
