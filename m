Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbSJCHNu>; Thu, 3 Oct 2002 03:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbSJCHNu>; Thu, 3 Oct 2002 03:13:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64972 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262767AbSJCHNt>;
	Thu, 3 Oct 2002 03:13:49 -0400
Subject: Re: [PATCH] linux-2.5.40_timer-changes_A3 (3/3 - integration)
From: john stultz <johnstul@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>
In-Reply-To: <20021003065900.GB18481@kroah.com>
References: <1033625380.28783.60.camel@cog> <1033625479.28783.63.camel@cog>
	<1033625554.28783.66.camel@cog>  <20021003065900.GB18481@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 00:13:54 -0700
Message-Id: <1033629234.13095.81.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 23:59, Greg KH wrote:
> > +/* fwd declarations */
> 
> These don't have to be forward declarations, do they?
> And can they be static?

Ummm. I could just be wrong, but since I'm setting structure elements to
equal the functions before they are declared, I need the fwds (unless,
of course I put the "struct timer_opts timer_pit" section below all the
functions, which is doable).  Also, since external functions are going
to be calling these functions via the structure's function pointers, I
believe they can't be static. Although, maybe they can, as long as the
timer_pit value isn't static. I'm not that much of a C guru, so I'm
really sure.

> 
> > +int init_pit(void);
> > +void mark_offset_pit(void);
> > +unsigned long get_offset_pit(void);
> > +
> > +/* tsc timer_opts struct */
> > +struct timer_opts timer_pit = {
> > +	init: init_pit, 
> > +	mark_offset: mark_offset_pit, 
> > +	get_offset: get_offset_pit
> > +};
> > +
> > +
> > +extern spinlock_t i8259A_lock;
> > +extern spinlock_t i8253_lock;
> > +#include "do_timer.h"
> 
> Shouldn't these 3 lines be above the "/* fwd declarations */" line?

They could be, but I'm not sure about the necessity. Is this a coding
style sorta' thing, or a C properness sort of thing? Either way is fine,
I just don't follow the logic. 


> Same minor comments for timer_tsc.c

Thanks for the feedback, I'll probably go ahead and apply your
suggestions, although, I'm still quite ignorant as to the reasons for
doing so. If you could, please fill me in.

thanks
-john


