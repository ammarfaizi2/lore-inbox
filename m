Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319277AbSHVBmd>; Wed, 21 Aug 2002 21:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319278AbSHVBmd>; Wed, 21 Aug 2002 21:42:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31498 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319277AbSHVBmc>;
	Wed, 21 Aug 2002 21:42:32 -0400
Message-ID: <3D644512.585BF69D@zip.com.au>
Date: Wed, 21 Aug 2002 18:57:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Smith <asmith@umdgrb.umd.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ENOMEM in do_get_write_access, retrying.
References: <Pine.LNX.4.33.0208212133070.7748-100000@umdgrb.umd.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Smith wrote:
> 
> ENOMEM in do_get_write_access, retrying.
> ENOMEM in do_get_write_access, retrying.
> ENOMEM in do_get_write_access, retrying.
> ENOMEM in journal_alloc_journal_head, retrying.
> ENOMEM in do_get_write_access, retrying.
> ENOMEM in do_get_write_access, retrying.
> 
> Hi All,
> 
> I am getting a bunch of these in my messages file while cp'ing
> files from one computer 2 another. Both machines have 3c996 gigabit
> and large disk arrays. The computer with the errors is receiving the
> files.
> 

Your gigE NIC gobbled up all the free memory.  ext3 is stuck
in a corner where it just _has_ to allocate some memory, so it
retries the allocation.

bdflush or nfsd or kswapd write some memory back to disk, it
becomes reclaimable and ext3 is happy.

We should kill that printk.
