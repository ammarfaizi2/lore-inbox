Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269494AbUJFWcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269494AbUJFWcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUJFW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:29:09 -0400
Received: from gprs214-192.eurotel.cz ([160.218.214.192]:13184 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269531AbUJFWYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:24:46 -0400
Date: Thu, 7 Oct 2004 00:24:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, akpm@zip.com.au, agruen@suse.de
Subject: Re: Fix random crashes in x86-64 swsusp
Message-ID: <20041006222423.GB2630@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl> <200410061206.56025.rjw@sisk.pl> <20041006101238.GD1255@elf.ucw.cz> <200410062346.29489.rjw@sisk.pl> <20041006220600.GB25059@elf.ucw.cz> <20041006152533.514fb51b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006152533.514fb51b.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Maybe we should memset freed memory to zero so such bugs are
> > prevented?
> 
> It would make sense to poison these pages, yes.  Zero would not be a good
> choice of value, actually - something like 0xbb would cause nice oopses if
> someone used a pointer which was backed by __init memory.
> 
> CONFIG_DEBUG_PAGEALLOC will pick up this sort of bug, but that's i386-only.

Few minutes after that I found out that x86-64 has similar mechanism
under CONFIG_INIT_DEBUG... it uses 0xcc.

I just wonder if it should be configurable, memset over 100KB is not
likely to be noticeable.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
