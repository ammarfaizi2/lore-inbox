Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSH0S3F>; Tue, 27 Aug 2002 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSH0S3F>; Tue, 27 Aug 2002 14:29:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:37642 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S316684AbSH0S3F>;
	Tue, 27 Aug 2002 14:29:05 -0400
Date: Tue, 27 Aug 2002 20:33:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Lahti Oy <rlahti@netikka.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c
Message-ID: <20020827183319.GA28513@alpha.home.local>
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:15:03PM +0300, Lahti Oy wrote:
 
> - for (i = 0; i < NR_CPUS; i++)
> + for (i = NR_CPUS; i; i--)
>    sum += cpu_rq(i)->nr_running;

you change isn't equivalent : previously, we called cpu_rq() for
0..NR_CPUS-1, and now you call it for 1..NR_CPUS.

You should have written :
+ for (i = NR_CPUS - 1; i>=0; i--)
which might still be a win towards the former version.
But of course, this is only valid if i is SIGNED, and it isn't here.
Another valid form which would work with unsigned int is :
+ for (i = NR_CPUS; i--; )

but I'm not sure it will save some cycles because increments/decrements
within conditions are not always well optimizable.

Same comments for other locations.

Cheers,
Willy

