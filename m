Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSKRX1h>; Mon, 18 Nov 2002 18:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266826AbSKRX1F>; Mon, 18 Nov 2002 18:27:05 -0500
Received: from rj.sgi.com ([192.82.208.96]:50074 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S266100AbSKRXZV>;
	Mon, 18 Nov 2002 18:25:21 -0500
Date: Tue, 19 Nov 2002 10:32:02 +1100
From: Nathan Scott <nathans@sgi.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.4 vmalloc.c get_vm_area
Message-ID: <20021118233202.GB535@frodo.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Alan,

I noticed you recently merged this patch with Marcelo in the
2.4 BK tree (lists you as author, and annotation says it came
from DaveM originally)...

        --- 1.10/mm/vmalloc.c   Tue Feb  5 06:10:20 2002
        +++ 1.11/mm/vmalloc.c   Thu Sep  5 05:22:42 2002
        @@ -177,6 +177,8 @@
                if (!area)
                        return NULL;
                size += PAGE_SIZE;
        +       if(!size)
        +               return NULL;
                addr = VMALLOC_START;
                write_lock(&vmlist_lock);
                for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {


This looks to me like it introduces a memory leak in the new !size
case - either the "size" bump and test needs to be moved before the
"area" kmalloc, or we need to kfree(area) before returning NULL.

If you like, I'll make a (trivial) patch to do one of these?

cheers.

-- 
Nathan
