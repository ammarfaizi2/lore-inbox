Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbUKVK0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUKVK0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbUKVK0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:26:34 -0500
Received: from gprs214-187.eurotel.cz ([160.218.214.187]:49280 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262021AbUKVK03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:26:29 -0500
Date: Mon, 22 Nov 2004 11:26:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041122102612.GA1063@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122072215.GA13874@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Here is the patch relative to your big diff. It tested pass with my x86
> > > pc, But the sysfs interface can't works, I using reboot system call.
> > 
> > Without PREEMPT and HIGHMEM it worked okay on an idle system. When I
> > started kernel compilation while trying to swsusp, it crashed on
> > resume.
> 
> Here is my big diff relative to your big diff. :), It works.
> 
> - Not need continuous page for pagedir.
>   Swsusp using continuous page (pagedir), to save the new address, old
>   address and swap offset, but in current implemention, it using
>   continuous page as array, so if has so many pages to save, we have to
>   allocate many (>5) continuous pages, most it it will failed.
>  
>   I using a easy link struct to resolve it.

Yes, I'd like to get rid of "too many continuous pages" problem
before. Small problem is that it needs to update x86-64 too, but I
guess that's okay. I'd like that version to go in *before* that
page-cache stuff (it actually fails a lot in wild).

Could you possibly put page-cache stuff into separate file? It would
be even nicer to have it configurable (run-time or compile-time) so
that if swsusp fails, I can tell people "try again with page-cache
stuff turned off"...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
