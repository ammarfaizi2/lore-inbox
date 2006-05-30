Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWE3OaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWE3OaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWE3OaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:30:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:37354 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932271AbWE3O37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:29:59 -0400
Subject: Re: -rt IA64 update
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060530061503.GA19870@elte.hu>
References: <Pine.LNX.4.61.0605291356170.14092@openx3.frec.bull.fr>
	 <20060530061503.GA19870@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 07:20:41 -0700
Message-Id: <1148998842.23411.11.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 08:15 +0200, Ingo Molnar wrote:
> * Simon Derr <Simon.Derr@bull.net> wrote:
> > * This kernel, when booting, prints:
> > 
> > 	BUG in check_monotonic_clock at kernel/time/timeofday.c:164
> > 
> > But I think this happens because two get_monotonic_clock() are racing 
> > on two cpus. There is a lock to prevent the race, but it is a seqlock. 
> > That means that it is okay if the race happens since another try will 
> > be attempted, but the message that has been printed on the console 
> > can't be removed, and the user is unnecessarily scared.

Simon, I suspect here you actually have unsynced ITCs, as the
check_monotonic_clock values are all locked w/ spinlocks.

You should probably add a cmpxchg in clocksource_itc_read() where you
currently do the if (last_itc < now), or you'll race on setting
last_itc. Let me know if you still see the issue w/ that fix.


> that too comes from the GTOD patchset. John, should we pick up the 
> latest from -mm?

It would be nice to do so sooner or later. There will probably be a few
regressions as the bits in -mm are more stripped down then the older
code in -rt, but I'd work to fill those holes as they appeared.

Thomas, did you have any thought about the hrt code I sent you?
 
thanks
-john


