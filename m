Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935399AbWK1PtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935399AbWK1PtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 10:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935402AbWK1PtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 10:49:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:5902 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S935399AbWK1PtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 10:49:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qAl8HA+hO7vaOABJUVT3MyHsSYaRDjV1UnuuZ8Uaz3DUBO8rndKs90L4uwqJw/i2uE2aeOTFcoE3w7ztcsfoK2e4Ekbl+VFhG+GFNCIdtX3klOqpvmbk6oYt56OGz1Gf6h8GCXjMqC2skSdv3MZfT+Kwdhlxl1pjTdo/ou37quY=
Message-ID: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com>
Date: Tue, 28 Nov 2006 16:49:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Subject: XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c (kernel 2.6.18.1)
Cc: "Keith Owens" <kaos@sgi.com>, "Jesper Juhl" <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of my NFS servers just gave me a nasty surprise that I think it is
relevant to tell you about:

Filesystem "dm-1": XFS internal error xfs_trans_cancel at line 1138 of
file fs/xfs/xfs_trans.c.  Caller 0xffffffff8034b47e

Call Trace:
 [<ffffffff8020b122>] show_trace+0xb2/0x380
 [<ffffffff8020b405>] dump_stack+0x15/0x20
 [<ffffffff80327b4c>] xfs_error_report+0x3c/0x50
 [<ffffffff803435ae>] xfs_trans_cancel+0x6e/0x130
 [<ffffffff8034b47e>] xfs_create+0x5ee/0x6a0
 [<ffffffff80356556>] xfs_vn_mknod+0x156/0x2e0
 [<ffffffff803566eb>] xfs_vn_create+0xb/0x10
 [<ffffffff80284b2c>] vfs_create+0x8c/0xd0
 [<ffffffff802e734a>] nfsd_create_v3+0x31a/0x560
 [<ffffffff802ec838>] nfsd3_proc_create+0x148/0x170
 [<ffffffff802e19f9>] nfsd_dispatch+0xf9/0x1e0
 [<ffffffff8049d617>] svc_process+0x437/0x6e0
 [<ffffffff802e176d>] nfsd+0x1cd/0x360
 [<ffffffff8020ab1c>] child_rip+0xa/0x12
xfs_force_shutdown(dm-1,0x8) called from line 1139 of file
fs/xfs/xfs_trans.c.  Return address = 0xffffffff80359daa
Filesystem "dm-1": Corruption of in-memory data detected.  Shutting
down filesystem: dm-1
Please umount the filesystem, and rectify the problem(s)
nfsd: non-standard errno: 5
nfsd: non-standard errno: 5
nfsd: non-standard errno: 5
nfsd: non-standard errno: 5
nfsd: non-standard errno: 5
          (the above message repeates 1670 times, then the following)
xfs_force_shutdown(dm-1,0x1) called from line 424 of file
fs/xfs/xfs_rw.c.  Return address = 0xffffffff80359daa

I unmounted the filesystem, ran xfs_repair which told me to try an
mount it first to replay the log, so I did, unmounted it again, ran
xfs_repair (which didn't find any problems) and finally mounted it and
everything is good - the filesystem seems intact.

Filesystem "dm-1": Disabling barriers, not supported with external log device
XFS mounting filesystem dm-1
Starting XFS recovery on filesystem: dm-1 (logdev: /dev/Log1/ws22_log)
Ending XFS recovery on filesystem: dm-1 (logdev: /dev/Log1/ws22_log)
Filesystem "dm-1": Disabling barriers, not supported with external log device
XFS mounting filesystem dm-1
Ending clean XFS mount for filesystem: dm-1


The server in question is running kernel 2.6.18.1


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
