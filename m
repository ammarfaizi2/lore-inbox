Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbREEO7Q>; Sat, 5 May 2001 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbREEO7H>; Sat, 5 May 2001 10:59:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1910 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132606AbREEO66>; Sat, 5 May 2001 10:58:58 -0400
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: smp_send_stop() and disable_local_APIC()
In-Reply-To: <3AF19A17.19C2741F@alacritech.com> <m1d79pnm2b.fsf@frodo.biederman.org> <3AF2E717.AF7936BD@alacritech.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 23:50:42 -0600
In-Reply-To: "Matt D. Robinson"'s message of "Fri, 04 May 2001 10:29:59 -0700"
Message-ID: <m1pudomjil.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matt D. Robinson" <yakker@alacritech.com> writes:

> It's an SMP (and only when your system crashes on a CPU other
> than 0) problem.  I did some more checking of this to verify the
> specifics of the behavior.  Thanks for the sarcasm, though. :)

O.k.  That makes perfect sense then.  See below.

> All I wanted was clarification as to why it was added in the first
> place, and whether there was a better way around the scenario.
> I think Ingo added the code, but I never heard back from him.
> Thanks for the response.

Welcome.  Linux attempts to properly shutdown the apics when we are
shutting down, and part of that is returning the apics to the mode
they were before we got control.  To do that you need to disable every
cpu but the bootstrap processor, and return the bootstrap processor to
either virtual wire mode or pic_mode.  So of course it will be the
only cpu getting interrupts because we are in legacy mode.

I would say it probably makes sense to add an additional call.
smp_send_panic_stop that does exactly what you need instead of what is
needed on the normal shutdown path. 

Eric
