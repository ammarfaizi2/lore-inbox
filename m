Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUBTMOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUBTMOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:14:05 -0500
Received: from tuxhome.net ([217.160.179.19]:18842 "EHLO tuxhome.net")
	by vger.kernel.org with ESMTP id S261175AbUBTMNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:13:38 -0500
From: Markus Hofmann <markus@gofurther.de>
Organization: gofurther.de
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.2 - System clock runs too fast
Date: Fri, 20 Feb 2004 13:13:37 +0100
User-Agent: KMail/1.6.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200402101332.26552.markus@gofurther.de> <200402111007.50549.markus@gofurther.de> <1076524588.795.28.camel@cog.beaverton.ibm.com>
In-Reply-To: <1076524588.795.28.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402201313.38063.markus@gofurther.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John

Thank you for your patch. Yesterday I had the time to use it. And now my time 
runs normal!!

Thanks
regards Markus

Am Mittwoch, 11. Februar 2004 19:36 schrieb john stultz:
> On Wed, 2004-02-11 at 01:07, Markus Hofmann wrote:
> > Thank you for answering.
> > In the meantime I heard that apm could cause this problem. I tested this
> > by compiling acpi. The result was that the clock runs normal with acpi.
> > But I want to use apm. So I removed the acpi and now the system clock is
> > too slow with only apm.
> >
> > I think this is a very curious thing! :-(
>
> Indeed, normally its ACPI that causes more problems. That's a new one.
>
> I'd be curious how this drift changes using the attached patch.
>
> thanks
> -john
>
> ===== arch/i386/kernel/timers/timer_tsc.c 1.35 vs edited =====
> --- 1.35/arch/i386/kernel/timers/timer_tsc.c	Wed Jan  7 00:31:11 2004
> +++ edited/arch/i386/kernel/timers/timer_tsc.c	Tue Jan 20 13:22:54 2004
> @@ -226,7 +226,7 @@
>  	delta += delay_at_last_interrupt;
>  	lost = delta/(1000000/HZ);
>  	delay = delta%(1000000/HZ);
> -	if (lost >= 2) {
> +	if (0 && (lost >= 2)) {
>  		jiffies_64 += lost-1;
>
>  		/* sanity check to ensure we're not always losing ticks */
