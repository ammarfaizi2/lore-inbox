Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265900AbSKBI4G>; Sat, 2 Nov 2002 03:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265901AbSKBI4G>; Sat, 2 Nov 2002 03:56:06 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:40121 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S265900AbSKBI4E>; Sat, 2 Nov 2002 03:56:04 -0500
Message-ID: <3DC3936F.4070908@lougher.demon.co.uk>
Date: Sat, 02 Nov 2002 08:57:19 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: Jeff Garzik <jgarzik@pobox.com>, Samuel Flory <sflory@rackable.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com> <3DC0719A.30101@lougher.demon.co.uk> <200211011557.19145.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 30 October 2002 23:56, Phillip Lougher wrote:
> 
>>Jeff Garzik wrote:
>> > Phillip Lougher wrote:
>> >> 2. Squashfs compresses inode and directory information in addition
>> >> to file data.  Inodes/directories generally compress down to 50%, or
>> >> say on average 8 bytes or less per inode.
>> >
>> > squashfs or mksquashfs?
>>
>>mksquashfs...
>>
>> > A r/w compressed filesystem would be darned useful too :)
>> >
>> > Jeff
>>
>>A r/w compressed filesystem may be my next project...  As a couple of
>>people have mentioned there are compressed r/w filesystems already
>>out there.
>>
>>As you'll know, there are always tradeoffs with filesystem design,
>>it is very difficult to get as good compression with a r/w fs
>>than with a read only filesystem.  I wanted to get maximum
>>compression, and quite a few of the techniques I use rely on
>>its read-only nature.
> 
> 
> A compressed filesystem with dynamically updated random-access files will 
> fragment the heck out of itself darn fast.  (Seek into the middle of a file 
> somewhere, write a block, seek somewhere else, write another block, repeat 
> 1000 times...  Keep in mind that the new compressed block of data will almost 
> certainly not be the same size as the old one... It's a mess.)
> 
> My potential usage is: I've got a little linux distribution I put together 
> called "firmware linux", which builds from source and outputs a zisofs image 
> that gets loopback mounted as the root filesystem.  (A very alpha version 
> could be sucked off of http://216.143.22.141/firmware/fwl-0.8.tar, edit 
> "build.sh" to specify the output directory, and then run it.  The point is, 
> the whole OS and all applications can be upgraded as one file.  No package 
> management, it's basically a big firmware image.)
> 
> The reason I used a zisofs instead of cramfs is that cramfs has a LOT of 
> problems with big filesystems.  (The finished root partition, with apache and 
> samba and ntop and python and rsync and openssh and everything, is currently 
> around 100 megs.  Yeah, I can trim that down by quite a bit if I get time, 
> I'm currently compilling and developing it under itself so I have gcc in 
> there and the full set of man pages and everything...)
> 
> Mkcramfs seems to barf at somewhere around 16 megs, which is really limiting.  
> AND it seems to try to open every file simultaneously (hardlink detection?) 
> so it runs out of file handles.  (Again, that could be adjusted under /proc 
> somewhere, but isn't worth it.)
> 
> So it seems that the thing to test this against isn't cramfs, but zisofs.  
> Have you looked at that?
> 
> I'll take a look myself and get back to you...
> 
> Rob
> 

Hi,

I looked at both cramfs and ziosfs when writing squashfs.  Zisofs is a 
nice fs, but tends to have greater overhead due to the isofs filesystem. 
  On tests I've found zisofs images to be between 5% (a single directory 
with lots of small binaries) and 61% (lots of nested directories) bigger 
than the squashfs filesystem.

I believe that squashfs is useful for what you're doing.  I'm a bit 
hesitant in saying that, because I'd rather people downloaded it and 
made up their own minds :-)

Thank you for trying it out, and I hope you like it.  I'll obviously be 
interested in your thoughts on it.

Phillip


