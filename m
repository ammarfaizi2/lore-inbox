Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVAUIrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVAUIrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVAUIrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:47:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28317 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262323AbVAUIqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:46:07 -0500
Date: Fri, 21 Jan 2005 09:45:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
Message-ID: <20050121084557.GA29550@elte.hu>
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu> <41F0BFA4.5030107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F0BFA4.5030107@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> > so ->mark_offset and do_timer() go together, and happen under
> > xtime_lock. What problem is there if we do this?
> 
> We are trying to get an accurate picture of when, exactly in time,
> jiffies changes. [...]

but that's the point of allowing the threading of the timer interrupt. 
If you _have_ an interrupt source (and task) that _is_ more important
than the timer interrupt then so be it. Yes, the accuracy of timekeeping
may suffer.

so everything is relative, and the user decides which functionality
should have the better latency. do_offset() can take up to 10 usecs so
it's a latency source i'd like to keep out of the direct IRQ path, as
much as possible.

> We can handle (do today) some variability in this area, but, at least
> for RT systems, we would like to get this down to a small a window as
> possible. 

by default the timer interrupt has the highest priority, and you can
still change it to prio 99 to avoid any potential impact from RT tasks
or other interrupt threads.

	Ingo
