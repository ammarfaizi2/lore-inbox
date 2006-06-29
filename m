Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWF2H3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWF2H3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWF2H3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:29:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8335 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751687AbWF2H33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:29:29 -0400
Date: Thu, 29 Jun 2006 09:29:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Incorrect CPU process accounting using         CONFIG_HZ=100
Message-ID: <20060629072915.GE27526@elf.ucw.cz>
References: <200606211716.01472.a1426z@gawab.com> <200606272302.16950.kernel@kolivas.org> <44A1C4D4.3080805@bigpond.net.au> <200606282306.14498.a1426z@gawab.com> <44A30F60.6070001@bigpond.net.au> <cone.1151538362.930767.14982.501@kolivas.org> <44A31DE8.20100@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A31DE8.20100@bigpond.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>Wouldn't merging the two approaches be in the interest of conserving 
> >>>cpu resources, while at the same time reflecting an accurate view of 
> >>>cpu utilization?
> >>
> >>I think that this would be a worthwhile endeavour once/if 
> >>sched_clock() is fixed.  This is especially the case as CPUs get 
> >>faster as many tasks may run to completion in less than a tick.
> >
> >That may not be as simple as it seems. To properly account system v user 
> >time using the sched_clock we'd have to hook into arch dependant asm 
> >code to know when entering and exiting kernel context. That is far more 
> >invasive than the simple on/off runqueue timing we currently do for 
> >scheduling accounting.
> 
> Yes, it is a problem and we may have to do something approximate like 
> counting ticks for sys time and subtracting that from the total to get 
> user time when reporting the times to user space (only a bit more 
> complex to make sure we don't end up with negative times).

Yes, please.

> How is it intended to handle this problem in the tickless kernel?

Even our "tickless" kernels do tick while CPU is busy.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
