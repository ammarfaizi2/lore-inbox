Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSFJNEh>; Mon, 10 Jun 2002 09:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFJNEh>; Mon, 10 Jun 2002 09:04:37 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:16414 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314422AbSFJNEf>; Mon, 10 Jun 2002 09:04:35 -0400
Message-Id: <5.1.0.14.2.20020610140403.00b0bc60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 14:08:25 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 "I can't get no compilation"
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D049390.40101@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:54 10/06/02, Martin Dalecki wrote:
>Anton Altaparmakov wrote:
>>At 12:19 10/06/02, Martin Dalecki wrote:
>>
>>>The subject says it all...
>>>
>>>Contrary to other proposed patches I realized that there is
>>>no such thing as vmalloc_dma.
>>
>>Perhaps you ought to look in mm/vmalloc.c which contains:
>>void * vmalloc_dma (unsigned long size)
>>{
>>         return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
>>}
>>Or are you going to tell me that is a figment of my imagination?
>
>Oh I have missed the chunk which delets it there apparently, since
>*nobody* is using this.

It could be used by out of kernel tree code. (Note I don't know any code 
that does...)

>The only place where a special
>__vmalloc setup code is used in nfs which GFP_NOFS flag added,
>but not the above. so providing vmalloc_nofs would make more
>sense then vmalloc_dma.

NTFS defines its own vmalloc_nofs (fs/ntfs/malloc.h) so if you intend to 
add a generic vmalloc_nofs, please remove the ntfs one (or ntfs will break)...

btw. the ntfs definition is:

static inline void *vmalloc_nofs(unsigned long size)
{
         if (likely(size >> PAGE_SHIFT < num_physpages)
                 return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
         return NULL;
}

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

