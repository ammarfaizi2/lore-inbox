Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTARDaz>; Fri, 17 Jan 2003 22:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTARDay>; Fri, 17 Jan 2003 22:30:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7082 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262380AbTARDay>;
	Fri, 17 Jan 2003 22:30:54 -0500
Subject: Re: Fwd: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200301180325.h0I3PGa07081@eng2.beaverton.ibm.com>
References: <200301180325.h0I3PGa07081@eng2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042860792.32477.36.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 19:33:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Hi!

Hey! Hmm. Odd, this email never got to me directly, instead I found it
through lkml. Hopefully my mail isn't bouncing somewhere...
 

>  > +static void delay_pit(unsigned long loops)
>  > +{
>  > +    int d0;
>  > +    __asm__ __volatile__(
>  > +            "\tjmp 1f\n"
>  > +            ".align 16\n"
>  > +            "1:\tjmp 2f\n"
>  > +            ".align 16\n"
>  > +            "2:\tdecl %0\n\tjns 2b"
>  > +            :"=&a" (d0)
>  > +            :"0" (loops));
>  > +}
>  > +
>  
>  But... this is not using pit to do the delay, right? It is sensitive
>  to CPU clock changes, pit-delay should not be.

You're right, basically I took the previous __loop_delay() and
__rtsc_delay() and moved them to delay_pit() and delay_tsc(),
respectively. I guess the naming is somewhat confusing, but since this
was meant as just a cleanup, I'm trying to use the same code in the same
conditions.(ie: when using the PIT time-source, use the loop delay. when
using the TSC time-source, use the TSC delay). A changing the name or a
comment explaining it would def clear that up. 

You do bring up an interesting idea: actually using the PIT to do
__delay. I think its possible, but not really worth it, as the PIT is
such a nasty bit of hardware to deal with. I'd guess that just reading
the PIT would likely delay for more time then what was actually
requested.

Thanks for the feedback!
-john


