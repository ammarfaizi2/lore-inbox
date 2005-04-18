Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVDRNVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVDRNVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 09:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVDRNVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 09:21:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:2971 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262075AbVDRNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 09:21:32 -0400
Subject: Re: need help: scheduling
From: Steven Rostedt <rostedt@goodmis.org>
To: Gunter <mlkhma@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1113829211.6730.8.camel@linux.site>
References: <1113829211.6730.8.camel@linux.site>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 18 Apr 2005 09:21:28 -0400
Message-Id: <1113830488.4294.174.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 15:00 +0200, Gunter wrote:
> Hello
> 
> I need help about scheduling. I hope i understand the basics for my
> question: An active prozess counts the remaining cpu time in jifies. By
> every timer interrupt the scheduler decrements the variable time_slice.
> 

Yes, this is correct.

> Where is the scheduler initializing the interrupt timer (init_timer).
> And where gets the struct timer_list the next interrupt (expires). At
> last i want know where the scheduler calls add_timer. Or is there an
> other way?
> 

The timer_list you are mentioning is used for events that need to go off
at a certain jiffy. This is not what the scheduler uses.  The
schedule_tick (which keeps track of the time_slices of processes) goes
off at a timer interrupt once a jiffy. This is architecture dependent,
and for x86 you can take a look at arch/i386/kernel/time.c
timer_interrupt.  This is (usually) setup in
arch/i386/mach-default/setup.c. Search for timer_interrupt for the
details, and then follow the trail there.

-- Steve


