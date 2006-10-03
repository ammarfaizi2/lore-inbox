Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWJCX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWJCX1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030683AbWJCX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:27:50 -0400
Received: from www.osadl.org ([213.239.205.134]:25302 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030682AbWJCX1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:27:49 -0400
Subject: Re: [patch 03/23] GTOD: persistent clock support, i386
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20061002154432.ed090fd9.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060929234439.158061000@cruncher.tec.linutronix.de>
	 <20060930013612.92e12313.akpm@osdl.org>
	 <1159826617.27968.22.camel@localhost.localdomain>
	 <20061002154432.ed090fd9.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 01:30:00 +0200
Message-Id: <1159918200.1386.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 15:44 -0700, Andrew Morton wrote:
> > -	write_seqlock_irqsave(&xtime_lock, flags);
> > -	jiffies_64 += sleep_length;
> > -	write_sequnlock_irqrestore(&xtime_lock, flags);
> >  	touch_softlockup_watchdog();
> >  	return 0;
> >  }
> 
> In this version of the patch, you no longer remove the
> touch_softlockup_watchdog() call from timer_resume().
> 
> But clockevents-drivers-for-i386.patch deletes timer_resume()
> altogether.
> 
> Hence we might need to put that re-added touch_softlockup_watchdog() call
> into somewhere else now.

clockevents has is it in the resume path.

static void clockevents_resume_local_events(void *arg)
{
....
        touch_softlockup_watchdog();
}

	tglx


