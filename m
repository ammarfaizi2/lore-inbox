Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSI2EoH>; Sun, 29 Sep 2002 00:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262393AbSI2EoH>; Sun, 29 Sep 2002 00:44:07 -0400
Received: from packet.digeo.com ([12.110.80.53]:59808 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262392AbSI2EoG>;
	Sun, 29 Sep 2002 00:44:06 -0400
Message-ID: <3D968652.28AD6766@digeo.com>
Date: Sat, 28 Sep 2002 21:49:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma->shared list_head initializations
References: <20020928234930.F13817@bitchcake.off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 04:49:22.0608 (UTC) FILETIME=[94427B00:01C26773]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> 
> more list_head debugging carnage.
> 

yup

> --- linux-2.5.39/fs/exec.c.fmuta        Sat Sep 28 19:50:20 2002
> +++ linux-2.5.39/fs/exec.c      Sat Sep 28 19:51:08 2002
> @@ -400,6 +400,7 @@
>                 mpnt->vm_ops = NULL;
>                 mpnt->vm_pgoff = 0;
>                 mpnt->vm_file = NULL;
> +               INIT_LIST_HEAD(&mpnt->shared);
>                 mpnt->vm_private_data = (void *) 0;
>                 insert_vm_struct(mm, mpnt);
>                 mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;

Fair enough, short-term.  But what your patch is really saying
is "this code stinks".

We need to lose all those open-coded accesses to vm_area_cachep,
give that cache a constructor and possibly write some helper
functions.  To lose all this fragile "did I remember to
initialise everything and has anyone added any more fields
since I wrote that code" gunk.

<looks hopefully at Christoph>
