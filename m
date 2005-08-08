Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVHHOOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVHHOOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVHHOOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:14:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58789 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932071AbVHHOOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:14:54 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
In-Reply-To: <20050803063644.GD9812@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Mon, 08 Aug 2005 17:14:45 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> +static ssize_t walk_vm_hard(struct file *file, char *buf, size_t size,
> +                         loff_t *offset, do_rw_t operation)
> +{
> +     struct gfs2_holder *ghs;
> +     unsigned int num_gh = 0;
> +     ssize_t count;
> +
> +     {

Can we please get rid of the extra braces everywhere? 

[snip] 

David Teigland writes:
> +
> +             for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
> +                     if (end <= vma->vm_start)
> +                             break;
> +                     if (vma->vm_file &&
> +                         vma->vm_file->f_dentry->d_inode->i_sb == sb) {
> +                             num_gh++;
> +                     }
> +             }
> +
> +             ghs = kmalloc((num_gh + 1) * sizeof(struct gfs2_holder),
> +                           GFP_KERNEL);
> +             if (!ghs) {
> +                     if (!dumping)
> +                             up_read(&mm->mmap_sem);
> +                     return -ENOMEM;
> +             }
> +
> +             for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {

Sorry if this is an obvious question but what prevents another thread from 
doing mmap() before we do the second walk and messing up num_gh? 

> +                     if (end <= vma->vm_start)
> +                             break;
> +                     if (vma->vm_file) {
> +                             struct inode *inode;
> +                             inode = vma->vm_file->f_dentry->d_inode;
> +                             if (inode->i_sb == sb)
> +                                     gfs2_holder_init(get_v2ip(inode)->i_gl,
> +                                                      vma2state(vma),
> +                                                      0, &ghs[x++]);
> +                     }
> +             }

            Pekka 

