Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTE2SjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTE2SjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:39:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:18148 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262493AbTE2SjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:39:15 -0400
Date: Thu, 29 May 2003 11:52:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-Id: <20030529115237.33c9c09a.akpm@digeo.com>
In-Reply-To: <18080000.1054233607@[10.10.2.4]>
References: <20030527004255.5e32297b.akpm@digeo.com>
	<1980000.1054189401@[10.10.2.4]>
	<18080000.1054233607@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 18:52:33.0371 (UTC) FILETIME=[76ABCAB0:01C32613]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > SDET 128  (see disclaimer)
> >                            Throughput    Std. Dev
> >                2.5.66-mm2       100.0%         0.6%
> >           2.5.66-mm2-ext3         3.9%         0.4%
> > 
> > SDET 128  (see disclaimer)
> >                            Throughput    Std. Dev
> >           2.5.70-mm1-ext2       100.0%         0.1%
> >           2.5.70-mm1-ext3        22.7%         2.0%
> 
> Andrew pointed out I should turn off extended attributes, I reran
> like this ... not much change (with error margins)
> 
>  SDET 32  (see disclaimer)
>                            Throughput    Std. Dev
>           2.5.70-mm1-ext2       100.0%         0.2%
>           2.5.70-mm1-ext3        30.9%         7.8%
>           2.5.70-mm1-noxa        34.6%         6.5%

OK, a 10x improvement isn't too bad.  I'm hoping the gap between ext2 and
ext3 is mainly idle time and not spinning-on-locks time.


> 
>    2024927   267.3% total
>    1677960   472.8% default_idle
>     116350     0.0% .text.lock.transaction
>      42783     0.0% do_get_write_access
>      40293     0.0% journal_dirty_metadata
>      34251  6414.0% __down
>      27867  9166.8% .text.lock.attr

Bah.  In inode_setattr(), move the mark_inode_dirty() outside
lock_kernel().

>      20016  2619.9% __wake_up
>      19632   927.4% schedule
>      12204     0.0% .text.lock.sched
>      12128     0.0% start_this_handle
>      10011     0.0% journal_add_journal_head

hm, lots of context switches still.

