Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933400AbWKTLaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400AbWKTLaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933493AbWKTLaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:30:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:35889 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933400AbWKTLaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:30:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hqJCz9gubEepC2AeYthTt3DsMiGDTvg+Ak1jdECuvr1je3RrE/7Vr5xMgx/xOM8pj7PcpMQq+glEW6diXaTq0RCy/26uyvdytQJ4YvzetTebdg5z9H+dIi3SKCVuc40aqGRwWYExJN2H9myFLZ5pA06OryKmA6DoMsfqzyieLpM=
Message-ID: <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
Date: Mon, 20 Nov 2006 12:30:10 +0100
From: "Francis Moreau" <francis.moro@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: Re : vm: weird behaviour when munmapping
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com>
	 <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Fri, 17 Nov 2006, Francis Moreau wrote:
> > On Fri, 2006-11-17 at 14:12 +0000, moreau francis wrote:
> > > Peter Zijlstra wrote:
> > >
> > > The new object is the one allocated using:
> > > new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
> >
> > Of course but at this point the choice of the new VMA is already made
> > by the caller. So in our case do_munmap() decided that B is the new
> > one as you said. But I still don't see why...
>
> split_vma decides which address range will use the newly allocated
> vm_area_struct in such a way as to suit its own convenience, and

again I don't agree. I would say that do_munmap() decides which
address range will use the new allocated vma object. split_vma() get
this information through its parameter named "new_below".

> >
> > And as I said previously it will end up by calling consecutively:
> >
> >        vma->vm_ops->open(B)
> >        vma->vm_ops->close(B)
>
> You are attaching too much significance to the current address
> of the vma which is passed to your driver in open and close.
> As mmap.c splits and merges vmas, in response to system calls
> unmapping and mapping, those addresses will change.
>
> The important thing is the info contained within the vma: perhaps
> your underlying complaint is that your driver is not getting as
> much info as it wants about what's happening?
>

not really. I'm not writing a real driver. I just try to understand
how vma things work in Linux. Therefore I just wrote a dumb driver
which has modified vma open/close method in order to detect how these
method are called.

I end up to see "open(B), close(B)" sequence when unmapping a part of
the dumb device that I found strange. I think that "open(A') close(B)"
can give more information to the driver and reflect that B is unmapped
and A' is still mapped and becomes the new mapped area.
But it's may be just me...

thanks

Francis
