Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSIWTLH>; Mon, 23 Sep 2002 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSIWTKB>; Mon, 23 Sep 2002 15:10:01 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261337AbSIWSlr>;
	Mon, 23 Sep 2002 14:41:47 -0400
Message-ID: <3D8F447B.F8041C36@digeo.com>
Date: Mon, 23 Sep 2002 09:42:35 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
References: <3D8BA407.E2BFF7E8@digeo.com> <15759.16948.319035.270576@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 16:42:36.0303 (UTC) FILETIME=[38CFA1F0:01C26320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> Andrew Morton writes:
>  > Nikita Danilov wrote:
>  > >
>  > > Hello,
>  > >
>  > > Documentation/filesystems/Locking states that all super operations may
>  > > block, but __set_page_dirty_buffers() calls
>  > >
>  > >    __mark_inode_dirty()->s_op->dirty_inode()
>  > >
>  > > under mapping->private_lock spin lock.
>  >
>  > Actually it doesn't.  We do not call down into the filesystem
>  > for I_DIRTY_PAGES.
>  >
>  > set_page_dirty() is already called under locks, via __free_pte (pagetable
>  > teardown).  2.4 does this as well.
> 
> Cannot find __free_pte, it is only mentioned in comments in mm/filemap.c
> and include/asm-generic/tlb.h.
> 

It got moved around.  2.4: __free_pte(), 2.5: zap_pte_range().
