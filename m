Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUITUPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUITUPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUITUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:15:52 -0400
Received: from novell.stoldgods.nu ([193.45.238.241]:48281 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S264443AbUITUPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:15:50 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Date: Mon, 20 Sep 2004 22:15:04 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <200409201939.04207.> <20040920105836.3ed07df4.akpm@osdl.org>
In-Reply-To: <20040920105836.3ed07df4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409202215.10632.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sent first mail with wrong mail address..

On Monday 20 September 2004 19.58, Andrew Morton wrote:
> Magnus M‰‰tt‰ <magnus@php.net> wrote:
> > I'm getting
> >  *** Warning: "afs_file_page_mkwrite" [fs/afs/kafs.ko] undefined!
> >  when I build the kernel.
> >
> >  If I remove make-afs-use-cachefs.patch it works just fine.
>
> Like this, I guess.
>
> --- 25/fs/afs/file.c~afs-cachefs-dependency-fix 2004-09-20
> 10:56:28.714441752 -0700 +++ 25-akpm/fs/afs/file.c 2004-09-20
> 10:57:39.770639568 -0700
> @@ -33,7 +33,9 @@ static int afs_file_releasepage(struct p
>
>  static ssize_t afs_file_write(struct file *file, const char __user *buf,
>           size_t size, loff_t *off);
> +#ifdef CONFIG_AFS_CACHEFS
>  static int afs_file_page_mkwrite(struct page *page);
> +#endif
>
>  struct inode_operations afs_file_inode_operations = {
>   .getattr = afs_inode_getattr,
> @@ -56,7 +58,9 @@ struct address_space_operations afs_fs_a
>   .set_page_dirty = __set_page_dirty_nobuffers,
>   .releasepage = afs_file_releasepage,
>   .invalidatepage = afs_file_invalidatepage,
> +#ifdef CONFIG_AFS_CACHEFS
>   .page_mkwrite = afs_file_page_mkwrite,
> +#endif
>  };
>
> 
> /*****************************************************************************/ 

That fixed it, thanks!


/Magnus
