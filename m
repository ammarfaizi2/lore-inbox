Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312824AbSCVUDE>; Fri, 22 Mar 2002 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312825AbSCVUCy>; Fri, 22 Mar 2002 15:02:54 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:28612 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312824AbSCVUCk>; Fri, 22 Mar 2002 15:02:40 -0500
Message-ID: <3C9B8DE5.7FF84BF3@attbi.com>
Date: Fri, 22 Mar 2002 14:02:45 -0600
From: Rakesh Tiwari <rakeshtiwari@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.19(xx) file unmapping on abort
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Relevant code -

../src/linux/mm/filemap.c
static void filemap_unmap(struct vm_area_struct *vma, unsigned long
start, size_t len)
{
    filemap_sync(vma, start, len, MS_ASYNC);
}


Question -

Does this imply that every time a process terminates abonormally, all
the dirty pages related to that mapping are flushed to the disk, even if
that was not intended ?  Why can not it be simply  this ? -

static void filemap_unmap(struct vm_area_struct *vma, unsigned long
start, size_t len)
{
    filemap_sync(vma, start, len, MS_INVALIDATE);
}

I call msync() at various points in the program where data in the pages
is known to be in good condition. At the abnormal program termination, I
am not really sure if data in pages is valid or not.....

Thank you.
Rakesh :-)

