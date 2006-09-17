Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWIQM4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWIQM4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 08:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWIQM4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 08:56:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932419AbWIQM4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 08:56:53 -0400
Date: Sun, 17 Sep 2006 14:56:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Singleton <daviado@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: OpPoint summary
Message-ID: <20060917125655.GJ2741@elf.ucw.cz>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com> <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com> <20060914055529.GA18031@kroah.com> <b324b5ad0609162207o269c826cuae051ecfa61c4362@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b324b5ad0609162207o269c826cuae051ecfa61c4362@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've incorporated Pavels suggestions and only put suspend states
> in the /sys/power/state file.  The control file for frequency and

Ok...

> voltage operating
> point transitions is now in
> /sys/power/operating_points/current_point.

How do you handle SMP? If I want full speed on CPU0 and 100MHz on cpu
1?
> --- linux-2.6.17.orig/kernel/power/main.c
> +++ linux-2.6.17/kernel/power/main.c
> @@ -16,6 +16,7 @@
> #include <linux/init.h>
> #include <linux/pm.h>
> #include <linux/console.h>
> +#include <linux/module.h>
> 
> #include "power.h"
> 
> @@ -49,7 +50,7 @@ void pm_set_ops(struct pm_ops * ops)
>  *     the platform can enter the requested state.
>  */
> 
> -static int suspend_prepare(suspend_state_t state)
> +static int suspend_prepare(struct oppoint * state)

...so why this change?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
