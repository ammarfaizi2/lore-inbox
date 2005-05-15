Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVEOApB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVEOApB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 20:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVEOApB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 20:45:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:2516 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262819AbVEOAom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 20:44:42 -0400
Date: Sun, 15 May 2005 02:48:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S.Miller" <davem@davemloft.net>, Bodo Eggert <7eggert@gmx.de>,
       Paulo Marques <pmarques@grupopie.com>, Adrian Bunk <bunk@stusta.de>,
       Tom Duffy <tduffy@sun.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Steve French <sfrench@samba.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       ext2-devel@lists.sourceforge.net, Stephen Tweedie <sct@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       David Woodhouse <dwmw2@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Neil Brown <neilb@cse.unsw.edu.au>, reiserfs-dev@namesys.com,
       Urban Widmark <urban@teststation.com>,
       Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
       Christoph Hellwig <hch@infradead.org>,
       Kai Germaschewski <ai@germaschewski.name>,
       Savio Lam <lam836@cs.cuhk.hk>, Jeff Garzik <jgarzik@pobox.com>,
       nathans@sgi.com
Subject: [PATCH] CodingStyle adherence part 1 - if else cleanup part 1
Message-ID: <Pine.LNX.4.62.0505150041320.23696@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

As discussed in the '[PATCH] kernel/module.c has something to hide. 
(whitespace cleanup)' thread, I've started doing whitespace cleanups to 
make the kernel adhere closer to Documentation/CodingStyle.

As per your request I'm doing releatively few large patches against latest 
Linus kernel and sending them to you as I generate them instead of 
batching them up.  You also asked me to try and keep the most key people 
in the loop, so I've added what I think are a few central people regarding 
the code I've changed to CC, as well as the people who commented on the 
previous thread. I hope that hits the mark.

I started with the  if/else  cleanups.

Judging by if statements only we can see that this patch does aproximately 
one seventh of the work : 

before this patch:
juhl@dragon:~/download/kernel/linux-2.6.12-rc4-orig$ find ./ -name *.[ch] -exec egrep -r -H "if *\(.+\).*;.*" '{}' \; | awk -F: {'print $1'} | sort | uniq | wc -l
1403

after this patch:
juhl@dragon:~/download/kernel/linux-2.6.12-rc4$ find ./ -name *.[ch] -exec egrep -r -H "if *\(.+\).*;.*" '{}' \; | awk -F: {'print $1'} | sort | uniq | wc -l
1288

It changes code such as this
        if (foo) something();
        else something_else()
        a_third_thing();
into
        if (foo)
                something();
        else
                something_else();
        a_third_thing();

The patch covers the following dirs : 
	Documentation/
	crypto/
	fs/
	init/
	kernel/
	lib/
	scripts/
	usr/

There are no functional changes made by this patch, whitespace changes 
only. To ensure this 

I opted to do only one type of cleanup and then when that is done create 
incremental patches with the other cleanups instead of doing all cleanups 
(if/else, tabs vs spaces, trailing whitespace, spaces between function 
name and opening parenthesis, etc) to a single file at once. Do you agree 
with this approach or would you rather see each file cleaned up completely 
in one go?
I chose this approach to make the individual patches easier to review for 
correctness.

Since this patch is pretty huge (~192K), but within your specified 
100-400K range, I've put it online at this address : 
	http://ragnarok.dif.dk/~juhl/kernel_patches/if-else-cleanup-1.patch
but I can of course send it inline or attached in whatever form if wanted 
to anyone who asks.

