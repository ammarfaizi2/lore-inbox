Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263878AbSITWgQ>; Fri, 20 Sep 2002 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbSITWgP>; Fri, 20 Sep 2002 18:36:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:41159 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263878AbSITWgP>;
	Fri, 20 Sep 2002 18:36:15 -0400
Message-ID: <3D8BA407.E2BFF7E8@digeo.com>
Date: Fri, 20 Sep 2002 15:41:11 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
References: <15755.14336.739277.700462@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 22:41:14.0875 (UTC) FILETIME=[D3A3E4B0:01C260F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> Hello,
> 
> Documentation/filesystems/Locking states that all super operations may
> block, but __set_page_dirty_buffers() calls
> 
>    __mark_inode_dirty()->s_op->dirty_inode()
> 
> under mapping->private_lock spin lock.

Actually it doesn't.  We do not call down into the filesystem
for I_DIRTY_PAGES.

set_page_dirty() is already called under locks, via __free_pte (pagetable
teardown).  2.4 does this as well.

But I'll make the change anyway.  I think it removes any
ranking requirements between mapping->page_lock and 
mapping->private_lock, which is always a nice thing.
