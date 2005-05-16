Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVEPNQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVEPNQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVEPNQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:16:42 -0400
Received: from [80.247.74.3] ([80.247.74.3]:7359 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261545AbVEPNQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:16:38 -0400
Message-Id: <6.2.1.2.2.20050516150628.06682cd0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 15:16:28 +0200
To: Michael Tokarev <mjt@tls.msk.ru>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42889890.8090505@tls.msk.ru>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
 <42889890.8090505@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14.56 16/05/2005, Michael Tokarev wrote:

>Roberto Fichera wrote:
> > Hi All,
> >
> > I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
> > I whould like to know the way how to use all the memory in a single
> > process, the application is a big simulation which needs big memory
> > chuncks.
> > I have readed about hugetlbfs, shmfs and tmpfs, but don't understand how
> > I can access
> > the whole memory. Ok! I can create a big file on tmpfs using shm_open() and
> > than map it by using mmap() or mmap2() but how can I access over 4GB using
> > standard pointers (if I had to use it)?
>
>There's no "standard" and simple way to utilize more than 4Gb memory on
>i386 hardware, especially in a userspace.  That is, the size of a pointer
>is 32bits, which is 4GB addresspace maximum.  i386 architecture just can't
>have a pointer of greather size.
>
>All "extra" (>4GB) space can be used like a file in a filesystem, not like
>a plain memory.  Think of read()/write() (or pread()/pwrite() for that 
>matter),
>but much faster ones compared to disk-based storage -- in tmpfs.  You can
>also mmap() *parts* of such a file, but will be still limited to 4GB at
>once -- in order to have more, you will have to unmap() something.
>
>All the "large applications" (most notable large database systems such as
>Oracle) can't use more than 4GB memory directly, but can utilize it for
>database cache.  In directly-addressible space there's a "table of content"
>of cached buffers is keept, and when a buffer is needed, it is mmap()'ed
>into the application's address space, and unmapped right away when it isn't
>needed anymore (but it is still in memory).

I was thinking to create as many object I need by the usual shm_open(), 
than mmap()
it on a process until I get ENOMEM. So, when I get a ENOMEM I start to
munmap() objects in order to free some user space memory and create the needed
space to complete mmap() for the requested object.

>Ofcourse you can't have
>usual pointers into that memory, but you can use something like
>(block-number,offset) instead of a pointer (pagetables).

Could you explain better this approch?


>/mjt
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera. 

