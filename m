Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTFACki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 22:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTFACkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 22:40:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62041 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261166AbTFACkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 22:40:37 -0400
Date: Sat, 31 May 2003 19:54:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk4+: oops by mc -v /proc/bus/pci/00/00.0
Message-Id: <20030531195414.10c957b7.akpm@digeo.com>
In-Reply-To: <20030531165523.GA18067@steel.home>
References: <20030531165523.GA18067@steel.home>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2003 02:53:59.0633 (UTC) FILETIME=[0D0D1410:01C327E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <fork0@users.sourceforge.net> wrote:
>
> MC (Midnight Commander 4.6.0 Gentoo) segfaults trying to mmap files
>  under /proc/bus/pci.

Thanks.  This will fix it up.

It's pretty lame.  Really we need a proper vma constructor
somewhere.

diff -puN mm/mmap.c~pci-mmap-fix mm/mmap.c
--- 25/mm/mmap.c~pci-mmap-fix	2003-05-31 19:49:20.000000000 -0700
+++ 25-akpm/mm/mmap.c	2003-05-31 19:49:35.000000000 -0700
@@ -677,6 +677,7 @@ munmap_back:
 	vma->vm_pgoff = pgoff;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
+	vma->vm_next = NULL;
 	INIT_LIST_HEAD(&vma->shared);
 
 	if (file) {

_

