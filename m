Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbRGRSdp>; Wed, 18 Jul 2001 14:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRSde>; Wed, 18 Jul 2001 14:33:34 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:23537 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267867AbRGRSd1>; Wed, 18 Jul 2001 14:33:27 -0400
Message-Id: <5.1.0.14.2.20010718191532.00b01140@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 18 Jul 2001 19:34:09 +0100
To: Rajeev Bector <rajeev_bector@yahoo.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: vmalloc and kiobuf questions ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010718174612.48434.qmail@web14405.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:46 18/07/2001, Rajeev Bector wrote:
>MM Gurus,

I am definitely not an MM guru but I can try and answer one of your 
questions...

>   In trying to understand how to map driver
>memory into user space memory, I have the following
>questions:
>
>1) Is there a limit to how much memory
>    I can allocate using vmalloc() ?
>    (This is regular RAM)

First of all, note that vmalloc() allocates memory in multiples of PAGE_SIZE.

The maximum you can request is given by (num_physpages << PAGE_SHIFT). - 
You need to #include <linux/mm.h>; to get num_physpages.

In fact, before calling vmalloc(), you are well advised to check that you 
are not calling it with a size which rounded up to PAGE_SIZE is beyond 
above stated maximum, otherwise the result is a call to BUG()...

Also, it is a bad idea to call vmalloc() with a zero size as this results 
in a call to BUG(), too.

You can look at linux/mm/vmalloc.c::__vmalloc() for the test it performs 
and to see it calling BUG()...

As an aside, it may be of interest to know that the pages returned by 
vmalloc() can be HIGHMEM ones. If you don't want that you can use vmalloc_32().

I will leave your other questions to the real MM gurus...

Hope this helps,

         Anton

>2) I want to map the vmalloc'ed memory
>    to user space via mmap(). I've read
>    that remap_page_range() will not do it
>    and I have to do it using nopage
>    handlers ? Is that true ? Is there
>    a simple answer to why is that the case ?
>
>3) I've also read the kiobufs will simplify
>    all this. Is there a documentation on
>    kiobufs - what they can and cannot do ?
>    Are kiobufs part of the standard kernel
>    now ?
>Thanks in advance for your answers !
>
>Rajeev
>
>
>__________________________________________________
>Do You Yahoo!?
>Get personalized email addresses from Yahoo! Mail
>http://personal.mail.yahoo.com/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

