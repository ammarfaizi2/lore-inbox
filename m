Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUEKUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUEKUXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUEKUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:23:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:4495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263600AbUEKUWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:22:48 -0400
Date: Tue, 11 May 2004 13:22:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: maneesh@in.ibm.com
Cc: dipankar@in.ibm.com, torvalds@osdl.org, manfred@colorfullife.com,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040511132205.4b55292a.akpm@osdl.org>
In-Reply-To: <20041006125824.GE2004@in.ibm.com>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<20040508201259.GA6383@in.ibm.com>
	<20041006125824.GE2004@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> We can see this happening in the following numbers taken using dcachebench*
> gathered on 2-way P4 Xeon 2.4MHz SMP box with 4.5GB RAM. The benchmark was run
> with the following parameters and averaged over 10 runs.
> ./dcachebench -p 32 -b testdir
> 
> 		Average	microseconds/iterations 	Std. Deviation
> 		(lesser is better)
> 2.6.6		10204					161.5
> 2.6.6-mm1	10571					51.5
> 

Well..  this could be anything.  If the hash is any good -mm shouldn't be
doing significantly more locked operations.  (I think - didn't check very
closely).

Also the inode and dentry hash algorithms were changed in -mm.  You can
evaluate the effect of that by comparing 2.6.6 with current Linus -bk.

If we compare 2.6.6-bk with 2.6.6-mm1 and see a slowdown on SMP and no
slowdown on UP then yup, it might be due to additional locking.

But we should evaluate the hash changes separately.

Summary:

2.6.6-rc3:	baseline
2.6.6:		dentry size+alignment changes
2.6.6-bk: 	dentry size+alignment changes, hash changes
2.6.6-mm1:	dentry size+alignment changes, hash changes, lots of other stuff.
