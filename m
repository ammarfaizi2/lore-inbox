Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVLLEc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVLLEc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLLEc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:32:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751081AbVLLEc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:32:57 -0500
Date: Sun, 11 Dec 2005 20:32:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: oleg@tv-sign.ru, vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-Id: <20051211203226.4deafd59.akpm@osdl.org>
In-Reply-To: <20051212031053.GA8748@us.ibm.com>
References: <439889FA.BB08E5E1@tv-sign.ru>
	<20051209024623.GA14844@in.ibm.com>
	<4399D852.47E0BB4E@tv-sign.ru>
	<20051210151951.GA2798@in.ibm.com>
	<439B24A7.E2508AAE@tv-sign.ru>
	<20051212031053.GA8748@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> 1.	wmb() guarantees that any writes preceding the wmb() will
>  	be seen by the interconnect before any writes following the
>  	wmb().  But this applies -only- to the writes executed by
>  	the CPU doing the wmb().
> 
>  2.	rmb() guarantees that any changes seen by the interconnect
>  	preceding the rmb() will be seen by any reads following the
>  	rmb().  Again, this applies only to reads executed by the
>  	CPU doing the wmb().  However, the changes might be due to
>  	any CPU.
> 
>  3.	mb() combines the guarantees made by rmb() and wmb().

So foo_mb() in preemptible code is potentially buggy.

I guess we assume that a context switch accidentally did enough of the
right types of barriers for things to work OK.
