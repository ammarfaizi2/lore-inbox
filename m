Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVCaLgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVCaLgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCaLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:36:31 -0500
Received: from ns.suse.de ([195.135.220.2]:58797 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261361AbVCaLgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:36:22 -0500
Date: Thu, 31 Mar 2005 13:36:21 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, blaisorblade@yahoo.it, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] x86_64: remove duplicated sys_time64
Message-ID: <20050331113621.GP1623@wotan.suse.de>
References: <20050330173216.426CFEFECF@zion> <20050331103834.GC1623@wotan.suse.de> <20050331211059.0ddc078c.sfr@canb.auug.org.au> <20050331111235.GL1623@wotan.suse.de> <20050331212516.64506156.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331212516.64506156.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 09:25:16PM +1000, Stephen Rothwell wrote:
> On Thu, 31 Mar 2005 13:12:35 +0200 Andi Kleen <ak@suse.de> wrote:
> >
> > On Thu, Mar 31, 2005 at 09:10:59PM +1000, Stephen Rothwell wrote:
> > > On Thu, 31 Mar 2005 12:38:34 +0200 Andi Kleen <ak@suse.de> wrote:
> > > >
> > > > Nack. The generic sys_time still writes to int, not long.
> > > > That is why x86-64 has a private one. Please keep that.
> > > 
> > > It writes to a time_t which is a __kernel_time_t which is a long on
> > > x86-64, isn't it?
> > 
> > At least in 2.6.10 it writes to int.
> 
> I was looking at current bk where it looks like this:
> 
> asmlinkage long sys_time(time_t __user * tloc)

Ok with that change the patch is ok.
> {
>         time_t i;
>         struct timeval tv;
> 
>         do_gettimeofday(&tv);
>         i = tv.tv_sec;
> 
>         if (tloc) {
>                 if (put_user(i,tloc))
>                         i = -EFAULT;
>         }
>         return i;
> }
> 
> I have no idea when it changed.
I was looking at an older tree, sorry.
-Andi
