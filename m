Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSGXITz>; Wed, 24 Jul 2002 04:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318279AbSGXITz>; Wed, 24 Jul 2002 04:19:55 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:61633 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318277AbSGXITy>; Wed, 24 Jul 2002 04:19:54 -0400
Message-Id: <5.1.0.14.2.20020724091535.00b06770@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 24 Jul 2002 09:24:02 +0100
To: "Martin Brulisauer" <martin@uceb.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry
  repacement: generic_out_cast)
Cc: Joshua MacDonald <jmacd@namesys.com>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D3E75E9.28151.2A7FBB2@localhost>
References: <20020723220745.GD2090@reload.namesys.com>
 <20020723114703.GM11081@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:39 24/07/02, Martin Brulisauer wrote:
>On 24 Jul 2002, at 2:07, Joshua MacDonald wrote:
>I have one additional comment to the current implementation:
> >
> > #define TS_LINK_TO_ITEM(ITEM_TYPE,LINK_NAME,LINK) \
> >       ((ITEM_TYPE *)((char *)(LINK)-(unsigned long)(&((ITEM_TYPE 
> *)0)->LINK_NAME)))
>
>As long as your pointers are 32bit this seems to be ok. But on
>64bit implementations pointers are not (unsigned long) so this cast
>seems to be wrong.

On 64-bit architectures unsigned long is 64-bits so there is no problem. In 
fact the core kernel code _requires_ that unsigned long is large enough to 
fully contain the contents of a pointer. (E.g. look at linux/mm/memory.c, 
well really linux/mm/*.c for the tip of the iceberg).

Of course if one wanted to be really pedantic, one could replace the 
unsigned long typecasts with ptrdiff_t. But you would have to go through a 
_lot_ of code where the kernel currently casts between unsigned long and 
(mostly) void * to do this in a one off conversion.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

