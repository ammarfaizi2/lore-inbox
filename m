Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbVCEAUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVCEAUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVCEASD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:18:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19853 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263268AbVCDXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:44:54 -0500
Date: Sat, 5 Mar 2005 00:41:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050304234149.GD2647@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl> <200503041415.35162.rjw@sisk.pl> <20050304201109.GB2385@elf.ucw.cz> <200503050026.06378.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503050026.06378.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually, take a look at Nigel's patch. He simply uses PageNosave
> > instead of PageLocked -- that is cleaner.
> 
> Yes.  I thought about using PG_nosave in the begining, but there's a
> 
> BUG_ON(PageReserved(page) && PageNosave(page));
> 
> in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
> though, that we don't need it any more, do we?

No, we can just kill it. It was "if something unexpected happens, bail
out soon".

> > He also found a few places where reserved page becomes un-reserved,
> > and you probably need to fix those, too.
> 
> Yes, I think I'll just port the Nigel's patch to x86-64.  BTW, it's striking
> that we found similar solutions independently (I didn't know the Nigel's
> patch before :-)).
> 
> Unfortunately, it turns out that the patch does not fix my problem with random
> reboots during resume on battery power, but I really think that we
> need to mark

:-( too bad.

> non-RAM areas with PG_nosave, at least for sanity reasons (eg to be sure that
> we do not break things by dumping stuff to where we should not write to).

I'm not sure if it is not better to save & restore non-RAM areas, but
it probably just does not matter.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
