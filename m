Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRKFOPE>; Tue, 6 Nov 2001 09:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279416AbRKFOOy>; Tue, 6 Nov 2001 09:14:54 -0500
Received: from colorfullife.com ([216.156.138.34]:11780 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279382AbRKFOOj>;
	Tue, 6 Nov 2001 09:14:39 -0500
Message-ID: <3BE7F042.2031C9F3@colorfullife.com>
Date: Tue, 06 Nov 2001 15:14:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com> <1005033690.808.2.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Further, the preemptible kernel patch oopses with this patch (IOW, don't
> use 2.4.13-ac8 + preempt-kernel, unless you remove all these bits like I
> did :>).  I think it may be because of:
>

Could you send me an oops?
I assume that a
	set_current(hard_get_current());
is missing somewhere.
The assumption is that get_current() is faster than hard_get_current(),
and that there are so many get_current() calls that the overhead for the
set_current() in __switch_to and do_page_fault is small.

> Manfred Spraul wrote:
> > error_code:
> > [...]
> > -       GET_CURRENT(%ebx)
> >         call *%edi
> >         addl $8,%esp
> > +       GET_CURRENT(%ebx)
> > The pointer to current was loaded into %ebx before the call to the error
> > handler, now that only happens after the call. As far as I can see the
> > load before the call is not required.
> 
> this change but I am unsure.  Would Manfred or someone knowledgeable in
> this mind letting me pick their brain?
>
I would be very surprised if that's a problem: the error handlers are C
functions, and they don't expect parameters in register %ebx.

--
	Manfred
