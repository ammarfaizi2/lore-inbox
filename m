Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWCXXKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWCXXKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWCXXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:10:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbWCXXKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:10:30 -0500
Date: Fri, 24 Mar 2006 15:12:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink_gt add gpio feature
Message-Id: <20060324151245.299ff2c1.akpm@osdl.org>
In-Reply-To: <44247812.1040301@microgate.com>
References: <1143216251.8513.3.camel@amdx2.microgate.com>
	<20060324141929.1fff0c15.akpm@osdl.org>
	<44247812.1040301@microgate.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> Andrew Morton wrote:
> > Adding new generic-looking infrastructure into a driver is a worry.  Either
> > we're missing some facility, or the driver is doing something unnecessary
> > or the driver's requirements are unique.
> > 
> > Tell use more about conditional waits?
> 
> I needed a way to wake only processes waiting for specific
> GPIO transitions out of 32 signals, with 2 possible transitions
> per signal (up/down). I also need to return the state of all signals
> to each waiter as exists at the time the specific transition occurs.
> This has to be done in the ISR as that state is lost when
> the interrupt is cleared. So I implemented a wrapper around
> the existing wait code that allows waking only processes waiting
> for specific transitions and passing the associated state back
> to each woken process.
> 
> I could use the existing wait infrastructure and wake
> all threads waiting on any GPIO transition. That could
> cause a lot of unnecessary waking/sleeping. I would also still
> need to implement some way to relay the associated state for
> each individual transition to the correct waiter.
> 
> I could implement a separate normal wait queue for each
> transition type (64 queues), but that seems excessive.

OIC.

> The wrapper seems to be the minimal and most efficient
> way of implementing this. Maybe I missed some existing
> infrastructure that implements the same features?

wait_on_bit()/wake_up_bit() might be usable?

