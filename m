Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWBQWPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWBQWPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWBQWPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:15:31 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:6272 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751816AbWBQWP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:15:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjUaRaue5Pqz50aps+Z+7iOBrEuQ3bnzVNvqy1nkulmXKwuQfH+XQJRtWFRezXwH8NIyh2MQhAbUS2qYXKg66t/DQPj3K5NWEyIkRE3VTdJmyXrPUHWukv/YqlJZg+MDxzCPzQRcholRbuHZFtf9v0giP0afOCgRPWvDMMmNDDA=
Message-ID: <58cb370e0602171415q1b040e7er1e7849212f95f2b7@mail.gmail.com>
Date: Fri, 17 Feb 2006 23:15:27 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] timer-irq-driven soft-watchdog, cleanups
Cc: "Andrew Morton" <akpm@osdl.org>, ce@ruault.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060217201123.GB29025@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
	 <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
	 <20060216122045.7a664bc6.akpm@osdl.org>
	 <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>
	 <20060217130801.GA16115@elte.hu>
	 <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
	 <20060217201123.GB29025@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > Sorry but I have enough more high priority issues to take care of and
> > I'm not going to spend any more time on soft lockups even if they are
> > really problems in IDE subsystem.  If this is not fixed before 2.6.16
> > I'm submitting patch to Linus making DETECT_SOFTLOCKUP depend on
> > "CONFIG_IDE=n"... at least users will be able to use their systems
> > instead of seeing lockups.
>
> i have lots of IDE based systems (they dont use PIO though) and i'm not
> seeing these. I'll oppose such a patch if it's to hide genuine issues -
> the 10 seconds tolerance is already generous i think. I'll of course fix
> any false positives which are the fault of the softlockup-watchdog, but
> from your mails it appears to me that the IDE warnings are indeed
> genuine.
>
> If the source of the delay is hard to fix you can temporarily work it
> around in the code by putting in the touch_softlockup_watchdog() lines -
> that will also document the places that cause long delays - which is a
> good thing.
>
> It is entirely feasible to put a touch_softlockup_watchdog() call into
> every PIO OP - even a single-byte PIO related IN/OUT instruction takes a
> couple of microseconds, so a touch_softlockup_watchdog() wont even show
> up on the radar.

OK, I'll just add touch_softlockup_watchdog() if needed but first lets
wait for results of your patch.

Note that I'll invest my time on this which could be invested into other
things and I don't see it as top-priority issue if you differ in your opinion
you should be the person fixing affected drivers.

The conclusion of the rant is:  people making changes at higher layers
should start paying maintenance costs of their changes.  Over few years
of maintaining IDE I learned quite a lot about block layer, VFS, VM, ACPI,
PM, IRQ routing, scheduling, sysfs etc (I'm not talking about interface
changes but about bugs/changes which are reported by end users
and driver maintainers are end-point).  This is all good but distracts me
from my primary task and now it is turn for people hacking on generic
code to learn few driver specific things... :)

No wonder that nobody wants to hack drivers: less fame, more flames,
and actually besides knowing hardware you need to know a lot about
kernel in general to do your job right.  I hope that Andrew is reading this.

End of whining.

> > DETECT_SOFTLOCKUP should be an aim in development not a method of
> > forcing driver maintainers to work on specific issues...
>
> well, 10+ seconds delays on a running system are not really acceptable,
> and can cause other problems. The softlockup-watchdog is optional and
> can be easily turned off in the .config.

It is "y" by default so anybody saying "y" to DEBUG_KERNEL will get it as
added bonus and moreover DEBUG_KERNEL is "y" in x86_64 defconfig.

Bartlomiej
