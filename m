Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSKFMMo>; Wed, 6 Nov 2002 07:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSKFMMn>; Wed, 6 Nov 2002 07:12:43 -0500
Received: from mail.zmailer.org ([62.240.94.4]:5532 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265002AbSKFMMn>;
	Wed, 6 Nov 2002 07:12:43 -0500
Date: Wed, 6 Nov 2002 14:19:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Pannaga Bhushan <bhushan@multitech.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A hole in kernel space!
Message-ID: <20021106121918.GJ26330@mea-ext.zmailer.org>
References: <3DC903BE.F4CD5A52@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC903BE.F4CD5A52@multitech.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 05:27:50PM +0530, Pannaga Bhushan wrote:
> Hi all,
>         I am looking for a setup where I need to have a certain amount
> of data always available to the kernel. The size of data I am looking at
> is abt 40MB(preferably, but I will settle for 20MB too) . So the normal
> kmalloc will not help me.

  Will  vmalloc()  help ?  The allocated memory is in special
  vmalloc address space (which is limited!) within the kernel,
  but accesses to it go via page-mapping tables, thus while it
  is virtually contiguous, physically it might be well scattered.

  What properties do you need, to be exact ?

  You are writing some sort of a device driver for a device that
  has somewhat stupid direct-memory-access facilities ?

> if yes, are the pages corresponding to this region swappable or
> is it that since this hole appears in kernel image, it is locked to a
> physical space and this is never swapped. (basically, i want by data
> in kernel space always available to kernel without having to bother
> abt swapping the pages back)

  Both  kmalloc()  and  vmalloc()  allocate kernel space memory that
  is unswappable, and therefore can not be allocated in excessive
  amounts.

  Doing things in BIGMEM fashion will let you have gigabytes of
  in-core memory, but to access it, you must go thru the hoops
  (in i686 architecture) each time you access a page of it.

> Thanx in advance,
> Pannaga Bhushan

/Matti Aarnio
