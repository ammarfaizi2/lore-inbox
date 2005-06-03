Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFCI4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFCI4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFCI4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:56:36 -0400
Received: from mail.sbb.co.yu ([82.117.194.7]:8409 "EHLO mail.sbb.co.yu")
	by vger.kernel.org with ESMTP id S261189AbVFCI4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:56:31 -0400
Date: Fri, 3 Jun 2005 10:56:24 +0200 (CEST)
From: Goran Gajic <ggajic@sbb.co.yu>
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: XFS and 2.6.12-rc5
In-Reply-To: <20050603044138.GB1653@frodo>
Message-ID: <Pine.BSF.4.62.0506031052260.57771@mail.sbb.co.yu>
References: <Pine.BSF.4.62.0506011308530.86037@mail.sbb.co.yu>
 <20050603044138.GB1653@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SBB-MailScanner-Information: Please contact the ISP for more information
X-SBB-MailScanner: Found to be clean
X-MailScanner-From: ggajic@sbb.co.yu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 3 Jun 2005, Nathan Scott wrote:

> On Wed, Jun 01, 2005 at 01:10:47PM +0200, Goran Gajic wrote:
>> xfs partition is exported via nfs to FreeBSD-5.4 machine. This is what I
>> find every morning in my syslog:
>>
>>  ------------[ cut here ]------------
>>  kernel BUG at fs/xfs/support/debug.c:106!
>> ...
>>  [<c0269758>] xfs_bmap_search_extents+0x108/0x140
>>  [<c026accd>] xfs_bmapi+0x28d/0x1660
>
> There should be some diagnostic text just above this panic message,
> what does it say?  At a guess, I'd say you have a corrupt inode on
> disk, and your nightly cron jobs are tripping this up each time.
> The panic happens cos the kernel detects an inode with an extent
> map which claiming to have an extent starting at the offset of the
> primary superblock.  I've seen another case of this recently which
> looked like a possible compiler bug, so could you send me both the
> full diagnostic message and your compiler version number?
>
> Also, the diagnostic will contain an inode number - for bonus points
> run "xfs_db -r -c 'inode XXX' -c print /dev/foo" and send me that as
> well.  Thanks!
>
> cheers.
>
> -- 
> Nathan
>

You are right about message here it is:

May 31 04:16:37 cbt kernel: Access to block zero: fs: <sdb1> inode: 
448631586 start_block : ffffffff00000000 start_off : 3fffff blkcnt : 
100000000 extent-state: dfcb1d0c

xfs_db -r -c 'inode 448631586' -c print /dev/sdb1
core.magic = 0x494e
core.mode = 0100644
core.version = 1
core.format = 2 (extents)
core.nlinkv1 = 1
core.uid = 0
core.gid = 0
core.flushiter = 2
core.atime.sec = Sun May 29 14:35:00 2005
core.atime.nsec = 521517264
core.mtime.sec = Sun May 29 14:40:00 2005
core.mtime.nsec = 676886712
core.ctime.sec = Sun May 29 14:40:00 2005
core.ctime.nsec = 676886712
core.size = 2120649
core.nblocks = 458
core.extsize = 0
core.nextents = 4
core.naextents = 0
core.forkoff = 0
core.aformat = 2 (extents)
core.dmevmask = 0
core.dmstate = 0
core.newrtbm = 0
core.prealloc = 0
core.realtime = 0
core.immutable = 0
core.append = 0
core.sync = 0
core.noatime = 0
core.nodump = 0
core.gen = 0
next_unlinked = null
u.bmx[0-3] = [startoff,startblock,blockcount,extentflag] 
0:[177,2557931,341,0] 1:[18014398509481983,4498651825045504,0,1] 
2:[15184073051865088,0,0,0] 3:[0,1422,1245184,0]

gcc -v
Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --enable-languages=c,c++,f77,objc,java,ada 
--disable-checking --libdir=/usr/lib --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i586-suse-linux
Thread model: posix
gcc version 3.3.3 (SuSE Linux)

Turning off cron.daily stops this message so I guess you are right.

Regards,
gg.
