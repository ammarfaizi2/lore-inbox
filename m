Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284818AbRLDAMK>; Mon, 3 Dec 2001 19:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284731AbRLDAHm>; Mon, 3 Dec 2001 19:07:42 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:47550 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S284501AbRLCMR7>; Mon, 3 Dec 2001 07:17:59 -0500
Message-ID: <3C0B6D00.DD403CB0@wanadoo.fr>
Date: Mon, 03 Dec 2001 13:16:00 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre2-devfs i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr> <200112030633.fB36Xf617997@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

 
> @@ -3243,11 +3246,17 @@
>      tlen = rpos - *ppos;
>      if (done)
>      {
> +       devfs_handle_t parent;
> +
>         spin_lock (&fs_info->devfsd_buffer_lock);
>         fs_info->devfsd_first_event = entry->next;
>         if (entry->next == NULL) fs_info->devfsd_last_event = NULL;
>         spin_unlock (&fs_info->devfsd_buffer_lock);
> -       for (; de != NULL; de = de->parent) devfs_put (de);
> +       for (; de != NULL; de = parent)
> +       {
> +           parent = de->parent;
> +           devfs_put (de);
> +       }
>         kmem_cache_free (devfsd_buf_cache, entry);
>         if (ival > 0) atomic_sub (ival, &fs_info->devfsd_overrun_count);
>         *ppos = 0;

I have just edited the fs/devfs/base.c in the 2.4.17-pre2 tree with the
change in the above lines. 

It boots and looks OK.

I have to switch off devfs=dall it keeps repeating the same message
endlessly. I'm going to be short in HD capacity.

Regards 

Pierre
_________________________________________________________
Dec  3 13:07:34 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:34 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:34 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:34 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:34 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:35 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:36 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:36 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
Dec  3 13:07:36 milou kernel: devfs: d_delete(): dentry: cfd45484 
inode: cfc13bf4  devfs_entry: cfc143ac 
Dec  3 13:07:36 milou kernel: devfs: d_delete(): dentry: cd15bba4 
inode: ccdb2d9c  devfs_entry: cfc14324 
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
