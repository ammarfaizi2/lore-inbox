Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbRGNNF6>; Sat, 14 Jul 2001 09:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbRGNNFi>; Sat, 14 Jul 2001 09:05:38 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:19110 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267641AbRGNNFg>; Sat, 14 Jul 2001 09:05:36 -0400
Message-Id: <5.1.0.14.2.20010714135842.00acd7a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 14 Jul 2001 14:05:54 +0100
To: trond.myklebust@fys.uio.no
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH/CFT] Fix NFS mmap problems w.r.t. page_launder() in
  2.4.6...
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15184.9082.90044.242609@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:48 14/07/2001, Trond Myklebust wrote:
[snip]
>+/*
>+ * For the moment, the only task for the NFS clear_inode method is to
>+ * release the mmap credential
>+ */
>+static void
>+nfs_clear_inode(struct inode *inode)
>+{
>+       struct rpc_cred *cred = NFS_I(inode)->mm_cred;
>+
>+       if (cred) {
>+               put_rpccred(cred);
>+               NFS_I(inode)->mm_cred = 0;
>+       }
>+}

I know it's nit-picking but wouldn't it be cleaner/faster to do:

+static void
+nfs_clear_inode(struct inode *inode)
+{
+       struct rpc_cred **cred = &NFS_I(inode)->mm_cred;
+
+       if (*cred) {
+               put_rpccred(*cred);
+               *cred = 0;
+       }
+}

Just a thought before waking up properly... Haven't looked at the generated 
assembly or anything.

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

