Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265781AbSKAUu7>; Fri, 1 Nov 2002 15:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbSKAUu6>; Fri, 1 Nov 2002 15:50:58 -0500
Received: from pc132.utati.net ([216.143.22.132]:45184 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265781AbSKAUuz> convert rfc822-to-8bit; Fri, 1 Nov 2002 15:50:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Date: Fri, 1 Nov 2002 15:57:18 +0000
User-Agent: KMail/1.4.3
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com> <3DC0719A.30101@lougher.demon.co.uk>
In-Reply-To: <3DC0719A.30101@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011557.19145.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 23:56, Phillip Lougher wrote:
> Jeff Garzik wrote:
>  > Phillip Lougher wrote:
>  >> 2. Squashfs compresses inode and directory information in addition
>  >> to file data.  Inodes/directories generally compress down to 50%, or
>  >> say on average 8 bytes or less per inode.
>  >
>  > squashfs or mksquashfs?
>
> mksquashfs...
>
>  > A r/w compressed filesystem would be darned useful too :)
>  >
>  > Jeff
>
> A r/w compressed filesystem may be my next project...  As a couple of
> people have mentioned there are compressed r/w filesystems already
> out there.
>
> As you'll know, there are always tradeoffs with filesystem design,
> it is very difficult to get as good compression with a r/w fs
> than with a read only filesystem.  I wanted to get maximum
> compression, and quite a few of the techniques I use rely on
> its read-only nature.

A compressed filesystem with dynamically updated random-access files will 
fragment the heck out of itself darn fast.  (Seek into the middle of a file 
somewhere, write a block, seek somewhere else, write another block, repeat 
1000 times...  Keep in mind that the new compressed block of data will almost 
certainly not be the same size as the old one... It's a mess.)

My potential usage is: I've got a little linux distribution I put together 
called "firmware linux", which builds from source and outputs a zisofs image 
that gets loopback mounted as the root filesystem.  (A very alpha version 
could be sucked off of http://216.143.22.141/firmware/fwl-0.8.tar, edit 
"build.sh" to specify the output directory, and then run it.  The point is, 
the whole OS and all applications can be upgraded as one file.  No package 
management, it's basically a big firmware image.)

The reason I used a zisofs instead of cramfs is that cramfs has a LOT of 
problems with big filesystems.  (The finished root partition, with apache and 
samba and ntop and python and rsync and openssh and everything, is currently 
around 100 megs.  Yeah, I can trim that down by quite a bit if I get time, 
I'm currently compilling and developing it under itself so I have gcc in 
there and the full set of man pages and everything...)

Mkcramfs seems to barf at somewhere around 16 megs, which is really limiting.  
AND it seems to try to open every file simultaneously (hardlink detection?) 
so it runs out of file handles.  (Again, that could be adjusted under /proc 
somewhere, but isn't worth it.)

So it seems that the thing to test this against isn't cramfs, but zisofs.  
Have you looked at that?

I'll take a look myself and get back to you...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
