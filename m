Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSGJGbG>; Wed, 10 Jul 2002 02:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSGJGbG>; Wed, 10 Jul 2002 02:31:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317488AbSGJGbE>;
	Wed, 10 Jul 2002 02:31:04 -0400
Date: Thu, 11 Jul 2002 08:32:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) batch scheduler
In-Reply-To: <20020709223021.A4567@arizona.localdomain>
Message-ID: <Pine.LNX.4.44.0207110831350.3580-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Kevin O'Connor wrote:

> -			rq->idle_ticks_left = IDLE_TICKS;
> -			for (i = IDLE_SLOTS-1; i > 0; i--)
> -				rq->idle_count[i] = rq->idle_count[i-1];
> -			rq->idle_count[0] = 0;
> -			rq->idle_avg = recalc_idle_avg(rq);
> +			rq->idle_avg = (rq->idle_avg * (IDLE_SLOTS - 1)
> +					+ rq->idle_count) / IDLE_SLOTS;
> +			rq->idle_count = 0;

this part is buggy: ->idle_ticks_left needs to be reset in this branch.

	Ingo

