Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTE1Wwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTE1Wwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:52:41 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:60611 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261324AbTE1Wwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:52:38 -0400
Date: Thu, 29 May 2003 01:05:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: mikpe@csd.uu.se, miltonm@bga.com, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
Message-ID: <20030528230534.GC2236@elf.ucw.cz>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net> <20030528111401.GB342@elf.ucw.cz> <16084.46712.707240.943086@gargle.gargle.HOWL> <20030528152827.5387e033.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528152827.5387e033.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > > -	load_LDT(&current->mm->context);	/* This does lldt */
> >  > > +	load_LDT(&current->active_mm->context);	/* This does lldt */
> > 
> > No one has still explained WHY kapmd's current->mm is NULL for some people,
> > while it obviously is non-NULL for many others.
> 
> All kernel threads have current->mm = NULL, via daemonize()->exit_mm().  So
> the question becomes "why does this code get called by kernel threads for
> some people, and not for others"?  Pavel?

I believe it depends on what process happens to be current at time of
suspend. That can be randomly kernel thread or user process.

Some people use APM, some people use ACPI, and sometimes APM suspend
is triggered because of BIOS, sometimes because user said apm -s...

> Also, is there any point in doing load_LDT(&current->active_mm->context)
> for a kernel thread?

Yes, we want system to be similar state it was when we suspended, to
prevent heisenbugs.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
