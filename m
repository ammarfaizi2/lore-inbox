Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTEGHQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTEGHQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:16:35 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:42984 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262945AbTEGHQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:16:34 -0400
Message-ID: <3EB8B5EA.BD5D1C19@Bull.Net>
Date: Wed, 07 May 2003 09:29:46 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Eric Piel wrote:
> > Playing around with the posix timers I've noticed that DELAYTIMER_MAX is
> > not defined. This constant is specified in the POSIX specifications. It
> > should contain the maximum possible value of overruns on a signal. It is
> > also said that the overrun shouldn't overflow. cf
> > http://www.opengroup.org/onlinepubs/007904975/functions/timer_getoverrun.html
> >
> > So here is a patch to add this constant and a check that the overrun
> > variable never overflow. It's for 2.5.67 but should apply flawlessly to
> > 2.5.69 too.
> I think this is needed in glibc.  I am not sure how that relates to
> kernel defines.

How can the glibc do things like that? :
> >  #define posix_bump_timer(timr) do { \
> >                          (timr)->it_timer.expires += (timr)->it_incr; \
> > -                        (timr)->it_overrun++;               \
> > +                        if ((timr)->it_overrun < DELAYTIMER_MAX)\
> > +                            (timr)->it_overrun++;               \
> >                         }while (0)

In addition knowing that DELAYTIMER_MAX is dependant on the
implementation and that the implementation is now in the kernel I think
DELAYTIMER_MAX should be defined by the kernel. Then glibc can do its
usual trick of stealing all the constant from the kernel...

Eric
