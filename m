Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVFVT1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVFVT1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFVT1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:27:18 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:13066 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261612AbVFVTYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:24:32 -0400
Date: Wed, 22 Jun 2005 12:29:27 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622192927.GA13817@nietzsche.lynx.com>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B98B20.7020304@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 12:00:32PM -0400, Karim Yaghmour wrote:
> To tell you the truth, we've spent a considerable amount of time as
> it is on this and we need to move on to other things. So while we

Understood.

> I don't know what part of PREEMPT_RT causes this, but looking at
> some of the numbers from this output one is tempted to conclude that
> PREEMPT_RT causes a very significant impact on system load. And I
> don't say this lightly. Have a look for example at the local
> communication latencies between vanilla and PREEMPT_RT when the
> target is subject to the HD test. For a pipe, this goes from 9.4us
> to 21.6. For UDP this goes from 22us to 1070us !!! Even on a
> system without any load, the numbers are similar. Ouch.

I'm involved in other things now, but I wouldn't be surprised if it
was some kind of scheduler bug + softirq wacked interaction. softirqs,
from the last time I looked, was pretty raw in RT. Another thing to do
is to subtract the number of irq-thread context switches from the total
system context switch to see if there's any kind of oddities with the
spinlock conversion. I doubt there's going to be a ton of 'overscheduling',
nevertheless it would be a valuable number. This is such a new patch
that weird things like this are likely, but it's going to take an
investigation to see what the real cause is.

FreeBSD went through some slow down when they moved to SMPng, but not
the kind of numbers you show for things surrounding the network stack.
Something clearly bad happened.

bill

