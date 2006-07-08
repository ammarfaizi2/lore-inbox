Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWGHAaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWGHAaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGHAaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:30:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932442AbWGHAaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:30:19 -0400
Date: Sat, 8 Jul 2006 02:30:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-pm@lists.osdl.org
Subject: Re: [BUG] sleeping function called from invalid context during resume
Message-ID: <20060708003003.GE1700@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF8BD@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF8BD@hdsmsx411.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Lacking any other caller-passed indication, it would be much better for
> >acpi to look at irqs_disabled().  That's effectively a task-local,
> >cpu-local argument which was passed down to callees.  It's hacky - it's
> >like the PF_foo flags.  But it's heaps better than having all 
> >the kernel fight over the state of a global.
> 
> I didn't propose that kmalloc callers peek at system_state.
> I proposed that system_state be set properly on resume
> exactly like it is set on boot -- SYSTEM_RUNNING means
> we are up with interrupts enabled.
> 
> Note that this issue is not specific to ACPI, any other code
> that calls kmalloc during resume will hit __might_sleep().
> This is taken care of by system_state in the case of boot
> and the callers don't know anything about it -- resume
> is the same case and should work the same way.

I'd agree with Andrew here -- lets not mess with system_state. It is
broken by design, anyway.

Part of code would prefer SYSTEM_BOOTING during resume (because we are
initializing the devices), but I'm pretty sure some other piece of
code will get confused by that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
