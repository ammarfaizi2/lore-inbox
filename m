Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTBJV5Q>; Mon, 10 Feb 2003 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTBJV5P>; Mon, 10 Feb 2003 16:57:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52751 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265270AbTBJV5P>; Mon, 10 Feb 2003 16:57:15 -0500
Date: Mon, 10 Feb 2003 17:03:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
In-Reply-To: <Pine.LNX.3.95.1030207152853.31273A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1030210165537.29699A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Richard B. Johnson wrote:

> If the code is correct, it really should be written as:
> 
>    for (new2size = 128; new2size < newsize; new2size <<= 1)
>        ;
> 
> The code seems to want to make the value of new2size a power of
> 2 and, greater than 128, but less than newsize. It ignores the
> fact that newsize might be less than 128, maybe this is okay.

Power of two - yes. Greater than 128 no, if newsize were <=128 new2size
would not increment. Previous code may make newsize larger (and later
limit new2size) but not here. And new2size can be equal to newsize, again
by this code.

A comment like /*empty_loop*/ before the semicolon would help human
readability. Code should be readable by humans, too.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

