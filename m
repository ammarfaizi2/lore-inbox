Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbREHPWT>; Tue, 8 May 2001 11:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbREHPWK>; Tue, 8 May 2001 11:22:10 -0400
Received: from mons.uio.no ([129.240.130.14]:38593 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132701AbREHPWD>;
	Tue, 8 May 2001 11:22:03 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <20010508160050.F543@athlon.random>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 May 2001 17:21:02 +0200
In-Reply-To: Andrea Arcangeli's message of "Tue, 8 May 2001 16:00:50 +0200"
Message-ID: <shs3dafvpcx.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > This fixes corruption with MAP_SHARED on top of nfs filesystem
     > in 2.4:
     > --- 2.4.5pre1aa2/fs/nfs/write.c.~1~ Tue May 1 19:35:29 2001
     > +++ 2.4.5pre1aa2/fs/nfs/write.c Tue May 8 02:04:15 2001
     > @@ -1533,6 +1533,7 @@
     >  	if (!inode && file)
     >  		inode = file->f_dentry->d_inode;
 
     > + filemap_fdatasync(inode->i_mapping);
     >  	do {
     >  		error = 0; if (wait)

Yech! Apart from the fact that this means you do a full fdatasync()
even when you are simply trying to flush out single pages,
nfs_sync_file() gets called all over the place including in areas
where we know we're already holding a page lock.


AFAICs this fix will clearly deadlock...

Could you instead detail exactly which corruption problem you are
trying to fix?

Cheers,
  Trond
