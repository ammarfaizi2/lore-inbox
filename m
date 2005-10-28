Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVJ1KgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVJ1KgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVJ1KgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:36:21 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:47825 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964888AbVJ1KgV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:36:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGjtICBu+nAvFbCyfQ28EaEnmYTg1FGkg4nRpoMC+IF+Su73dWyeEw/f0Jdz/Q+yVp4bS+fErbJ67QBVtKdGEhaO+MxrR8Cgml1ldngH+pWV3IwHrzo4mVr5wixjbrBV+nmCY/85vxsxCPdRXte5C0j+/tfMm/CV15GC4a3FoAs=
Message-ID: <750c918d0510280336g67344787r66a9aba4753e22cb@mail.gmail.com>
Date: Fri, 28 Oct 2005 08:36:20 -0200
From: Davi Arnaut <davi.lkml@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20051027215312.57303595.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com>
	 <20051027215312.57303595.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Andrew Morton <akpm@osdl.org> wrote:
> Davi Arnaut <davi.lkml@gmail.com> wrote:
> >
> >  > It seems that something still tries to load the ext3 module, and I get the
> >  > BUG seen below.  If I remove the ext3 module and re-build the initrd,
> >  > the error goes away.
>
> Yes, I think the kernel is overreacting here.
>
> Manfred, what sayest thou?
>
> (nb: untested)
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> slab presently goes BUG if someone tries to register an already-registered
> cache.
>
> But this can happen if the user accidentally loads a module which is already
> statically linked into the kernel.  Nuking the kernel is rather a harsh
> reaction.
>
> Change it into a warning, and just fail the kmem_cache_alloc() attempt.  If
> the module is well-behaved, the modprobe will fail and all is well.

How about really fixing kmem_cache_* to use the proper return conventions ?
In this case it should have returned ERR_PTR(-EEXIST);

> Notes:
>
> - Swaps the ranking of cache_chain_sem and lock_cpu_hotplug().  Doesn't seem
>   important.
>
>
> <sniped>
>
