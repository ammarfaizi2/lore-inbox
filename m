Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWAXI62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWAXI62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWAXI62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:58:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030391AbWAXI61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:58:27 -0500
Date: Tue, 24 Jan 2006 00:58:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
Message-Id: <20060124005806.7e9ab02e.akpm@osdl.org>
In-Reply-To: <43D5F44C.76F0.0078.0@novell.com>
References: <43CE4C98.76F0.0078.0@novell.com>
	<20060120232500.07f0803a.akpm@osdl.org>
	<43D4BE7F.76F0.0078.0@novell.com>
	<20060123025702.1f116e70.akpm@osdl.org>
	<43D5F44C.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >- The `#ifdef CONFIG_NUMA' in init_timers_cpu() seems to be unnecessary -
> >  kmalloc_node() will use kmalloc() if !NUMA.
> 
> That is correct, but I wanted the fallback if kmalloc_node() fails (from briefly looking at that code it didn't
> seem like it would do such fallback itself). And calling kmalloc() twice if !NUMA seemed pointless.

I'm sorry, but how were we to know that?  Telepathy?

GFP_KERNEL for these size objects is pretty much infallible anyway, so I
wouldn't worry about it.  Or allocate all needed storage a little later in
boot with alloc_percpu().


> >- We prefer to do this:
> >
> >	if (expr) {
> >		...
> >	} else {
> >		...
> >	}
> >
> >  and not
> >
> >	if (expr) {
> >		...
> >	}
> >	else {
> >		...
> >	}
> 
> I can change that, too, but I don't see why this gets pointed out again and again when there really
> is no consistency across the entire kernel...
> 

We fix these things up when working on incorrectly laid-out code, but we
rarely bother raising a patch just to fix something like that.  We'll get
there eventually.
