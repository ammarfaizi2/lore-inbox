Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVIWSvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVIWSvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVIWSvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:51:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5524
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751145AbVIWSvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:51:05 -0400
Date: Fri, 23 Sep 2005 11:50:58 -0700 (PDT)
Message-Id: <20050923.115058.63342389.davem@davemloft.net>
To: kiran@scalex86.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050923184052.GA4103@localhost.localdomain>
References: <20050923062529.GA4209@localhost.localdomain>
	<20050923001013.28b7f032.akpm@osdl.org>
	<20050923184052.GA4103@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravikiran G Thirumalai <kiran@scalex86.org>
Date: Fri, 23 Sep 2005 11:40:52 -0700

> As for the benchmarks, tbench on lo was used indicatively.  lo performance
> does matter for quite a few benchmarks. There are apps which do use lo 
> extensively.  The dst and netdevice changes were made after profiling such 
> real wold apps.  Agreed, per-cpufication of objects which can go up in 
> size is not the right approach on hindsight, but netdevice.refcount is not 
> one of those.  I can try running a standard mpi benchmark or some
> other indicative benchmark if that would help?

I worry about real life sites, such as a big web server, that will by
definition have hundreds of thousands of routing cache (and thus
'dst') entries active.

The memory usage will increase, and that's particularly bad in this
kind of case because unlike the 'lo' benchmarks you won't have nodes
and cpus fighting over access to the same routes.  In such a load
the bigrefs are just wasted memory and aren't actually needed.

I really would like to encourage a move away from this fascination
with optimizating the loopback interface performance on enormous
systems, yes even if it is hit hard by the benchmarks.  It just
means the benchmarks are wrong, not that we should optimize for
them.
