Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUCPB6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUCPB4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:56:16 -0500
Received: from ns.suse.de ([195.135.220.2]:64172 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263404AbUCPByX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:54:23 -0500
Date: Tue, 16 Mar 2004 02:54:01 +0100
From: Andi Kleen <ak@suse.de>
To: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
Cc: raybry@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040316015401.GF9931@wotan.suse.de>
References: <20040313.135638.78732994.taka@valinux.co.jp> <JP20040316093003.3103921@pst.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JP20040316093003.3103921@pst.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +   pte = huge_pte_alloc(mm, address);
> +   set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);

This looks broken. Another CPU could have raced to the same fault
and already added an PTE here. You have to handle that.

(my i386 version originally had the same problem)


> +/*      update_mmu_cache(vma, address, *pte); */

I have not studied low level IA64 VM in detail, but don't you need
some kind of TLB flush here?

-Andi
