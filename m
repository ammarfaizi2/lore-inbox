Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVCYWEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVCYWEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVCYWBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:01:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:23465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbVCYV4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:56:35 -0500
Date: Fri, 25 Mar 2005 13:56:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: andrea@suse.de, mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050325135630.28cd492c.akpm@osdl.org>
In-Reply-To: <1111607584.5786.55.camel@localhost.localdomain>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
> 2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
> hours the system hit OOM, and OOM keep killing processes one by one. I
> could reproduce this problem very constantly on a 2 way PIII 700MHZ with
> 512MB RAM. Also the problem could be reproduced on running the same test
> on reiser fs.
> 
> The fsx command is:
> 
> ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &

I was able to reproduce this on ext3.  Seven instances of the above leaked
10-15MB over 10 hours.  All of it permanently stuck on the LRU.

I'll continue to poke at it - see what kernel it started with, which
filesystems it affects, whether it happens on UP&&!PREEMPT, etc.  Not a
quick process.

Given that you also saw it on reiserfs, it might be a bug in the core
mmap/truncate/unmap handling.  We'll see.

> I also see fsx tests start to generating report about read bad data
> about the tests have run for about 9 hours(one hour before of the OOM
> happen). 

I haven't noticed anything like that.
