Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281682AbRKUJFb>; Wed, 21 Nov 2001 04:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281684AbRKUJFV>; Wed, 21 Nov 2001 04:05:21 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:21509 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S281682AbRKUJFH>; Wed, 21 Nov 2001 04:05:07 -0500
From: Nikita Danilov <Nikita@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15355.31671.983925.611542@beta.reiserfs.com>
Date: Wed, 21 Nov 2001 13:02:31 +0300
To: Andreas Dilger <adilger@turbolabs.com>
Cc: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
In-Reply-To: <20011121011655.M1308@lynx.no>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com>
	<15355.27299.252362.983624@beta.reiserfs.com>
	<20011121011655.M1308@lynx.no>
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Nov 21, 2001  11:49 +0300, Nikita Danilov wrote:
 > > Dieter NJtzel writes:
 > >  > but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
 > >  > I've tried it with "old" and "new" (current) N-inode-attrs.patch.
 > >  > But that doesn't matter.
 > >  > 
 > >  > [-]
 > >  > IP: routing cache hash table of 8192 buckets, 64Kbytes
 > >  > TCP: Hash tables configured (established 262144 bind 65536)
 > >  > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 > >  > reiserfs: checking transaction log (device 08:03) ...
 > >  > Using r5 hash to sort names
 > >  > ReiserFS version 3.6.25
 > >  > VFS: Mounted root (reiserfs filesystem) readonly.
 > >  > Freeing unused kernel memory: 208k freed
 > >  > "Warning: unable to open an initial console." 
 > > 
 > > N-inode-attrs.patch uses previously unused field in reiserfs on-disk
 > > inode structure to store inode attributes. It seems that in some cases
 > > this field actually contains garbage. It may happen that you have got
 > > immutable bit for your console device this way.
 > 
 > Hmm, this may be a kernel bug also, in a way.  I don't know if ext2
 > allows you to set attributes on char/block special files, but if it
 > does, then the "immutable" attribute should _probably_ apply to
 > changing the device inode, rather than writing to the device itself.
 > 
 > In any case, it is also a bad thing to leave garbage in unused parts of
 > on-disk data structs for just this reason, so mkreiserfs should zero
 > everything that is unused inside allocated structs (and the kernel too,
 > because reiserfs allocates inode tables dynamically, right?).

Yes, it's right, but currently we have what we have currently. I am
going to extend inode-attrs.patch and add new mount option
"noattrs". With it ioctls to set and get attributes will continue to
work, but attributes themselves will not have any effect. Then, one can
boot with "rootflags=noattrs" and read-write root, clear all attributes
by chattr -R and remount root.

I put new version of the patch in the same place, Dieter, can you please
try it?

 > 
 > Cheers, Andreas

Nikita.

 > --
 > Andreas Dilger
 > http://sourceforge.net/projects/ext2resize/
 > http://www-mddsp.enel.ucalgary.ca/People/adilger/
