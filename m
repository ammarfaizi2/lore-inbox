Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVCFTle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVCFTle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 14:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVCFTle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 14:41:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54444 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261482AbVCFTl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 14:41:27 -0500
Date: Sun, 6 Mar 2005 20:41:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050306194100.GA1528@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl> <200503050026.06378.rjw@sisk.pl> <20050304234149.GD2647@elf.ucw.cz> <200503061830.00574.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503061830.00574.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > Yes.  I thought about using PG_nosave in the begining, but there's a
> > > 
> > > BUG_ON(PageReserved(page) && PageNosave(page));
> > > 
> > > in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
> > > though, that we don't need it any more, do we?
> > 
> > No, we can just kill it. It was "if something unexpected happens, bail
> > out soon".
> 
> OK
> 
> The following is what I'm comfortable with.  I didn't took the Nigel's patch
> literally, because we do one thing differently (ie nosave pfns) and it contained
> some changes that I thought were unnecessary.  The i386 part is
> untested.

I'd add

>  	page = pfn_to_page(pfn);
> -	BUG_ON(PageReserved(page) && PageNosave(page));

a comment here explaining what PageReserved && PageNosave means. 

>  	if (PageNosave(page))
>  		return 0;
> +
>  	if (PageReserved(page) && pfn_is_nosave(pfn)) {
>  		pr_debug("[nosave pfn 0x%lx]", pfn);
>  		return 0;

AFAICT it only fixes "potential" bug, so it can probably wait. Once
non-contiguous and initramfs patches are in, this can go...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
