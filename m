Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWECONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWECONE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWECOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:13:03 -0400
Received: from www.tglx.de ([213.239.205.147]:12420 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965195AbWECONC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:13:02 -0400
Subject: Re: 2.6.17-rc3-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060503064816.ef7ec2b7.akpm@osdl.org>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	 <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
	 <20060503064816.ef7ec2b7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 03 May 2006 16:15:32 +0200
Message-Id: <1146665732.27820.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 06:48 -0700, Andrew Morton wrote:
> > Since a few -mm releases I am seeing processes stuck in a
> > nanosleep({0, 0}, NULL) syscall. Sometimes, they unfreeze after
> > several hours.
>
> Thanks.   Yes, please test mainline first - it will probably occur there.
> 
> And it's a nanosleep(zero) all the time?  The obvious answer would be that
> a clock tick came in at the right time and we end up trying to sleep for -1
> units.  But if that was the case, things wouldn't unsleep after just
> several hours.

I don't see how that should happen. The expiry time is stored in
absolute time format when nanosleep is started and compared against
current time in the softirq. We might miss one tick, but not more.

Benoit, can you please mail me .config and a boot log ?

	tglx


