Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSKGGXj>; Thu, 7 Nov 2002 01:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266463AbSKGGXi>; Thu, 7 Nov 2002 01:23:38 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:25260 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266462AbSKGGXe>; Thu, 7 Nov 2002 01:23:34 -0500
Message-ID: <3DCA086E.8000802@attbi.com>
Date: Wed, 06 Nov 2002 22:30:06 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: EXT2 corruption -- After running 2.5.46, my root partition cannot
 be mounted by older kernels
References: <3DC9D145.6040109@attbi.com> <20021107041325.GB11010@think.thunk.org>
In-Reply-To: <20021107041325.GB11010@think.thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Tso wrote:

> Send the output of dumpe2fs -h to be sure, but it's almost certainly
> one of two things: 
> 
> 1) You didn't unmount the filesystem cleanly when you previously
> booted a kernel with ext3 compiled in , and your 2.4 kernel has ext3
> as a module, but you either don't have an initrd or the initrd doesn't
> have the ext3 module in it.

I do also have initrd support compiled into the kernel:

# Block devices
#
...
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

I added this because I have been basing my latest kernel configs
off if the default Redhat 8.0 configuration.  Hmm.  

> 2) You managed to enable a new ext3 feature, such as htree, or
> extended attributes which was supported in the newer kernel, 
> but not in the 2.4 kernel.

I have, indeed, compiled my 2.5.46 kernel with ACL support.
Mea culpa for not studying the effect on the filesystem 
before testing this new code.  I usually try to do compile 
testing on a lot of options, whether or not I exercize the 
code.  I didn't realise that ACL support would modify the 
filesystem whether or not I applied ACLs to a particular file.
Or is that what has happened?

# File systems
#
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y

>> dumpe2fs -h /dev/hda12
dumpe2fs 1.27 (8-Mar-2002)
Filesystem volume name:   /
Last mounted on:          <not available>
Filesystem UUID:          0a3ccf38-e09c-4ce8-af56-4c086b7adce4
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1982464
Block count:              3962022
Reserved block count:     198101
Free blocks:              2862850
Free inodes:              1800406
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Last mount time:          Wed Nov  6 18:09:02 2002
Last write time:          Wed Nov  6 18:09:02 2002
Mount count:              6
Maximum mount count:      23
Last checked:             Wed Nov  6 16:29:29 2002
Check interval:           15552000 (6 months)
Next check after:         Mon May  5 17:29:29 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            54
Journal device:           0x0000
First orphan inode:       345436

> (1) tends to be the most likely cause, given the confused users who
> ask these sorts of questions on th ext3-users mailing list.  As a
> result, I've developed a very strong distaste for initrd, and
> generally strongly encourage people to compile ext3 and whatever
> device drivers you require into the kernel, and to not try to use
> initrd.  initrd turns out to be a confusing stumbling block for far
> too many users.

I'm not sure how best to proceed.

Thanks very much for your help!

	Miles


