Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbVI1GfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbVI1GfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVI1GfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:35:03 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:62640 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751058AbVI1GfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:35:02 -0400
Date: Wed, 28 Sep 2005 15:35:01 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: pj@sgi.com, taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
In-Reply-To: <1127812937.5174.6.camel@npiggin-nld.site>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<1127812937.5174.6.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050928063501.89B5A70041@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 19:22:17 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> It could have come a long way since then, but this code looks
> much neater than the code I reviewed.

I'm glad to hear that!  But the cpu resource controller has
some problems, for example:

- The controller only controls the time_slice value and doesn't
  care the balance of cpus (the controller leaves balancing to 
  the existing balancing code in the scheduler).  So far I don't
  have any good idea to solve this.

- The controller holds a spinlock once per 1 second.  I don't
  know this is permissive or not, but the current scheduler
  doesn't hold any spinlocks normally, so...

-- 
KUROSAWA, Takahiro
