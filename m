Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWBPCKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWBPCKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 21:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBPCKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 21:10:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751184AbWBPCJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 21:09:59 -0500
Date: Wed, 15 Feb 2006 18:08:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick
 length
Message-Id: <20060215180848.4556e501.akpm@osdl.org>
In-Reply-To: <17395.56186.238204.312647@cargo.ozlabs.ibm.com>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
	<20060215173545.43a7412d.akpm@osdl.org>
	<17395.56186.238204.312647@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew Morton writes:
> 
> > >  +	if ((time_adjust_step = time_adjust) != 0 ) {
> > 
> > <mutters something about coding style>
> 
> Seems perfectly plain to me, but if you don't like it I can change it.
> 

[random space before right-paren?]

	time_adjust_step = time_adjust;
	if (time_adjust_step) {

would be more conventional.  Some like the `!= 0' as well - personally I
find that a net distraction.

Ah, you copied-and-pasted from update_wall_time_one_tick().

Can we share that code?

> > 
> > >  +		/*
> > >  +		 * Limit the amount of the step to be in the range
> > >  +		 * -tickadj .. +tickadj
> > >  +		 */
> > >  +		time_adjust_step = min(time_adjust_step, (long)tickadj);
> > >  +		time_adjust_step = max(time_adjust_step, (long)-tickadj);
> > >  +	}
> > >  +	delta_nsec = tick_nsec + time_adjust_step * 1000;
> > 
> > Is that going to overflow if sizeof(long) == 4?
> 
> No.  time_adjust_step is in microseconds and is restricted to the
> range -tickadj .. tickadj, and tickadj is between 1 and 10 (assuming
> HZ >= 50).  tick_nsec is around 1e9 / HZ.  There's no way delta_nsec
> could end up less than 0 or larger than around 20 million for any
> reasonable HZ value (i.e. >= 50).
> 

ok...
