Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUJPVZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUJPVZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJPVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:25:24 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:44929 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268884AbUJPVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:25:19 -0400
Date: Sat, 16 Oct 2004 23:25:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ncunningham@linuxmail.org
Subject: Re: swsusp: 8-order allocation failure on demand (update)
Message-ID: <20041016212501.GG24434@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <200410162131.19761.rjw@sisk.pl> <20041016204027.GA24434@elf.ucw.cz> <200410162305.50794.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410162305.50794.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Unfortunately that's rather ugly. You'd ~32 bytes per 4K page, that's
> > > > almost 1% overhead, not nice. Better solution (but more work) is to
> > > > switch to link-lists or integrate swsusp2.
> > > 
> > > Well, I wonder if the page allocation failures are a swsusp problem,
> > > really.  
> > 
> > Yes, they are. Kernel memory allocation is not design to do 8-order
> > allocations properly. swsusp really should not use them.
> 
> Now that's clear, thanks.  Could you tell me, please, what I need to know to 
> understand the swsusp code and what I should start with?

On bootup, prealloc, say, order-9 alocation.

In alloc_pagedir(), do not allocate anything, but check that data fit
in preallocated area, and fail if not.

There's free_pages( pagedir_save, ...) somewhere, remove that so
pagedir is never freed and you can resume multiple times.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
