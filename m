Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966675AbWKYQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966675AbWKYQcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966669AbWKYQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:32:47 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:3500 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S966659AbWKYQcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:32:46 -0500
Date: Sat, 25 Nov 2006 09:32:43 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 1/2] Introduce mutex_lock_timeout
Message-ID: <20061125163242.GH14076@parisc-linux.org>
References: <20061109182721.GN16952@parisc-linux.org> <20061125035526.GF14076@parisc-linux.org> <200611251700.39806.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611251700.39806.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 05:00:27PM +0100, Ingo Oeser wrote:
> Ok, I will comment it. But I'll NOT comment on the implementation.
> I'll prove you instead, that timout based locking is non-sense.

Your proof misses a case and is thus invalid.

> What should the timout mutex_timeout() prevent? Usually the answer is 
> "if sombody hangs on a mutex forever ...?" and people tell you "ok, that is
> a deadlock -> fix your code not to deadlock instead."
> Then they tell you "Ok, but if somebody takes a mutex too long?"
> and people will answer "ok, then this is a livelock -> fix your code not to 
> livelock."
> 
> Another answer is "I like to block until sth. happens wihin a specific time frame" 
> -> fine, this is accomplished by wait_event_timout (which blocks only you and 
> not every other user of the mutex).

In the qla case, the mutex can be acquired by a thread which then waits
for the hardware to do something.  If the hardware locks up, it is
preferable that the system not hang.

> I know why ACPI needs it (API requirement) and I think the qla???-driver
> just needs to be fixed to work without it and nobody did it yet.

Since Christoph is the one who has his name on it:
/* XXX(hch): crude hack to emulate a down_timeout() */

I assumed that he'd spent enough time thinking about it that fixing it
really wasn't feasible.

