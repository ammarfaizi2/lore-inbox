Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVBGMxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVBGMxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVBGMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:53:11 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:27524 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261412AbVBGMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:53:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Date: Mon, 7 Feb 2005 13:53:57 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <200502062015.56458.rjw@sisk.pl> <20050207085728.GA17197@elte.hu>
In-Reply-To: <20050207085728.GA17197@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502071353.57660.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 7 of February 2005 09:57, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > ah, ok. Could you try my patch and add touch_softlockup_watchdog() to
> > > the resume code (before interrupts are re-enabled)?
> > 
> > I did:
> > 
> > --- /home/rafael/tmp/kernel/testing/linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-05 20:57:03.000000000 +0100
> > +++ linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-06 19:07:39.000000000 +0100
> > @@ -871,6 +869,7 @@
> >  	restore_processor_state();
> >  	restore_highmem();
> >  	device_power_up();
> > +	touch_softlockup_watchdog();
> >  	local_irq_enable();
> >  	return error;
> >  }
> > 
> > and it still complains, but the call trace is now different:
> 
> could you describe the timings a bit more - how long it takes to do the
> resume, and when does the watchdog print out its warning.

The warning is printed right after the image is restored (ie somewhere
around the local_irq_enable() above, but it goes before the
"PM: Image restored successfully." message that is printed as soon as
the return is executed).  Definitely, less than 1 s passes between
the resoring of the image and the warining.

BTW, I've also tried to put touch_softlockup_watchdog() before
device_power_up(), but it didn't change much.

> Is it a single warning only, and once the resume succeeds, the watchdog
> doesnt complain anymore, correct?

Yes.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
