Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVAUKWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVAUKWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAUKIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:08:45 -0500
Received: from gprs215-198.eurotel.cz ([160.218.215.198]:45769 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262254AbVAUKGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:06:44 -0500
Date: Fri, 21 Jan 2005 11:06:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121100603.GD18373@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <200501202358.53918.rjw@sisk.pl> <20050120230616.GD22201@elf.ucw.cz> <200501210114.14859.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501210114.14859.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I know that current code works. It was produced by C compiler,
> > btw. Now, new code works for you, but it was not in kernel for 4
> > releases, and... this code is pretty subtle.
> 
> Now, I'm confused. :-)  It's roughly this:
> 
> struct pbe *pbe = pagedir_nosave, *end;
> unsigned n = nr_copy_pages;
> if (n) {
> 	end = pbe + n;
> 	do {
> 		memcpy((void *)pbe->orig_address, (void *)pbe->address, PAGE_SIZE);
> 		pbe++;
> 	} while (pbe < end);
> }
> 
> where memcpy() is of course a hand-written inline that includes the cr3 manipulation,
> and pbe, end, n are registers.

For example it may not use any variable in memory, and may not use
stack, as memory changes under its hands. Plus assembly is always
subtle ;-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
