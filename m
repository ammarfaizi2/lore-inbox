Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272422AbRH3TjY>; Thu, 30 Aug 2001 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272423AbRH3TjO>; Thu, 30 Aug 2001 15:39:14 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:40068 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S272422AbRH3TjE>;
	Thu, 30 Aug 2001 15:39:04 -0400
Date: Thu, 30 Aug 2001 15:39:10 -0400
From: Theodore Tso <tytso@mit.edu>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
Message-ID: <20010830153910.C3114@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	Andreas Dilger <adilger@turbolabs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua> <20010829021304.D24270@turbolinux.com> <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>; from VDA@port.imtp.ilyichevsk.odessa.ua on Wed, Aug 29, 2001 at 03:14:17PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 03:14:17PM +0300, VDA wrote:
> 
> Installed e2fsprogs 1.23. It does not print warning now on
> "fsck /dev/scsi/host0/bus0/target1/lun0/part1"
> However, it still cannot fs check root fs when given "fsck /" which I
> really need in my init script. Now the only way to do root fs check
> for me is to parse /proc/mounts and extract mount point for / via sed
> (I have never used sed yet...).
> 
> # fsck /
> Parallelizing fsck version 1.15 (18-Jul-1999)
> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> /sbin/e2fsck: Is a directory while trying to open /

Umm... it works for me.  (No, I don't use devfs, but I do test
e2fsprogs to make sure they do some sane vs. devfs by using UML...)

usermode:/etc# cat /etc/mtab
/dev/ubd/0 / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,mode=0622 0 0
usermode:/etc# fsck -NV /
Parallelizing fsck version 1.23 (15-Aug-2001)
[/sbin/fsck.ext2 -- /] fsck.ext2 /dev/ubd/0 


What does your /etc/mtab file show for an entry for the root
filesystem when you're trying to make it work?  Fsck does require that
/etc/mtab is sane, and I'm guessing that you're missing an entry in
/etc/mtab for /. 

						- Ted
