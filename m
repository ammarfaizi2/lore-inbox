Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUHDC1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUHDC1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUHDC1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:27:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:21728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267232AbUHDCZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:25:43 -0400
Date: Tue, 3 Aug 2004 19:25:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803192537.B1924@build.pdx.osdl.net>
References: <20040804015350.GS2241@dualathlon.random> <Pine.LNX.4.44.0408032157160.5948-100000@dhcp83-102.boston.redhat.com> <20040804021332.GT2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040804021332.GT2241@dualathlon.random>; from andrea@suse.de on Wed, Aug 04, 2004 at 04:13:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> diff -purN linux-2.6.7/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
> --- linux-2.6.7/fs/hugetlbfs/inode.c    2004-07-29 11:36:55.744448953
> +0200
> +++ linux/fs/hugetlbfs/inode.c  2004-07-29 11:38:04.292595263 +0200
> @@ -722,7 +722,7 @@ struct file *hugetlb_zero_setup(size_t s
>         struct qstr quick_string;
>         char buf[16];
> 
> -       if (!capable(CAP_IPC_LOCK))
> +       if (!can_do_mlock())
>                 return ERR_PTR(-EPERM);
> 
>         if (!is_hugepage_mem_enough(size))
> 
> this breaks local security if you set the rlimit to 1 byte (well, 1 byte
> == disable_cap_mlock).

Right, that's true only for SHM_HUGETLB though, which uses
hugetlb_zero_setup.  And _that_ bit is what Rik's follow on patch is
trying to fix.  The normal hugetlbfs method using mmap() is unaffected,
AFAICT.  And has always been pretty open to using all of max_huge_pages.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
