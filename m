Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUCAK6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUCAK6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:58:17 -0500
Received: from ns.suse.de ([195.135.220.2]:24003 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261199AbUCAK6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:58:15 -0500
Date: Mon, 1 Mar 2004 11:58:13 +0100
From: Andi Kleen <ak@suse.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6.4-rc1 fix x86 early_printk and make it early
Message-Id: <20040301115813.6194f2fe.ak@suse.de>
In-Reply-To: <m165dp9m2r.fsf@ebiederm.dsl.xmission.com>
References: <m165dp9m2r.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Feb 2004 22:24:12 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

>   o That is problematic with PAE support, because there is a moment
>     during paging_init() when the physical identity mappings do not
>     work. 

Just don't printk in that moment then.

>   o Using raw physical addresses is in bad form, and doesn't always work.

On x86-64 it's that __pa() doesn't always work very early.

>   o I can't possibly see how Andrew's Changelog that using __pa
>     is more friendly to the 4G/4G split is correct.  Unless someone
>     was hard coding a virtual address previously.

Yes, it shouldn't make any difference for 4/4.

> The second hunk in early_printk.c redefines VGABASE as __va(0xb8000).
> This is correct on both x86 and x86-64 so we don't need any more
> special cases.  

Please don't do that on x86-64. On x86-64 there are two ways to reach this
address and the previous one is available earlier.  Keep the current
address for x86-64 please.

-Andi
