Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282923AbRK0UBs>; Tue, 27 Nov 2001 15:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282921AbRK0UBk>; Tue, 27 Nov 2001 15:01:40 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:18330 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282923AbRK0UBR>; Tue, 27 Nov 2001 15:01:17 -0500
Message-Id: <5.1.0.14.2.20011127195843.00b19bd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 27 Nov 2001 20:00:49 +0000
To: Martin Donnelly <martin@ramix.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: BUG slab.c, buffer.c
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1006886788.27769.2.camel@inchgower>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:46 27/11/01, Martin Donnelly wrote:
>I noticed strange behaviour recently with a driver i'm developing and
>tried to replicate it in a simple module to determine if it was my
>driver or a kernel bug. Basically i allocate 120k with kmalloc then
>initialising this memory i get the following oops. (I've tried this on
>several machines with the same results)
>
>Any ideas what is wrong?
>[snip of oopsen]
>The code being use to generate this is:
>
>int init_module(void)
>{
>     addr = kmalloc(GFP_KERNEL, mem_size);
>     if(addr != NULL)
>     {
>         u8      *byte;
>         u32     ix;
>
>         byte = addr;
>         for(ix = 0; ix < mempage_size; ix++)

Is mem_size >= mempage_size?

Anton

>         {
>             *byte = 0;
>             byte++;
>         }
>     }
>     return 0;
>}
>
>
>
>
>--
>Martin Donnelly                                Senior Software Engineer
>                                                RAMiX Europe Ltd
>99 little bugs in the code, 99 bugs in the code,
>fix one bug, compile it again...
>101 little bugs in the code....
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

