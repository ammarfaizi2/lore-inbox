Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWBQUNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWBQUNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWBQUNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:13:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49082 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751644AbWBQUND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:13:03 -0500
Date: Fri, 17 Feb 2006 21:11:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, ce@ruault.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] timer-irq-driven soft-watchdog, cleanups
Message-ID: <20060217201123.GB29025@elte.hu>
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org> <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com> <20060216122045.7a664bc6.akpm@osdl.org> <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com> <20060217130801.GA16115@elte.hu> <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Sorry but I have enough more high priority issues to take care of and 
> I'm not going to spend any more time on soft lockups even if they are 
> really problems in IDE subsystem.  If this is not fixed before 2.6.16 
> I'm submitting patch to Linus making DETECT_SOFTLOCKUP depend on 
> "CONFIG_IDE=n"... at least users will be able to use their systems 
> instead of seeing lockups.

i have lots of IDE based systems (they dont use PIO though) and i'm not 
seeing these. I'll oppose such a patch if it's to hide genuine issues - 
the 10 seconds tolerance is already generous i think. I'll of course fix 
any false positives which are the fault of the softlockup-watchdog, but 
from your mails it appears to me that the IDE warnings are indeed 
genuine.

If the source of the delay is hard to fix you can temporarily work it 
around in the code by putting in the touch_softlockup_watchdog() lines - 
that will also document the places that cause long delays - which is a 
good thing.

It is entirely feasible to put a touch_softlockup_watchdog() call into 
every PIO OP - even a single-byte PIO related IN/OUT instruction takes a 
couple of microseconds, so a touch_softlockup_watchdog() wont even show 
up on the radar.

> DETECT_SOFTLOCKUP should be an aim in development not a method of 
> forcing driver maintainers to work on specific issues...

well, 10+ seconds delays on a running system are not really acceptable, 
and can cause other problems. The softlockup-watchdog is optional and 
can be easily turned off in the .config.

	Ingo
