Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUJJSai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUJJSai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUJJSai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 14:30:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:56273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268409AbUJJSah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 14:30:37 -0400
Date: Sun, 10 Oct 2004 11:28:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: swsusp: 8-order memory allocations problem (was: Re: Fix random
 crashes in x86-64 swsusp)
Message-Id: <20041010112830.3c2996bf.akpm@osdl.org>
In-Reply-To: <20041010134846.GD19831@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl>
	<200410062346.29489.rjw@sisk.pl>
	<20041006220600.GB25059@elf.ucw.cz>
	<200410082259.43627.rjw@sisk.pl>
	<20041010134846.GD19831@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > It's sort of strange, because there were 250 meg of RAM available, out of 500, 
>  > at that time.
> 
>  Well, you have 250MB free, but apparently not enough contignuous free pages...
> 
>  You may try this one, it may reduce probability of this kind of
>  failure...

The chances of successfully finding 256 physically contiguous free
pages are small.  A shrink_all_memory() pass will help of course,
but the chances of failure are still quite high.

Dunno - maybe alloc_pagedir() should use vmalloc()?  That's a non-atomic
allocation but alloc_pagedir() really shouldn't be using GFP_ATOMIC anyway.
