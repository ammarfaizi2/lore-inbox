Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWDYUL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWDYUL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWDYUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:11:56 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:33189 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S1751414AbWDYULz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:11:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAALseTkSIbgEKDio
From: Bongani Hlope <bhlope@mweb.co.za>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 22:11:52 +0200
User-Agent: KMail/1.9.1
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il>
In-Reply-To: <444E524A.10906@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252211.52474.bhlope@mweb.co.za>
X-Original-Subject: Re: Compiling C++ modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 18:46, Avi Kivity wrote:
> Should you want to allocate from the heap, try this:
>
> {
>     spinlock_t::guard g(some_lock);
>     auto_ptr<Foo> item(new (gfp_mask) Foo);   /* or pass a kmem_cache_t */
>     item->do_something();
>     item->do_something_else();
>     return item.release();
> }
>

I love C++, but you have to stop it now. Imagine how many auto_ptr<Foo> will 
you use inside your kernel. The compiler will need to create a separete class 
for each. Using templates in the kernel will be plain silly.
