Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKHXqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKHXqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUKHXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:46:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:54990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbUKHXqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:46:45 -0500
Date: Mon, 8 Nov 2004 15:50:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mau <mau@oscar.ping.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Workaround for wrapping loadaverage
Message-Id: <20041108155051.53c11fff.akpm@osdl.org>
In-Reply-To: <20041108102553.GA31980@oscar.prima.de>
References: <20041108001932.GA16641@oscar.prima.de>
	<20041108012707.1e141772.akpm@osdl.org>
	<20041108102553.GA31980@oscar.prima.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(PLease don't remove people from Cc:.  Just do reply-to-all).

Patrick Mau <mau@oscar.ping.de> wrote:
>
> On Mon, Nov 08, 2004 at 01:27:07AM -0800, Andrew Morton wrote:
> > Patrick Mau <mau@oscar.ping.de> wrote:
> > >
> > >  We can only account for 1024 runnable processes, since we have 22 bits
> > >  precision, I would like to suggest a patch to calc_load in kernel/timer.c
> > 
> > It's better than wrapping to zero...
> > 
> > Why do we need 11 bits after the binary point?
> 
> I tried various other combinations, the most interesting alternative was
> 8 bits precision. The exponential values would be:
> 
> 1 / e (5/60) * 256
> 235.53
> 
> 1 / e (5/300) * 256
> 251.76
> 
> 1 / e (5/900) * 256
> 254.58
> 
> If you would use 236, 252 and 255 the last to load calculations would
> get optimized into register shifts during calculation. The precision
> would be bad, but I personally don't mind loosing the fraction.

What would be the impact on the precision if we were to use 8 bits of
fraction?

An upper limit of 1024 tasks sounds a bit squeezy.  Even 8192 is a bit
uncomfortable.  Maybe we should just reimplement the whole thing, perhaps
in terms of tuples of 32-bit values: 32 bits each side of the binary point?
