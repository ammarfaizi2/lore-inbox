Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318174AbSGQA2Z>; Tue, 16 Jul 2002 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSGQA2Y>; Tue, 16 Jul 2002 20:28:24 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32445 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318174AbSGQA2C>;
	Tue, 16 Jul 2002 20:28:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity 
In-reply-to: Your message of "Tue, 16 Jul 2002 00:40:42 -0400."
             <Pine.GSO.4.21.0207160036460.24417-100000@weyl.math.psu.edu> 
Date: Wed, 17 Jul 2002 10:04:44 +1000
Message-Id: <20020717003135.ACB2D4503@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0207160036460.24417-100000@weyl.math.psu.edu> you wri
te:
> On Tue, 16 Jul 2002, Rusty Russell wrote:
> 
> > Really?  Other than changing over to get_sb_psuedo(), what does your patch
> > fix?  As the filesystem should never be unmounted, what am I missing?
> > >  	filp->f_op = &futex_fops;
> > > -	filp->f_dentry = dget(futex_dentry);
> > > +	filp->f_vfsmnt = mntget(futex_mnt);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +	filp->f_dentry = dget(futex_mnt->mnt_root);
> 
> Uninitialized ->f_vfsmnt == quite a few places in the tree very unhappy.
> E.g. any access to /proc/<pid>/fd/<n>.

I figured out which ones I needed to set by rough inspection, always a
dangerous practice.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
