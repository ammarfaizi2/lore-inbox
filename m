Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVF0PET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVF0PET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVF0PDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:03:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47537 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262090AbVF0ONd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:13:33 -0400
Date: Mon, 27 Jun 2005 16:13:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, raybry@engr.sgi.com
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
Message-ID: <20050627141320.GA4945@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net> <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net> <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net> <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net> <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org> <Pine.LNX.4.62.0506262249080.4374@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506262249080.4374@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It's called "work", and we have the "TIF_xxx" flags for it. That's how 
> > "need-resched" and "sigpending" are done. There could be a 
> > "TIF_FREEZEPENDING" thing there too..
> 
> Ok. Here is yet another version of the patch:
> 
> ---
> The current suspend code modifies thread flags from outside the context of process.
> This creates a SMP race.
> 
> The patch fixes that by introducing a TIF_FREEZE flag (for all arches). Also
> 
> - Uses a completion handler instead of waiting in a schedule loop in the refrigerator.
> 
> - Introduces a semaphore freezer_sem to provide a way that multiple kernel
>   subsystems can use the freezing ability without interfering with one another.
> 
> - Include necessary definitions for the migration code if CONFIG_MIGRATE is set.
> 
> - Removes PF_FREEZE
> 
> If this approach is okay then we will need to move the refrigerator() and the
> definition of the semaphore and the completion variable out of kernel/power/process.c
> into kernel/sched.c (right?).

Approach seems okay... Perhaps better place is something like
kernel/freezer.c so it stays separate file? It is not really scheduler
core, and it is only conditionally compiled...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
