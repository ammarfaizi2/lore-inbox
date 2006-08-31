Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWHaWbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWHaWbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWHaWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:31:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932460AbWHaWbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:31:33 -0400
Date: Fri, 1 Sep 2006 00:31:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpu_init is called during resume
Message-ID: <20060831223121.GG12847@elf.ucw.cz>
References: <20060831135545.GM3923@elf.ucw.cz> <44F70A4B.4090803@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F70A4B.4090803@goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >cpu_init() is called during resume, at time when GFP_KERNEL is not
> >available. This silences warning, and adds few small cleanups.
> >  
> 
> I presume this is resume from disk.  If you're doing resume from RAM, 
> all the CPU-related stuff should already be allocated, unless you're 
> bringing up a new CPU which wasn't previously there, right?

We are doing virtual cpu hotplug/unplug... actually suspend to RAM
*and* disk. Just try it :-).

> And wouldn't making these allocations atomic make real CPU hotplug (ie, 
> on an active, running system) more likely to fail?  This code doesn't 
> deal with allocation failure very elegantly.

Hmm... well hopefully free_pages_min will cover this case.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
