Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289398AbSAJLOX>; Thu, 10 Jan 2002 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289397AbSAJLOD>; Thu, 10 Jan 2002 06:14:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21956 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289368AbSAJLN6>;
	Thu, 10 Jan 2002 06:13:58 -0500
Date: Thu, 10 Jan 2002 14:11:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: kevin <kevin@koconnor.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lock order in O(1) scheduler
In-Reply-To: <1010640369.5335.289.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201101410510.2371-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jan 2002, Robert Love wrote:

> I believe the code should be:
>
>          if (target_cpu < smp_processor_id()) {
>                  spin_lock_irq(&target_rq->lock);
>                  spin_lock(&this_rq->lock);
>          } else {
>                  spin_lock_irq(&this_rq->lock);
>                  spin_lock(&target_rq->lock);
>          }
>
> Not so sure about unlocking.  Ingo?

yep, correct, good catch!

the unlocking order does not matter much.

	Ingo

