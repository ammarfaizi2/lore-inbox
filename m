Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVCDUWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVCDUWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbVCDUSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:18:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53965 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263116AbVCDUL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:11:28 -0500
Date: Fri, 4 Mar 2005 21:11:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050304201109.GB2385@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl> <200503030902.48038.rjw@sisk.pl> <20050304110408.GL1345@elf.ucw.cz> <200503041415.35162.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503041415.35162.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > IIRC kernel code/data is marked as PageReserved(), that's why we need
> > > > to save that :(. Not sure what to do with data e820 marked as
> > > > reserved...
> > > 
> > > Perhaps we need another page flag, like PG_readonly, and mark the pages
> > > reserved by the e820 as PG_reserved | PG_readonly (the same for the areas
> > > that are not returned by e820 at all).  Would that be acceptable?
> > 
> > This flags are little in the short supply, but being able to tell
> > kernel code from memory hole seems like "must have", so yes, that
> > looks ok.
> > 
> > You could get subtle and reuse some other pageflag. I do not think
> > PG_reserved can have PG_locked... So using for example PG_locked for
> > this purpose should be okay.
> 
> The following patch does this.  It is only for x86-64 without
> CONFIG_DISCONTIGMEM, but it has no effect in other cases.

Actually, take a look at Nigel's patch. He simply uses PageNosave
instead of PageLocked -- that is cleaner. He also found a few places
where reserved page becomes un-reserved, and you probably need to fix
those, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
