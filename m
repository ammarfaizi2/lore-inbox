Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVA1CPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVA1CPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVA1CPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:15:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:37343 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261390AbVA1CPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:15:00 -0500
Date: Thu, 27 Jan 2005 18:14:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mingo@elte.hu, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
Message-Id: <20050127181433.0e63b463.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501271658460.2362@ppc970.osdl.org>
References: <20041116113209.GA1890@elte.hu>
	<419A7D09.4080001@bigpond.net.au>
	<20041116232827.GA842@elte.hu>
	<Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
	<20050127165330.6f388054.pj@sgi.com>
	<Pine.LNX.4.58.0501271658460.2362@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

True - thanks - including the part about the cost of locking bugs.

My question was poorly phrased - the code speaks the answer to the
real question I had:

  $ grep define.atomic_ include/asm-ia64/atomic.h | head -2
  #define atomic_read(v)          ((v)->counter)
  #define atomic_set(v,i)         (((v)->counter) = (i))

An atomic_read() of a one word counter on ia64 is just a load, and an
atomic_set() is just a store.  This is unlike the more difficult
atomic_inc, atomic_dec, atomic_add, atomic_mutilate, ... calls that
require something fancier, and I presume more painful for that CPUs
innards.

Good.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
