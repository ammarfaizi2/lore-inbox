Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVJYULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVJYULX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVJYULX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:11:23 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:54147 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932336AbVJYULW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:11:22 -0400
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Steven Rostedt <rostedt@goodmis.org>
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <435E8EDE.30306@mvista.com>
References: <1130250219.21118.11.camel@localhost.localdomain>
	 <20051025142848.GA7642@elte.hu>
	 <1130268292.21118.22.camel@localhost.localdomain>
	 <435E8EDE.30306@mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 25 Oct 2005 16:10:50 -0400
Message-Id: <1130271050.21118.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 13:00 -0700, George Anzinger wrote:
> Steven Rostedt wrote:
> >
> > 
> > Isn't the jiffy tick implemented with the PIT when possible? So the apic
> > is only used when a timer is needed.  Also note that this "lockup"
> > happens on boot up while things are being initialized, so not many
> > things may be using the timer.
> 
> Somewhere in the not too distant past the NMI watchdog was moved from the PIT tick to the APIC 
> timer.  Might want to move it back, at least for now...
> > 

Actually, I submitted a patch to Ingo, (and I guess it would also work
with Thomas' kthrt as well), that takes the nmi tick out of the timer
code completely (at least for x86) and moves it to the __do_IRQ.  This
way, it would detect when something is locked up with interrupts
disabled, but you don't worry about having the right timer configured
for it.

If you want to detect the timer being screwed up, that can be done on a
timer by timer basis, and most likely the soft lockup would find that
out too.

-- Steve


