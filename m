Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUCMExn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 23:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbUCMExn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 23:53:43 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:37840 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263043AbUCMExk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 23:53:40 -0500
Date: Sat, 13 Mar 2004 13:56:38 +0900 (JST)
Message-Id: <20040313.135638.78732994.taka@valinux.co.jp>
To: raybry@sgi.com
Cc: lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, n-yoshida@pst.fujitsu.com
Subject: Re: Hugetlbpages in very large memory machines.......
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <40528383.10305@sgi.com>
References: <40528383.10305@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My following patch might help you. It inclueds pagefault routine
for hugetlbpages. If you want to use it for your purpose, you need to
remove some code from hugetlb_prefault() that will call hugetlb_fault().
http://people.valinux.co.jp/~taka/patches/va01-hugepagefault.patch

But it's just for IA32.

I heard that n-yoshida@pst.fujitsu.com was porting this patch
on IA64.

> We've run into a scaling problem using hugetlbpages in very large memory machines, e. g. machines 
> with 1TB or more of main memory.  The problem is that hugetlbpage pages are not faulted in, rather 
> they are zeroed and mapped in in by hugetlb_prefault() (at least on ia64), which is called in 
> response to the user's mmap() request.  The net is that all of the hugetlb pages end up being 
> allocated and zeroed by a single thread, and if most of the machine's memory is allocated to hugetlb 
> pages, and there is 1 TB or more of main memory, zeroing and allocating all of those pages can take 
> a long time (500 s or more).
> 
> We've looked at allocating and zeroing hugetlbpages at fault time, which would at least allow 
> multiple processors to be thrown at the problem.  Question is, has anyone else been working on
> this problem and might they have prototype code they could share with us?
> 
> Thanks,
> -- 
> Best Regards,
> Ray


Thank you,
Hirokazu Takahashi.
