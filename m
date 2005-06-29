Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVF2Ktk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVF2Ktk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVF2Ktk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:49:40 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:16026 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262513AbVF2Ktc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:49:32 -0400
Date: Wed, 29 Jun 2005 19:49:59 +0900 (JST)
Message-Id: <20050629.194959.98866345.taka@valinux.co.jp>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <42BF9CD1.2030102@yahoo.com.au>
References: <42BF9CD1.2030102@yahoo.com.au>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Your patches improve the performance if lots of processes are
accessing the same file at the same time, right?

If so, I think we can introduce multiple radix-trees instead,
which enhance each inode to be able to have two or more radix-trees
in it to avoid the race condition traversing the trees.
Some decision mechanism is needed which radix-tree each page
should be in, how many radix-tree should be prepared.

It seems to be simple and effective.

What do you think?

> Now the tree_lock was recently(ish) converted to an rwlock, precisely
> for such a workload and that was apparently very successful. However
> an rwlock is significantly heavier, and as machines get faster and
> bigger, rwlocks (and any locks) will tend to use more and more of Paul
> McKenney's toilet paper due to cacheline bouncing.
> 
> So in the interest of saving some trees, let's try it without any locks.
> 
> First I'll put up some numbers to get you interested - of a 64-way Altix
> with 64 processes each read-faulting in their own 512MB part of a 32GB
> file that is preloaded in pagecache (with the proper NUMA memory
> allocation).

Thanks,
Hirokazu Takahashi.

