Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWAaMfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWAaMfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAaMfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:35:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:6272 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750787AbWAaMfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:35:22 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: [PATCH] prevent nested panic from soft lockup detection
References: <43DDE5A1.76F0.0078.0@novell.com.suse.lists.linux.kernel>
	<20060130145850.GB9752@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <20060130145850.GB9752@redhat.com.suse.lists.linux.kernel>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 31 Jan 2006 13:35:18 +0100
Message-ID: <p73fyn4mv7d.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Mon, Jan 30, 2006 at 10:08:33AM +0100, Jan Beulich wrote:
> 
>  > From: Jan Beulich <jbeulich@novell.com>
>  > 
>  > Suppress triggering a nested panic due to soft lockup detection.
>  > 
>  > Signed-Off-By: Jan Beulich <jbeulich@novell.com>
>  > 
>  > diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c 2.6.16-rc1-panic-softlockup/kernel/panic.c
>  > --- /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c	2006-01-27 15:10:49.000000000 +0100
>  > +++ 2.6.16-rc1-panic-softlockup/kernel/panic.c	2006-01-25 09:55:53.000000000 +0100
>  > @@ -107,6 +107,7 @@ NORET_TYPE void panic(const char * fmt, 
>  >  		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
>  >  		for (i = 0; i < panic_timeout*1000; ) {
>  >  			touch_nmi_watchdog();
>  > +			touch_softlockup_watchdog();
>  >  			i += panic_blink(i);
>  >  			mdelay(1);
>  >  			i++;
>  > @@ -130,6 +131,7 @@ NORET_TYPE void panic(const char * fmt, 
>  >  #endif
>  >  	local_irq_enable();
>  >  	for (i = 0;;) {
>  > +		touch_softlockup_watchdog();
>  >  		i += panic_blink(i);
>  >  		mdelay(1);
>  >  		i++;
> 
> I've been wondering for a while why we don't just make touch_nmi_watchdog
> do an implicit call to touch_softlockup_watchdog.  I can't think of a situation
> where we'd want to do one but not the other, and adding patches like this
> seems to be an uphill battle (I know at least two other places that need
> this off the top of my head).

Very good idea.

Someone did it already in the SUSE kernel and it helped considerably
there.

-Andi
