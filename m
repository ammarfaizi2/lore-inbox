Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVHJFzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVHJFzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 01:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVHJFzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 01:55:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965011AbVHJFy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 01:54:59 -0400
Date: Wed, 10 Aug 2005 13:59:45 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050810055945.GB13926@redhat.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080203163cab015c@mail.gmail.com> <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 05:14:45PM +0300, Pekka J Enberg wrote:

                 if (!dumping)
                        down_read(&mm->mmap_sem);
> >+
> >+             for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
> >+                     if (end <= vma->vm_start)
> >+                             break;
> >+                     if (vma->vm_file &&
> >+                         vma->vm_file->f_dentry->d_inode->i_sb == sb) {
> >+                             num_gh++;
> >+                     }
> >+             }
> >+
> >+             ghs = kmalloc((num_gh + 1) * sizeof(struct gfs2_holder),
> >+                           GFP_KERNEL);
> >+             if (!ghs) {
> >+                     if (!dumping)
> >+                             up_read(&mm->mmap_sem);
> >+                     return -ENOMEM;
> >+             }
> >+
> >+             for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
> 
> Sorry if this is an obvious question but what prevents another thread from 
> doing mmap() before we do the second walk and messing up num_gh? 

mm->mmap_sem ?

