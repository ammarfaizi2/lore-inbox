Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWEUKJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEUKJE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEUKJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:09:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5532 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932331AbWEUKJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:09:03 -0400
Date: Sun, 21 May 2006 12:08:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: p.lundkvist@telia.com, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-ID: <20060521100819.GD8490@elf.ucw.cz>
References: <20060520130326.GA6092@localhost> <20060520103728.6f3b3798.akpm@osdl.org> <20060520225018.GC8490@elf.ucw.cz> <20060520171244.4399bc54.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520171244.4399bc54.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well that's a crock, isn't it?
> 
> 
> Peter, does this fix it?
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> pdflush is carefully designed to ensure that all wakeups have some
> corresponding work to do - if a woken-up pdflush thread discovers that it
> hasn't been given any work to do then this is considered an error.
> 
> That all broke when swsusp came along - because a timer-delivered wakeup to a
> frozen pdflush thread will just get lost.  This causes the pdflush thread to
> get lost as well: the writeback timer is supposed to be re-armed by pdflush in
> process context, but pdflush doesn't execute the callout which does this.
> 
> Fix that up by ignoring the return value from try_to_freeze(): jsut proceed,
> see if we have any work pending and only go back to sleep if that is not the
> case.

Looks okay to me.

							Pavel
	(who wonders what are the other places where we have similar
	problems)
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
