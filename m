Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSAOQdX>; Tue, 15 Jan 2002 11:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSAOQdP>; Tue, 15 Jan 2002 11:33:15 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:21109 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287831AbSAOQdD>; Tue, 15 Jan 2002 11:33:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Nikita Danilov <Nikita@Namesys.COM>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
Date: Tue, 15 Jan 2002 17:31:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de> <E16QVf3-0002NG-00@charged.uio.no> <15428.23828.941425.774587@laputa.namesys.com>
In-Reply-To: <15428.23828.941425.774587@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115163208.785831435@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15. January 2002 17:47, Nikita Danilov wrote:
> Trond Myklebust writes:
>  > On Tuesday 15. January 2002 16:27, Nikita Danilov wrote:
>  > > In reiserfs there is no static inode table, so we keep global
>  > > generation counter in a super block which is incremented on each inode
>  > > deletion, this generation is stored in the new inodes. Not that good
>  > > as per-inode generation, but we cannot do better without changing disk
>  > > format.
>  >
>  > Am I right in assuming that you therefore cannot check that the
>  > filehandle is stale if the client presents you with the filehandle of
>  > the 'old' inode (prior to deletion)?
>  > However if the client compares the 'old' and 'new' filehandle, it will
>  > find them to be different?
>
> Sorry for being vague. Reiserfs keeps global "inode generation counter"
> ->s_inode_generation in a super block. This counter is incremented each
> time reiserfs inode is being deleted on a disk. When new inode is
> created, current value of ->s_inode_generation is stored in inode's
> on-disk representation. Inode number (objectid in reiserfs parlance) is
> reusable once inode was deleted. The same pair (i_ino, i_generation) can
> be assigned to different inode only after ->s_inode_generation
> overflows, which requires 2**32 file deletions.

Except it's in 3.5 format, which requires one deletion then?

> So, no, reiserfs can tell stale filehandle, although not as reliable as
> file systems with static inode tables.
>
> Hans-Peter, please tell me, what reiserfs format are you using. 3.5
> doesn't support NFS reliably. If you are using 3.5 you'll have to
> upgrade to 3.6 format (copy data to the new file system). mount -o conv
> will not eliminate this problem completely, but will make it much less
> probable, so you can try this first.

Bad luck for me, obviously :-(

<4>reiserfs: checking transaction log (device 03:09) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 03:08) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 03:06) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 03:07) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 03:0a) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 21:02) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25

We're talking about 100 GB on _this_ server.

How big is the chance to loose data with -o conv?

Is there any paper around, which describes this conversion 
a bit more detailed? If I understand you correctly, the inode 
generation counter doesn't work at all with 3.5?

>  > Cheers,
>  >   Trond
>
> Nikita.

Cheers,
  Hans-Peter
