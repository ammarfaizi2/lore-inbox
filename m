Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVATWJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVATWJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVATWJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:09:23 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:18888 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262179AbVATWG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:06:58 -0500
Date: Thu, 20 Jan 2005 23:06:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050120220630.GB22201@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202246.38506.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The following patch speeds up the restoring of swsusp images on x86-64
> > > and makes the assembly code more readable (tested and works on AMD64).  It's
> > > against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.
> > 
> > Can you really measure the speedup?
> 
> In terms of time?  Probably I can, but I prefer to measure it in terms of the numbers of
> operations to be performed.
> 
> With this patch, at least 8 times less memory accesses are required to restore an image
> than without it, and in the original code cr3 is reloaded after copying each _byte_,
> let alone the SIB arithmetics.  I'd expect it to be 10 times faster
> or so.

Well, 8 times less cr3 reloads may be significant... for the copy
loop. Speeding up copy loop that takes  ... 100msec?... of whole
resume (30 seconds) does not seem too important to me.

> The readability of code is also important, IMHO.

It did not seem too much better to me.

> > If you want cheap way to speed it up, kill cr3 manipulation.
> 
> Sure, but I think it's there for a reason.

Reason is "to crash it early if we have wrong pagetables".

> > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> 
> I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> If necessary, I can change the patch to work with his code (hugang, what do you think?).

I think it is just not worth the effort.
										Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
