Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVARM0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVARM0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVARM0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:26:51 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:1966 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261276AbVARM0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:26:49 -0500
Date: Tue, 18 Jan 2005 21:21:18 +0900 (JST)
Message-Id: <20050118.212118.102612494.taka@valinux.co.jp>
To: clameter@sgi.com
Cc: kenneth.w.chen@intel.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [1/8]: hugetlb fault handler
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.58.0410251826430.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0410251826430.12962@schroedinger.engr.sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> ChangeLog
> 	* provide huge page fault handler and related things

<snip>

> Index: linux-2.6.9/fs/hugetlbfs/inode.c
> ===================================================================
> --- linux-2.6.9.orig/fs/hugetlbfs/inode.c	2004-10-18 14:55:07.000000000 -0700
> +++ linux-2.6.9/fs/hugetlbfs/inode.c	2004-10-21 14:50:14.000000000 -0700
> @@ -79,10 +79,6 @@
>  	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
>  		goto out;
> 
> -	ret = hugetlb_prefault(mapping, vma);
> -	if (ret)
> -		goto out;
> -
>  	if (inode->i_size < len)
>  		inode->i_size = len;
>  out:

hugetlbfs_file_mmap() may fail with a weird error, as it returns
uninitialized variable "ret".


Thanks.
Hirokazu Takahashi.
