Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284272AbRLBTCT>; Sun, 2 Dec 2001 14:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284275AbRLBTCJ>; Sun, 2 Dec 2001 14:02:09 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:5567 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284272AbRLBTB7>; Sun, 2 Dec 2001 14:01:59 -0500
Date: Sun, 2 Dec 2001 12:01:58 -0700
Message-Id: <200112021901.fB2J1wM11465@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] wait_for_devfsd_finished deadlock
In-Reply-To: <20011201191113.A1034@holomorphy.com>
In-Reply-To: <20011201191113.A1034@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin, III writes:
> While testing 2.4.17-pre1 with some other patches, a situation
> reminiscent of a deadlock arose. mutt(1) would block indefinitely
> while opening a large mbox, and all further calls to sys_open()
> would block indefinitely.
> 
> After some further testing to isolate the problem, I reproduced this
> behavior in the vanilla 2.4.17-pre1 kernel. The sysrq output showed
> a number of processes with the following call trace in the devfs
> core:

Your sh process appears to be hung in wait_for_devfsd_finished(). It
would be helpful to know what devfsd was doing at this time. If it
were hung internally (in user-space), it would account for this
behaviour. However, if devfsd crashes, then devfsd_close() will be
called, which will wake any waiters.

> And the following call traces elsewhere:

Are these related?
cron		->	pipe_wait()
procmail	->	interruptible_sleep_on_locked()
exim		->	sys_wait4()

Maybe these are just waiting on mutt(1)?

> Further diagnostic information is available upon request.

That's what I like to hear. Set CONFIG_DEVFS_DEBUG=y and boot with
"devfs=dall" and send me the (verbose) kernel logs. That should show
the sequence of events that lead to this.

> Mr. Gooch, your attention to this matter is much appreciated.

Just "Richard" is fine. I'm not a fan of formality.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
