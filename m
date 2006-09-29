Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWI2D3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWI2D3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbWI2D3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:29:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161291AbWI2D3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:29:33 -0400
Date: Thu, 28 Sep 2006 20:29:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-Id: <20060928202931.dc324339.akpm@osdl.org>
In-Reply-To: <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 23:19:11 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Thu, 28 Sep 2006 01:46:23 PDT, Andrew Morton said:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> 
> Yowza.  This has been one of the most unstable -mm I've personally tried since
> 2.6.0 came out (and I've tried to give each and every single one a shot).
> 
> Something is giving cache_alloc_refill() massive indigestion, I'm taking
> lots of oopsen in it.  Usually within 5-10 minutes I'm dead in the water.

Could be anything I'm afraid.  But you're the first to report it, so there's
something distinct in your .config or hardware.  

Whose idea was it to make it a monolithic kernel??

> >From an untainted kernel:
> 
> Sep 28 21:51:59 turing-police kernel: [  526.046000] BUG: unable to handle kernel paging request at virtual address 00100104
> Sep 28 21:51:59 turing-police kernel: [  526.046000]  printing eip:
> Sep 28 21:51:59 turing-police kernel: [  526.046000] c0150c43
> Sep 28 21:51:59 turing-police kernel: [  526.046000] *pde = 00000000
> 
> as far as it got logging it to disk - at that point the machine locked up
> hard, even alt-sysrq was dead, had to power-cycle. Long time since that
> happened.  Admittedly, that's not much to go on, but it shows that I'm having
> issues in cache_alloc_refill() even when untainted.  I'll probably get more
> complete untainted traces while playing  bisect-the-mm tomorrow....

bisecting would be good, thanks.  It might be quicker to strip down the .config
though.

