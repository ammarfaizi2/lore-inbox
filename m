Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318011AbSGLVSm>; Fri, 12 Jul 2002 17:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318012AbSGLVSl>; Fri, 12 Jul 2002 17:18:41 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:7692 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S318011AbSGLVSk>; Fri, 12 Jul 2002 17:18:40 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: Dave Jones <davej@suse.de>
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity 
cc: pmenage@ensim.com
In-reply-to: Your message of "Fri, 12 Jul 2002 22:58:28 +0200."
             <20020712225828.E18503@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jul 2002 14:21:04 -0700
Message-Id: <E17T7qa-0007FC-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Jul 12, 2002 at 01:38:35PM -0700, Paul Menage wrote:
>
> > -		dentry->d_vfs_flags |= DCACHE_REFERENCED;
> > +#ifdef CONFIG_SMP
> > +		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
> > +#endif
> > +			dentry->d_vfs_flags |= DCACHE_REFERENCED;
>
>Yuck. Is doing this conditional on UP really a measurable effect?

I'm don't know yet - I did some brief tests on x86 UP to see how much
positive/negative effect the branch misses versus the cache dirtying
had, and (using an exponentially decaying distribution of entries being
tested/set) the if() statement did show an improvement for sufficiently
skewed distributions. But I've no idea yet how that matches up to the
distributions that we'd see in the dcache in actual use.

As I said in an earlier email, it might be nice to have an
__ensure_bit_set() function that uses architecture-specific knowledge to
make sure a particular bit is set as efficiently as possible. (e.g.
taking advantage of predicated writes, etc).

>If you must microoptimise
>to this level, at least try and keep the code clean.

Sure - this is just a quick [RFC] hack.

Paul

