Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSHPEQD>; Fri, 16 Aug 2002 00:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSHPEQD>; Fri, 16 Aug 2002 00:16:03 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:21951 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S318148AbSHPEQC>; Fri, 16 Aug 2002 00:16:02 -0400
Date: Fri, 16 Aug 2002 13:19:22 +0900 (JST)
Message-Id: <20020816.131922.730554388.nomura@hpc.bs1.fc.nec.co.jp>
To: akpm@zip.com.au
Cc: hugh@veritas.com, j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
From: j-nomura@ce.jp.nec.com
In-Reply-To: <3D5C0D3D.E68137BA@zip.com.au>
References: <Pine.LNX.4.44.0208151515420.1610-100000@localhost.localdomain>
	<3D5C0995.CEE36FC8@zip.com.au>
	<3D5C0D3D.E68137BA@zip.com.au>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the solutions.
Your first patch seems to fix the problem in 2.4.

As to the second fix from 2.5.32, it can't be applicable to 2.4, can it?
try_to_swap_out() may call add_to_swap_cache() with PG_lru page.

From: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.18(19) swapcache oops
Date: Thu, 15 Aug 2002 13:21:17 -0700

> In 2.5, it is effectively:
> 
> void lru_cache_add(struct page * page)
> {
>         spin_lock(&pagemap_lru_lock);
>         if (TestSetPageLRU(page))
>                 BUG();
>         add_page_to_inactive_list(page);
>         spin_unlock(&pagemap_lru_lock);
> }
> 
> which is what should be tested in 2.4.  It's stricter, and significantly
> faster.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
