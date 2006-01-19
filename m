Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWASDdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWASDdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWASDdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:33:54 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:21096 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161055AbWASDdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:33:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GorlMXd1cnFwo1958Gi9k/WXZCboiALtJiB+NDIPT6DVnD8wia0izeZAVkCFktpQ0JUwMkOOyjWDdNA5yE1JFGVHQw989sBwXBpECbx8Su8IOJfigkQ8V+b/a2ZhrguLaXfzFUkmwPEK6XmXnvtIV5WdcR9Z4elaiJ0JWRbmugA=
Message-ID: <2cd57c900601181933i3dfcda46v@mail.gmail.com>
Date: Thu, 19 Jan 2006 11:33:51 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + 2tb-files-add-blkcnt_t-fixes.patch added to -mm tree
Cc: akpm@osdl.org, sho@tnes.nec.co.jp
In-Reply-To: <200601140630.k0E6UkTm021247@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601140630.k0E6UkTm021247@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/14, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      2tb-files-add-blkcnt_t-fixes
>
> has been added to the -mm tree.  Its filename is
>
>      2tb-files-add-blkcnt_t-fixes.patch
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Cc: Takashi Sato <sho@tnes.nec.co.jp>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/cifs/inode.c    |    6 +++---
>  fs/cifs/readdir.c  |    8 ++++----
>  fs/ocfs2/journal.c |    8 +++++---
>  fs/ocfs2/namei.c   |    5 +++--
>  cifs/file.c        |    0
>  5 files changed, 15 insertions(+), 12 deletions(-)
>
> diff -puN fs/cifs/inode.c~2tb-files-add-blkcnt_t-fixes fs/cifs/inode.c
> --- devel/fs/cifs/inode.c~2tb-files-add-blkcnt_t-fixes  2006-01-13 22:22:50.000000000 -0800
> +++ devel-akpm/fs/cifs/inode.c  2006-01-13 22:23:47.000000000 -0800
> @@ -163,9 +163,9 @@ int cifs_get_inode_info_unix(struct inod
>
>                 if (num_of_bytes < end_of_file)
>                         cFYI(1, ("allocation size less than end of file"));
> -               cFYI(1,
> -                    ("Size %ld and blocks %ld",
> -                     (unsigned long) inode->i_size, inode->i_blocks));
> +               cFYI(1, ("Size %ld and blocks %llu",
> +                       (unsigned long) inode->i_size,

Fix i_size too please. There're a lot.

> +                       (unsigned long long)inode->i_blocks));
>                 if (S_ISREG(inode->i_mode)) {
>                         cFYI(1, ("File inode"));
>                         inode->i_op = &cifs_file_inode_ops;
> diff -puN fs/ocfs2/journal.c~2tb-files-add-blkcnt_t-fixes fs/ocfs2/journal.c
> --- devel/fs/ocfs2/journal.c~2tb-files-add-blkcnt_t-fixes       2006-01-13 22:22:50.000000000 -0800
> +++ devel-akpm/fs/ocfs2/journal.c       2006-01-13 22:30:29.000000000 -0800
> @@ -579,7 +579,8 @@ int ocfs2_journal_init(struct ocfs2_jour
>         }
>
>         mlog(0, "inode->i_size = %lld\n", inode->i_size);
> -       mlog(0, "inode->i_blocks = %lu\n", inode->i_blocks);
> +       mlog(0, "inode->i_blocks = %llu\n",
> +                       (unsigned long long)inode->i_blocks);
>         mlog(0, "inode->ip_clusters = %u\n", OCFS2_I(inode)->ip_clusters);
>
>         /* call the kernels journal init function now */
> @@ -848,8 +849,9 @@ static int ocfs2_force_read_journal(stru
>
>         memset(bhs, 0, sizeof(struct buffer_head *) * CONCURRENT_JOURNAL_FILL);
>
> -       mlog(0, "Force reading %lu blocks\n",
> -            (inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9)));
> +       mlog(0, "Force reading %llu blocks\n",
> +               (unsigned long long)(inode->i_blocks >>
> +                       (inode->i_sb->s_blocksize_bits - 9)));
>
>         v_blkno = 0;
>         while (v_blkno <
> diff -puN fs/ocfs2/namei.c~2tb-files-add-blkcnt_t-fixes fs/ocfs2/namei.c
> --- devel/fs/ocfs2/namei.c~2tb-files-add-blkcnt_t-fixes 2006-01-13 22:22:50.000000000 -0800
> +++ devel-akpm/fs/ocfs2/namei.c 2006-01-13 22:27:18.000000000 -0800
> @@ -1443,8 +1443,9 @@ static int ocfs2_create_symlink_data(str
>          * write i_size + 1 bytes. */
>         blocks = (bytes_left + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
>
> -       mlog_entry("i_blocks = %lu, i_size = %llu, blocks = %d\n",
> -                      inode->i_blocks, i_size_read(inode), blocks);
> +       mlog_entry("i_blocks = %llu, i_size = %llu, blocks = %d\n",
> +                       (unsigned long long)inode->i_blocks,
> +                       i_size_read(inode), blocks);
>
>         /* Sanity check -- make sure we're going to fit. */
>         if (bytes_left >
> diff -puN fs/cifs/file.c~2tb-files-add-blkcnt_t-fixes fs/cifs/file.c
> diff -puN fs/cifs/readdir.c~2tb-files-add-blkcnt_t-fixes fs/cifs/readdir.c
> --- devel/fs/cifs/readdir.c~2tb-files-add-blkcnt_t-fixes        2006-01-13 22:24:02.000000000 -0800
> +++ devel-akpm/fs/cifs/readdir.c        2006-01-13 22:24:45.000000000 -0800
> @@ -197,10 +197,10 @@ static void fill_in_inode(struct inode *
>
>         if (allocation_size < end_of_file)
>                 cFYI(1, ("May be sparse file, allocation less than file size"));
> -       cFYI(1,
> -            ("File Size %ld and blocks %ld and blocksize %ld",
> -             (unsigned long)tmp_inode->i_size, tmp_inode->i_blocks,
> -             tmp_inode->i_blksize));
> +       cFYI(1, ("File Size %ld and blocks %llu and blocksize %ld",
> +               (unsigned long)tmp_inode->i_size,
> +               (unsigned long long)tmp_inode->i_blocks,
> +               tmp_inode->i_blksize));
>         if (S_ISREG(tmp_inode->i_mode)) {
>                 cFYI(1, ("File inode"));
>                 tmp_inode->i_op = &cifs_file_inode_ops;

--
Coywolf Qi Hunt
