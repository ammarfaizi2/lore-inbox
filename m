Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSGaLTH>; Wed, 31 Jul 2002 07:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGaLTH>; Wed, 31 Jul 2002 07:19:07 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:34067 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S316185AbSGaLTG>;
	Wed, 31 Jul 2002 07:19:06 -0400
Message-Id: <200207311122.MAA23973@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Wed, 31 Jul 2002 12:22:28 +0100
In-Reply-To: <3D458BE4.60C7FB77@mvista.com>
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: george anzinger <george@mvista.com>
Subject: Re: 2.4.18 clock warps 4294 seconds
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 11:39am, george anzinger <george@mvista.com> wrote:
> > The "if (count > LATCH)" block has been taken out of the 2.4.18
> 
> I am not sure it was ever in the kernel in that form.  Are
> you sure you did not put some patch in here?

I've never deliberately touched anything in there.  Everything
will have come from RedHat (7.2 CDs) or kernel.org, and I'm
pretty sure I didn't install any interim and/or experimental
versions or patches.

> I wish I knew more about this hardware bug.  The test
> suggests that the chip is not resetting the latch on
> interrupt, but rather that it just rolls over (or under). 
> This would cause the count to, again, reach zero (and,
> hopefully interrupt) in about 50 ms.  On the other hand, the
> chip could be switching modes and only the "0X34" mode will
> continue to interrupt with out the chip being reprogrammed. 
> In this case, it is hard to understand how the system keeps
> ANY time at all.  

Both machines generally seem to keep time just fine, apart
from the bumps.  But then, there were only a few of the
hardware bug warning messages in the logs, so it didn't
manifest itself very often.

Anyway, nothing caught over the weekend, unfortunately.  The trap
in do_fast_gettimeoffset() reads:

        if ( eax > 100000000 ) {
                glob_eax = eax;
                return delay_at_last_interrupt;
        }

Then a check and printk() in do_gettimeofday().  The machine
has lost NTP synch somewhat sporadically, but not as regularly
as before.  Sigh.  Maybe it's the weather, we've been having a
heatwave since Friday, and everybody and everything in the office
is roasting.

I'm going to try to fiddle around some more, also with the other
machine.

  -- Per

