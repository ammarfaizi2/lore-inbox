Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTE1OFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264742AbTE1OFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:05:37 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:33924 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263571AbTE1OFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:05:36 -0400
Date: Wed, 28 May 2003 16:18:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: mikpe@csd.uu.se
Cc: Pavel Machek <pavel@suse.cz>, Milton Miller <miltonm@bga.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
Message-ID: <20030528141830.GA641@elf.ucw.cz>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net> <20030528111401.GB342@elf.ucw.cz> <16084.46712.707240.943086@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16084.46712.707240.943086@gargle.gargle.HOWL>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Didn't know if you caught this one, but it fixes it for me and others
>  > > who responded on the list.  
>  > > 
>  > > mm is NULL for kernel threads without their own context.  active_mm is
>  > > maintained the one we lazly switch from.
>  > > 
>  > > Without this patch, apm bios initiated suspend events (eg panel close) 
>  > > cause an oops on resume in the LDT restore, killing kapmd, which causes
>  > > further events to not be polled.
>  > 
>  > Ouch, okay, this looks good. Andrew please apply.
>  > 
>  > [I guess this is trivial enough for trivial patch monkey if andrew
>  > does not want to take it...]
>  > 								Pavel
>  > 
>  > > ===== arch/i386/kernel/suspend.c 1.16 vs edited =====
>  > > --- 1.16/arch/i386/kernel/suspend.c	Sat May 17 16:09:37 2003
>  > > +++ edited/arch/i386/kernel/suspend.c	Sat May 24 05:00:02 2003
>  > > @@ -114,7 +114,7 @@
>  > >          cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
>  > >  
>  > >  	load_TR_desc();				/* This does ltr */
>  > > -	load_LDT(&current->mm->context);	/* This does lldt */
>  > > +	load_LDT(&current->active_mm->context);	/* This does lldt */
> 
> No one has still explained WHY kapmd's current->mm is NULL for some people,
> while it obviously is non-NULL for many others. That worries me a
>  > > lot more.

That's seems like random variable to me. It probably depends on timing
during suspend. If code is buggy fix it.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
