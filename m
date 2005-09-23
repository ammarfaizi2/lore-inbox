Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVIWWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVIWWhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVIWWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:37:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbVIWWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:36:59 -0400
Date: Fri, 23 Sep 2005 15:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: nickpiggin@yahoo.com.au, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: Make kzalloc a macro
Message-Id: <20050923153702.6194e53f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509231048530.22423@schroedinger.engr.sgi.com>
References: <4333A109.2000908@yahoo.com.au>
	<200509230909.54046.ioe-lkml@rameria.de>
	<4333B588.9060503@yahoo.com.au>
	<20050923.010939.11256142.davem@davemloft.net>
	<4333C4F4.9030402@yahoo.com.au>
	<2cd57c9005092302174e0f657e@mail.gmail.com>
	<Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0509231048530.22423@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> Make kzalloc a macro and use __GFP_ZERO for zeroed slab allocations
>

I'd question the usefulness of this.  It adds more code to a fastpath
(kmem_cache_alloc) so as to speed up a slowpath (kzalloc()) which is
already slow due to its memset.

It makes my kernel a bit fatter too - 150-odd bytes of text for some
reason.
