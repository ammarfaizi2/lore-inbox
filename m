Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422878AbWAMUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422878AbWAMUKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWAMUKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:10:09 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12280 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422878AbWAMUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:10:06 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137178506.15108.38.camel@mindpipe>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 15:09:51 -0500
Message-Id: <1137182991.8283.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 13:55 -0500, Lee Revell wrote:

> > 
> > If that's what you want to know?
> 
> I want to know if clock_gettime(CLOCK_MONOTONIC, *ts) is actually
> guaranteed to be monotonic on these machines AKA do we break POSIX
> compliance or not.

Nope it doesn't work :-(

I ran this test:
 http://www.kihontech.com/tests/rt/monotonic.c

And got this:

$ ./monotonic
main program pid=8477
hello from thread 0!
hello from thread 1!
hello from thread 2!
hello from thread 3!
hello from thread 4!
Failed! prev: 6279.925610302   current: 6279.874615349

$ cat /proc/cmdline
root=/dev/md0 ro console=ttyS0,115200 console=tty0 nmi_watchdog=2 lapic earlyprintk=ttyS0,115200 clock=pmtmr

$ uname -r
2.6.15-rt4-sr2

(I also added Ingo, Thomas, and John in the CC)

I'll reboot to vanilla 2.6.15 and see if that is broken too (just to
make sure)

-- Steve


