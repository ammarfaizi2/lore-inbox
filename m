Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVHJGGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVHJGGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 02:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVHJGGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 02:06:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10438 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965014AbVHJGGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 02:06:44 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <20050810055945.GB13926@redhat.com>
In-Reply-To: <20050810055945.GB13926@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 09:06:42 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F99973.00000BD6@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> 
>                  if (!dumping)
>                         down_read(&mm->mmap_sem);
> > > +
> > > +             for (vma = find_vma(mm, start); vma; vma = vma->vm_next)  {
> > > +                     if (end <= vma->vm_start)
> > > +                             break;
> > > +                     if (vma->vm_file &&
> > > +                         vma->vm_file->f_dentry->d_inode->i_sb == sb)  {
> > > +                             num_gh++;
> > > +                     }
> > > +             }
> > > +
> > > +             ghs = kmalloc((num_gh + 1) * sizeof(struct gfs2_holder),
> > > +                           GFP_KERNEL);
> > > +             if (!ghs) {
> > > +                     if (!dumping)
> > > +                             up_read(&mm->mmap_sem);
> > > +                     return -ENOMEM;
> > > +             }
> > > +
> > > +             for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
> > 
> > Sorry if this is an obvious question but what prevents another thread from 
> > doing mmap() before we do the second walk and messing up num_gh?  
> 
> mm->mmap_sem ?

Aah, I read that !dumping expression the other way around. Sorry and thanks. 

                           Pekka 

