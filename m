Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSAOO2w>; Tue, 15 Jan 2002 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAOO2n>; Tue, 15 Jan 2002 09:28:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:23315 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289642AbSAOO22>; Tue, 15 Jan 2002 09:28:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.19063.859280.833041@laputa.namesys.com>
Date: Tue, 15 Jan 2002 18:27:51 +0300
To: trond.myklebust@fys.uio.no
Cc: Nikita Danilov <Nikita@Namesys.COM>, Neil Brown <neilb@cse.unsw.edu.au>,
        Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs 
In-Reply-To: <15428.12621.682479.589568@charged.uio.no>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<15428.6953.453942.415989@charged.uio.no>
	<15428.14268.730698.637522@laputa.namesys.com>
	<15428.12621.682479.589568@charged.uio.no>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:
 > >>>>> " " == Nikita Danilov <Nikita@Namesys.COM> writes:
 > 
 >      > Yes, inode->i_generation is stored in the file handle:
 >      > fs/reiserfs/inode.c:reiserfs_dentry_to_fh().
 > 
 > But what is stored in inode->i_generation? AFAICS
 > 
 >      inode->i_generation = le32_to_cpu (INODE_PKEY (inode)->k_dir_id);
 > 
 > which appears not to be a unique generation count. Isn't that instead
 > the directory's object id?

This is only for 3.5 reiserfs format (default for 2.2 kernels), for 3.6
format, generation is stored on the disk (in the same place where rdev
is stored for device files). 3.5 cannot work with nfs reliably.

Hans-Peter, you can check version of reiserfs you use with
/sbin/debugreiserfs /dev/device

or 
cat /proc/fs/reiserfs/device/version

 > 
 > The point of i_generation is to provide a unique number that changes
 > every time you reuse the inode number.

In reiserfs there is no static inode table, so we keep global generation
counter in a super block which is incremented on each inode deletion,
this generation is stored in the new inodes. Not that good as per-inode
generation, but we cannot do better without changing disk format.

 > 
 > Cheers,
 >   Trond
 > 

Nikita.
