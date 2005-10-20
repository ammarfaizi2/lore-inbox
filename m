Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbVJTGz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbVJTGz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbVJTGz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:55:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3982 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751776AbVJTGzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:55:55 -0400
Date: Thu, 20 Oct 2005 08:56:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020065620.GA27349@elte.hu>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <20051019151138.GA7739@elte.hu> <Pine.LNX.4.58.0510200221200.27683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510200221200.27683@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > should be monotone - the latest -rt kernels include a debugging check
> > for the monotonicity of do_get_ktime_mono().
> 
> Hi Ingo,
> 
> Hmm, I think this will help in that debugging check :-)

> +	per_cpu(prev_mono_time, cpu) = now;
>  	return now;
>  }

*blush*, applied.

I was already wondering a bit why that check never triggered for anyone.  
It is easy to have a non-monotonic clock (there's lots of crappy hw and 
the gettimeofday code has to work hard) and the effects of time warps 
are subtle, if noticeable at all, so i expected some detections.

i have released -rt13 with another change: the other timer warning is 
only printed once. (a steady stream of messages is not helpful)

	Ingo
