Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281674AbRKUISL>; Wed, 21 Nov 2001 03:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281672AbRKUISB>; Wed, 21 Nov 2001 03:18:01 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6138 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281671AbRKUIRr>;
	Wed, 21 Nov 2001 03:17:47 -0500
Date: Wed, 21 Nov 2001 01:16:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Nikita Danilov <Nikita@namesys.com>
Cc: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Message-ID: <20011121011655.M1308@lynx.no>
Mail-Followup-To: Nikita Danilov <Nikita@namesys.com>,
	=?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	ReiserFS List <reiserfs-list@namesys.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com> <15355.27299.252362.983624@beta.reiserfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15355.27299.252362.983624@beta.reiserfs.com>; from Nikita@namesys.com on Wed, Nov 21, 2001 at 11:49:39AM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 21, 2001  11:49 +0300, Nikita Danilov wrote:
> Dieter NJtzel writes:
>  > but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
>  > I've tried it with "old" and "new" (current) N-inode-attrs.patch.
>  > But that doesn't matter.
>  > 
>  > [-]
>  > IP: routing cache hash table of 8192 buckets, 64Kbytes
>  > TCP: Hash tables configured (established 262144 bind 65536)
>  > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  > reiserfs: checking transaction log (device 08:03) ...
>  > Using r5 hash to sort names
>  > ReiserFS version 3.6.25
>  > VFS: Mounted root (reiserfs filesystem) readonly.
>  > Freeing unused kernel memory: 208k freed
>  > "Warning: unable to open an initial console." 
> 
> N-inode-attrs.patch uses previously unused field in reiserfs on-disk
> inode structure to store inode attributes. It seems that in some cases
> this field actually contains garbage. It may happen that you have got
> immutable bit for your console device this way.

Hmm, this may be a kernel bug also, in a way.  I don't know if ext2
allows you to set attributes on char/block special files, but if it
does, then the "immutable" attribute should _probably_ apply to
changing the device inode, rather than writing to the device itself.

In any case, it is also a bad thing to leave garbage in unused parts of
on-disk data structs for just this reason, so mkreiserfs should zero
everything that is unused inside allocated structs (and the kernel too,
because reiserfs allocates inode tables dynamically, right?).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

