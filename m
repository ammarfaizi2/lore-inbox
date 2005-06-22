Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVFVBTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVFVBTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVFVBTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:19:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58088 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262454AbVFVBTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:19:16 -0400
Date: Tue, 21 Jun 2005 18:19:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622011931.GF1324@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B77B8C.6050109@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 10:29:32PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > It looks to me that I-PIPE is an example of a "nested OS", with
> > Linux nested within the I-PIPE functionality. 
> 
> Sorry, the I-pipe is likely in the "none-of-the-above" category. It's
> actually not much of a category itself. For one thing, it's clearly
> not an RTOS in any sense of the word.
> 
> The I-pipe is just a layer that allows multiple pieces of code to
> share an interrupt stream in a prioritized fashion. It doesn't
> schedule anything or provide any sort of abstraction whatsoever.
> Your piece of code just gets a spot in the pipeline and receives
> interrupts accordingly. Not much nesting there. It's just a new
> feature in Linux.
> 
> Have a look at the patches and description posted by Philippe last
> Friday for more detail.

It is a bit of an edge case for any of the categories.

> > One could take
> > the RTAI-Fusion approach, but this measurement is of I-PIPE
> > rather than RTAI-Fusion, right?  (And use of RTAI-Fusion might
> > or might not change these results significantly, just trying to
> > make sure I understand what these specific tests apply to.)
> 
> That's inconsequential. Whether Fusion is loaded or not doesn't
> preclude a loaded driver to have a higher priority than
> Fusion itself and therefore continue receiving interrupt even if
> Fusion itself has disabled interrupts ...
> 
> The loading of Fusion would change nothing to these measurements.

OK...

> > Also, if I understand correctly, the interrupt latency measured
> > is to the Linux kernel running within I-PIPE, rather than to I-PIPE
> > itself.  Is this the case, or am I confused?
> 
> What's being measured here is a loadable module that allocates an
> spot in the ipipe that has higher priority than Linux and puts
> itself there. Therefore, regardless of what other piece of code
> in the kernel disables interrupts, that specific driver still
> has its registered ipipe handler called deterministically ...
> 
> Don't know, but from the looks of it we're not transmitting on
> the same frequency ...

Probably just my not fully understanding I-PIPE (to say nothing of
not fully understanding your test setup!), but I would have expected
I-PIPE to be able to get somewhere in the handfuls of microseconds of
interrupt latency.  Looks like it prevents Linux from ever disabling
real interrupts -- my first guess after reading your email was that
Linux was disabling real interrupts and keeping I-PIPE from getting
there in time.

						Thanx, Paul
