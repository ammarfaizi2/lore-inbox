Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLCAWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLCAWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVLCAWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:22:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28093 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751087AbVLCAWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:22:09 -0500
Date: Sat, 3 Dec 2005 01:21:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Message-ID: <20051203002155.GA3094@elf.ucw.cz>
References: <20051201173649.GA22168@hexapodia.org> <200512021054.03245.rjw@sisk.pl> <20051202181351.GB1854@elf.ucw.cz> <200512022258.56822.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512022258.56822.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, but notice get_zeroed_page() there, and that still needs to be
> > atomically copied.
> > 
> > So each higmem page takes:
> > 
> > 1 get_zeroed_page()
> > 1 kmalloc(struct(highmem_page))
> > + copies of those into snapshot.
> 
> Yeah, right.  I forgot to count them twice and I didn't take the kmalloc()s
> into account.  I'll do my best to produce a patch for it ASAP.
> 
> BTW, every kmalloc() in there seems to take 32 bytes (ie. the smallest generic
> slab object size), which is a bit wasteful.  The Andy's numbers indicate it
> can take more than 700 pages just for that, and they have to be
> taken twice,

Well, still sizeof(kmalloc structures) ~= 1.3% of the real
data. That's not *that* bad overhad.

> which gives more than 1400 pages total.  It could be as little as about 300
> pages _total_ if we did it more carefully.  I think I'll place this on my todo
> list for after 2.6.15.

That's about 6MB more data to save on 400MB. Remember, I'm not
perfectionist (:-), and saving 1% more data to disk does not sound
_that_ bad to me.

Plus it only happens on highmem machines. Highmem is ugly hack, and is
going to die really soon, with 32-bit machines. I'd say it is not
worth fixing.

...I should not tell you, but swsusp is broken-by-design on highmem
machines. If you have 32GB highmem machine, under load, you'll
definitely run out of lowmem trying to swsusp it. Actually, you'll run
out of memory even on severely overloaded 2GB highmem machine
(attempting to swsusp). Fortunately noone knows, and noone cares.

								Pavel
-- 
Thanks, Sharp!
