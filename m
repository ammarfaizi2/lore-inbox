Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131036AbQKWXT0>; Thu, 23 Nov 2000 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129698AbQKWXTR>; Thu, 23 Nov 2000 18:19:17 -0500
Received: from [194.213.32.137] ([194.213.32.137]:15364 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S130987AbQKWXTF>;
        Thu, 23 Nov 2000 18:19:05 -0500
Date: Thu, 23 Nov 2000 00:49:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Address translation
Message-ID: <20001123004928.A96@toy>
In-Reply-To: <E13yhcO-0003qy-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13yhcO-0003qy-00@wisbech.cl.cam.ac.uk>; from Keir.Fraser@cl.cam.ac.uk on Wed, Nov 22, 2000 at 09:39:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> otherwise valid) I think the access macros are unnecessary. I would be
> *very* glad if someone could confirm this, or shoot me down. :)
> 
> For instance, a kernel module I am writing allocates some memory in
> the current process's address space as follows:
> 
>     down(&mm->mmap_sem);
>     s->table = (void **)get_unmapped_area(0, SIZEOF_TABLE);
>     if ( s->table != NULL )
>         do_brk((unsigned long)s->table, SIZEOF_TABLE);
>     up(&mm->mmap_sem);
> 
> Some questions:
>  (1) In a "top half" thread, can I now access this memory without the
>      access macros (since I know the address range is valid)?
>  (2) Can I also access this memory from an interrupt/exception
>      context, or must I lock it? (ie. can faults be handled from such
>      a context) 

poof! I've shooted you.

You may definitely access such memory from interrupt.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
