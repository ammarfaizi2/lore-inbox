Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSHPEZw>; Fri, 16 Aug 2002 00:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSHPEZw>; Fri, 16 Aug 2002 00:25:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318121AbSHPEZw>;
	Fri, 16 Aug 2002 00:25:52 -0400
Message-ID: <3D5C823A.4850F8B5@zip.com.au>
Date: Thu, 15 Aug 2002 21:40:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: j-nomura@ce.jp.nec.com
CC: hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
References: <3D5C0D3D.E68137BA@zip.com.au> <20020816.131922.730554388.nomura@hpc.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j-nomura@ce.jp.nec.com wrote:
> 
> Thank you for the solutions.
> Your first patch seems to fix the problem in 2.4.

You must have been able to reproduce it quite quickly.  But the
code has been like that for ages.  Why is that?  Are you testing
on an unusual machine?

> As to the second fix from 2.5.32, it can't be applicable to 2.4, can it?
> try_to_swap_out() may call add_to_swap_cache() with PG_lru page.

Ah, good point.  In 2.5, add_to_page_cache() does not add the
page to the LRU.  Anonymous pages are already there, and we
don't need to do that.  The first patch should be OK.
