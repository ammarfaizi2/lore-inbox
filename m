Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWHGXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWHGXQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWHGXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:16:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42907 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751175AbWHGXQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:16:15 -0400
Date: Tue, 8 Aug 2006 01:15:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807231557.GA2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for the sign-offs!

No problem.

> >> +module_param_named(debug, tp_debug, int, 0600);
> >> +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> >> +
> >> +/* A few macros for printk()ing: */
> >> +#define DPRINTK(fmt, args...) \
> >> +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
> >
> >Is not there generic function doing this?
> 
> None that I found. Many drivers do it this way.

linux/kernel.h : pr_debug() looks similar.

> >> +EXPORT_SYMBOL_GPL(thinkpad_ec_lock);
> >> +EXPORT_SYMBOL_GPL(thinkpad_ec_try_lock);
> >> +void thinkpad_ec_unlock(void)
> >> +{
> >> +     up(&thinkpad_ec_mutex);
> >> +}
> >> +
> >
> >Do we need these wrappers? Perhaps just directly exporting the mutex?
> 
> Yes, we may end up needing to lock away other systems (ACPI?) that
> touch the same ports. Apparently not an issue right now, but could
> change with new firmware.
> Also, that's what Alan Cox told me to do. :-)

Okay... but do we really need try_lock variant? lock/unlock would be
okay, but what is try_lock semantics when taking multiple locks...?

> >> +     struct dmi_device *dev = NULL;
> >
> >unneeded initializer.
> 
> On a local variable?!

You were right, but see the other mail.

> >> +static int __init thinkpad_ec_init(void)
> >> +{
> >> +     if (!check_dmi_for_ec()) {
> >> +             printk(KERN_ERR "thinkpad_ec: no ThinkPad embedded 
> >controller!\n");
> >> +             return -ENODEV;
> >
> >KERN_ERR is little strong here, no?
> 
> Not sure what's the right one. The user tried to load a module and the
> module can't do that; I saw some drivers use KERN_ERR some
> KERN_WARNING in similar cases. Is there some guideline on choosing
> printk levels?

Well, this will also trigger for thinkpad module compiled into kernel,
right?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
