Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283505AbRLDUyk>; Tue, 4 Dec 2001 15:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283432AbRLDUxH>; Tue, 4 Dec 2001 15:53:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:53508 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283524AbRLDUvl>;
	Tue, 4 Dec 2001 15:51:41 -0500
Subject: Re: [PATCH] improve spinlock debugging
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Cc: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <3C0D3283.4DA4DD2B@mvista.com>
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> 
	<3C0D3283.4DA4DD2B@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 15:51:41 -0500
Message-Id: <1007499102.1303.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 15:30, george anzinger wrote:

> spin_lockirq
> 
> spin_unlock
> 
> restore_irq

Given this order, couldn't we _always_ not touch the preempt count since
irq's are off?

Further, since I doubt we ever see:

	spin_lock_irq
	restore_irq
	spin_unlock

and the common use is:

	spin_lock_irq
	spin_unlock_irq

Isn't it safe to have spin_lock_irq *never* touch the preempt count?

	Robert Love

