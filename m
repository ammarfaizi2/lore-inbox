Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbSJCG4N>; Thu, 3 Oct 2002 02:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbSJCG4N>; Thu, 3 Oct 2002 02:56:13 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:37643 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262762AbSJCG4L>;
	Thu, 3 Oct 2002 02:56:11 -0400
Date: Wed, 2 Oct 2002 23:59:00 -0700
From: Greg KH <greg@kroah.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>
Subject: Re: [PATCH] linux-2.5.40_timer-changes_A3 (3/3 - integration)
Message-ID: <20021003065900.GB18481@kroah.com>
References: <1033625380.28783.60.camel@cog> <1033625479.28783.63.camel@cog> <1033625554.28783.66.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033625554.28783.66.camel@cog>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 11:12:34PM -0700, john stultz wrote:
> Linus, All,
> 
>         This is the final part 3 of 3 of my timer-change patch. Part 3
> integrates the moved code (from part 2) into the new infrastructure
> (from part 1). 

Minor, minor comments:

> diff -Nru a/arch/i386/kernel/timer_pit.c b/arch/i386/kernel/timer_pit.c
> --- a/arch/i386/kernel/timer_pit.c	Wed Oct  2 22:38:24 2002
> +++ b/arch/i386/kernel/timer_pit.c	Wed Oct  2 22:38:24 2002
> @@ -1,3 +1,41 @@
> +/*
> + * This code largely moved from arch/i386/kernel/time.c.
> + * See comments there for proper credits.
> + */
> +
> +#include <linux/spinlock.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <asm/timer.h>
> +#include <asm/io.h>
> +
> +/* fwd declarations */

These don't have to be forward declarations, do they?
And can they be static?

> +int init_pit(void);
> +void mark_offset_pit(void);
> +unsigned long get_offset_pit(void);
> +
> +/* tsc timer_opts struct */
> +struct timer_opts timer_pit = {
> +	init: init_pit, 
> +	mark_offset: mark_offset_pit, 
> +	get_offset: get_offset_pit
> +};
> +
> +
> +extern spinlock_t i8259A_lock;
> +extern spinlock_t i8253_lock;
> +#include "do_timer.h"

Shouldn't these 3 lines be above the "/* fwd declarations */" line?

Same minor comments for timer_tsc.c

thanks,

greg k-h
