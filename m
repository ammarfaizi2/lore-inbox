Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVALVYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVALVYC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVALVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:22:17 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:55776 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261454AbVALVCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:02:04 -0500
Date: Wed, 12 Jan 2005 22:01:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Message-ID: <20050112210147.GJ1408@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501081610.57625.rjw@sisk.pl> <20050108154439.GA24771@elf.ucw.cz> <200501121951.48102.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501121951.48102.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [-- snip --]
> > > > > The regression is caused by the timer driver.  Obviously, turning 
> > > > > timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go
> > > > > away. 
> [-- snip --]
> > > > 
> > > > ..you might want to look at i386 time code, they have common
> > > > ancestor, and i386 one seems to work.
> 
> Well, I've changed timer_resume() in arch/x86_64/kernel/time.c into the 
> following function:

Ugh, looking at arch/i386/kernel/time.c... "This could have never
worked".

It does something like get_cmos_time() - get_cmos_time()*HZ. It looks
seriously wrong.

> (for example - the second number is always negative and huge).  Would it mean 
> that get_cmos_time() needs fixing?

get_cmos_time() looks okay, but timer){suspend,resume} looks
hopelessly broken.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
