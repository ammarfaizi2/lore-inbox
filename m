Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSKORlk>; Fri, 15 Nov 2002 12:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKORlk>; Fri, 15 Nov 2002 12:41:40 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:58128 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266540AbSKORli>; Fri, 15 Nov 2002 12:41:38 -0500
Date: Fri, 15 Nov 2002 17:48:33 +0000
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       Dipankar Sarma <dipankar@gamebox.net>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115174833.GB83229@compsoc.man.ac.uk>
References: <3DD47858.3060404@mvista.com> <20021115051207.GA29779@compsoc.man.ac.uk> <3DD5011F.9010409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5011F.9010409@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 08:13:51AM -0600, Corey Minyard wrote:

> I don't think that's a good idea for two reasons:
> 
>    * If the oprofile code is only using the counter that the NMI
>      watchdog is not using, it will silently cause the NMI watchdog to
>      stop working.  I know that's not the case now, but it could be in
>      the future.

Uh, this is fine. We always call the NMI watchdog handler, so it will
see apic irqs get stuck, and work anyway.

>    * The oprofile code will always reset the counter, so the NMI
>      watchdog will never see the timeout, so it doesn't matter.

wrong. If we are using counters 0 and 1, and 1 overflows, oprofile
resets that, then 0 overflows, the NMI watchdog will see it and
incorrectly reset it. You HAVE to avoid the reset - you can test it if
you don't believe me.

> It's currently kind of an unnatural relationship.  IMHO, it would be 
> better to have a separate handler for the perf counters that they both 
> use.  But that's beyond the scope of this right now.

Yes.

> +/* This is for I/O APIC, until we can figure out how to tell if it's from the
> +   I/O APIC.  If the NMI  was not handled before now, we handle it. */
> +static int dummy_watchdog_reset(int handled)
> +{
> +	return !handled;
> +}

And if it was handled previously, you reset it to not handled ? Uh ?

regards
john
