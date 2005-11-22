Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVKVBRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKVBRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVKVBRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:17:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964816AbVKVBRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:17:30 -0500
Date: Tue, 22 Nov 2005 02:17:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Sharp power management: split into sharpsl-dependend and generic parts
Message-ID: <20051122011717.GB15257@elf.ucw.cz>
References: <20051121224706.GA12906@elf.ucw.cz> <1132619822.7632.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132619822.7632.70.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This splits sharpsl_pm.c into sharpsl_pm.c and
> > sharp_pm.c. sharpsl_pm.c contains stuff that is shared between spitz
> > and corgi, sharp_pm.c contains more widely usable code. I'd like
> > something like this to be eventually merged... [Of course, I'll
> > cleanup #ifdef COLLIE's, I did not realize some were still pending.]
> > 
> > Comments?
> 
> The patch makes it very difficult to see what you've changed. The other
> ifdef COLLIEs look fairly straight forward to clean up and once that's
> done I'm ok with the principle of it.

Yep, sorry about that. Best way to see what I've done is to apply the
patch, then diff between old sharpsl_pm.c and new sharp_pm.c.

> I don't think the filenames are quite right as collie is still a Sharp
> SL series device. How about leaving the common code in sharpsl_pm.c and
> adding sharpsl_pm_pxa.c for the corgi/spitz common code? That should
> make the diffs easier to read. Eventually, sharpsl_pm.c should probably
> end up in arm/common but for now, I'd like to see easy to read
> diffs.

Okay, yes, that's a plan. Works for me.

> Thinking further about the structure, I have another idea which might be
> worth thinking about. If the common sharpsl_pm code was moved to
> arm/common, the files mach-sa1100/sharpsl_pm.c and mach-pxa/sharpsl_pm.c
> could provide the mach dependent functions Only one of the two would
> ever get compiled into a kernel so the files can provide the same
> function namespace and avoid any ugly ifdefs or tables of function
> pointers.

I'd say we want to keep those function pointers. We may want to
support single kernel running on multiple machines. Its probably not
going to go as far as multiboot on pxa and sa1100, but you have
function pointers there, already, and it seems cleaner to have single
mechanism for handling indirection.

> Out of interest, does the code work on collie yet?

Somehow... it is able to read battery status from time to time, and it
detects ac plug/unplug. I do not yet dare to enable real charging.

								Pavel
-- 
Thanks, Sharp!
