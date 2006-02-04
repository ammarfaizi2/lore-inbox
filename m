Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWBDTK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWBDTK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWBDTK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:10:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15275 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751290AbWBDTK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:10:58 -0500
Date: Sat, 4 Feb 2006 20:10:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204191042.GA3909@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041159.00326.rjw@sisk.pl> <200602042108.52112.nigel@suspend2.net> <200602041238.06395.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602041238.06395.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 3) trying to treat uninterruptible tasks as non-freezeable should better
> > > be avoided (I tried to implement this in swsusp last year but it caused
> > > vigorous opposition to appear, and it was not Pavel ;-))
> > 
> > I'm not suggesting treating them as unfreezeable in the fullest sense. I 
> > still signal them, but don't mind if they don't respond. This way, if they 
> > do leave that state for some reason (timeout?) at some point, they still 
> > get frozen.
> 
> Yes, that's exactly what I wanted to do in swsusp. ;-)

It seems dangerous to me. Imagine you treated interruptible tasks like
that...

What prevent task from doing

	set_state(UNINTERRUPTIBLE);
	schedule(one hour);
	write_to_filesystem();
	handle_signal()?

I.e. it may do something dangerous just before being catched by
refrigerator.
								Pavel
-- 
Thanks, Sharp!