To ensure that the patch really only makes whitespace cleanups I've read 
through the diff file 3 times and I've compile tested a 2.6.12-rc4 kernel 
with the patch applied (and didn't see any breakage). I have not yet done 
any md5sum or size comparison of the object files created.

Another thing; Bodo Eggert made a nice patch that cleaned up trailing 
whitespace. I did not do my patch on top of his, but if that is wanted 
I'll redo the patch and base any future patches on top of his. Would that 
be good?  Personally I think it would, but I'd like your oppinion :)


Patch is of course
 Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


Here's the diffstat : 

 Documentation/networking/ifenslave.c |    3 
 crypto/anubis.c                      |    9 +
 crypto/des.c                         |   48 +++++---
 crypto/sha1.c                        |    4 
 fs/bfs/inode.c                       |    3 
 fs/binfmt_aout.c                     |    3 
 fs/binfmt_elf.c                      |   44 +++++--
 fs/binfmt_elf_fdpic.c                |    9 +
 fs/binfmt_em86.c                     |    9 +
 fs/binfmt_script.c                   |    9 +
 fs/cifs/connect.c                    |    3 
 fs/coda/cache.c                      |    3 
 fs/coda/dir.c                        |   18 ++-
 fs/coda/upcall.c                     |   13 +-
 fs/compat.c                          |    3 
 fs/compat_ioctl.c                    |   15 +-
 fs/dcache.c                          |    3 
 fs/efs/inode.c                       |   15 +-
 fs/efs/super.c                       |    6 -
 fs/eventpoll.c                       |    6 -
 fs/exec.c                            |    3 
 fs/exportfs/expfs.c                  |    9 +
 fs/ext2/inode.c                      |   62 +++++-----
 fs/ext3/balloc.c                     |    3 
 fs/ext3/hash.c                       |    3 
 fs/ext3/ialloc.c                     |   12 +-
 fs/ext3/inode.c                      |    5 
 fs/ext3/namei.c                      |    6 -
 fs/fat/dir.c                         |   12 +-
 fs/hostfs/hostfs_kern.c              |   81 +++++++++-----
 fs/hostfs/hostfs_user.c              |  126 ++++++++++++++-------
 fs/hpfs/alloc.c                      |   98 +++++++++++-----
 fs/hpfs/anode.c                      |  136 +++++++++++++++--------
 fs/hpfs/buffer.c                     |   15 +-
 fs/hpfs/dentry.c                     |   14 +-
 fs/hpfs/dir.c                        |   30 +++--
 fs/hpfs/dnode.c                      |  202 +++++++++++++++++++++++------------
 fs/hpfs/ea.c                         |   39 ++++--
 fs/hpfs/file.c                       |   21 ++-
 fs/hpfs/hpfs_fn.h                    |    9 +
 fs/hpfs/inode.c                      |   30 +++--
 fs/hpfs/map.c                        |   21 ++-
 fs/hpfs/name.c                       |   71 ++++++++----
 fs/hpfs/namei.c                      |   39 ++++--
 fs/hpfs/super.c                      |   78 +++++++++----
 fs/hppfs/hppfs_kern.c                |   15 +-
 fs/isofs/compress.c                  |    3 
 fs/isofs/dir.c                       |   18 ++-
 fs/isofs/export.c                    |    6 -
 fs/isofs/inode.c                     |   18 ++-
 fs/isofs/namei.c                     |    6 -
 fs/isofs/rock.c                      |   71 ++++++++----
 fs/isofs/util.c                      |    6 -
 fs/jffs2/compr.c                     |    3 
 fs/jffs2/compr_rubin.c               |    6 -
 fs/jffs2/dir.c                       |    6 -
 fs/jffs2/nodemgmt.c                  |    3 
 fs/jffs2/scan.c                      |    6 -
 fs/lockd/xdr4.c                      |    3 
 fs/minix/itree_common.c              |   37 +++---
 fs/ncpfs/inode.c                     |    3 
 fs/ncpfs/ioctl.c                     |   30 +++--
 fs/ncpfs/ncplib_kernel.c             |   15 +-
 fs/nfs/nfs4xdr.c                     |    3 
 fs/nfsd/export.c                     |   33 +++--
 fs/nfsd/nfs3xdr.c                    |    6 -
 fs/nfsd/nfs4callback.c               |    3 
 fs/nfsd/nfs4xdr.c                    |    3 
 fs/nfsd/nfscache.c                   |    3 
 fs/nfsd/nfsctl.c                     |    6 -
 fs/nfsd/nfsfh.c                      |    9 +
 fs/nfsd/vfs.c                        |    9 +
 fs/openpromfs/inode.c                |   27 +++-
 fs/partitions/ldm.c                  |   21 ++-
 fs/pipe.c                            |   18 ++-
 fs/proc/array.c                      |   12 +-
 fs/proc/generic.c                    |    6 -
 fs/proc/proc_misc.c                  |    9 +
 fs/read_write.c                      |    3 
 fs/reiserfs/inode.c                  |   10 +
 fs/reiserfs/namei.c                  |   11 +
 fs/reiserfs/xattr.c                  |    3 
 fs/smbfs/proc.c                      |   12 +-
 fs/sysv/itree.c                      |   45 +++----
 fs/udf/file.c                        |    6 -
 fs/udf/inode.c                       |    6 -
 fs/ufs/dir.c                         |    6 -
 fs/ufs/super.c                       |   18 ++-
 fs/xfs/linux-2.6/xfs_stats.c         |    6 -
 fs/xfs/linux-2.6/xfs_sysctl.c        |    3 
 fs/xfs/quota/xfs_qm.c                |    6 -
 fs/xfs/support/debug.c               |    6 -
 fs/xfs/support/uuid.c                |    3 
 fs/xfs/xfs_alloc.c                   |    3 
 fs/xfs/xfs_bmap.c                    |    3 
 fs/xfs/xfs_dfrag.c                   |    6 -
 fs/xfs/xfs_vnodeops.c                |    9 +
 init/do_mounts_rd.c                  |    3 
 kernel/acct.c                        |    3 
 kernel/audit.c                       |   12 +-
 kernel/exit.c                        |    3 
 kernel/kallsyms.c                    |    6 -
 kernel/module.c                      |    9 +
 kernel/params.c                      |    6 -
 kernel/sched.c                       |    9 +
 kernel/sysctl.c                      |    3 
 lib/string.c                         |    3 
 lib/zlib_deflate/deflate.c           |   87 ++++++++++-----
 lib/zlib_deflate/deftree.c           |   58 ++++++----
 lib/zlib_inflate/infblock.c          |    6 -
 lib/zlib_inflate/inflate_sync.c      |    3 
 lib/zlib_inflate/infutil.c           |   12 +-
 scripts/basic/fixdep.c               |   20 ++-
 scripts/basic/split-include.c        |    6 -
 scripts/kallsyms.c                   |   21 ++-
 scripts/lxdialog/menubox.c           |    6 -
 scripts/lxdialog/util.c              |    9 +
 usr/gen_init_cpio.c                  |    6 -
 118 files changed, 1470 insertions(+), 760 deletions(-)



-- 
Jesper Juhl


