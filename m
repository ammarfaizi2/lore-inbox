Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUG2Hjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUG2Hjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUG2Hjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:39:54 -0400
Received: from gprs214-173.eurotel.cz ([160.218.214.173]:23936 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267341AbUG2Hjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:39:47 -0400
Date: Thu, 29 Jul 2004 09:39:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-ID: <20040729073929.GB828@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz> <20040728161448.336183e2.akpm@osdl.org> <20040728233929.GD16494@elf.ucw.cz> <20040728234352.GA14319@elf.ucw.cz> <1091061026.8873.78.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091061026.8873.78.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +I did found some kernel threads don't do it, and they don't freeze, and
> 
> "I found... threads that don't..."
> 
> > +so the system can't sleep. Is this a known behavior?
> > +
> > +A: All such kernel threads need to be fixed, one by one. Select place
> > +where it is safe to be frozen (no kernel semaphores should be held at
> > +that point and it must be safe to sleep there), and add:
> > +
> > +            if (current->flags & PF_FREEZE)
> > +                    refrigerator(PF_FREEZE);
> > +
> 
> Perhaps you should also add.
> 
> If the thread is needed for writing the image to storage, you should
> instead set the PF_NOFREEZE process flag when creating the thread.

Thanks, text is now:

Q: Kernel thread must voluntarily freeze itself (call 'refrigerator'). But
I found some kernel threads that don't do it, and they don't freeze, and
so the system can't sleep. Is this a known behavior?

A: All such kernel threads need to be fixed, one by one. Select place
where it is safe to be frozen (no kernel semaphores should be held at
that point and it must be safe to sleep there), and add:

            if (current->flags & PF_FREEZE)
                    refrigerator(PF_FREEZE);

If the thread is needed for writing the image to storage, you should
instead set the PF_NOFREEZE process flag when creating the thread.

I'll eventually push it, too.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
