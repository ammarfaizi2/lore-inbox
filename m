Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUHDCXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUHDCXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUHDCXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:23:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267234AbUHDCWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:22:38 -0400
Date: Tue, 3 Aug 2004 22:22:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040804021332.GT2241@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408032221310.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Andrea Arcangeli wrote:

> > Normal hugetlb file creation (through the filesystem) isn't touched
> > by these patches.
> 
> it is:

Hugetlb file creation through the filesystem never calls
hugetlb_zero_setup!  What are you talking about ?

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

> this breaks local security if you set the rlimit to 1 byte (well, 1 byte
> == disable_cap_mlock).

Please read my incremental patch.  It adds a quota check
right after this code segment.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

