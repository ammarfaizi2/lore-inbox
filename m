Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCRXVj>; Mon, 18 Mar 2002 18:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSCRXV2>; Mon, 18 Mar 2002 18:21:28 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:40604 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S293242AbSCRXVP>; Mon, 18 Mar 2002 18:21:15 -0500
Message-Id: <5.1.0.14.2.20020318151528.02ed4d70@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 18 Mar 2002 15:20:50 -0800
To: jt@hpl.hp.com, "Richard B. Johnson" <root@chaos.analogic.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: Killing tasklet from interrupt
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318125743.A26532@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > You have the tasklet kill itself the next time it executes. Set some
> > flag so it knows it should give up its timer-slot and expire. The
> > interrupt sets the flag. It doesn't do anything else.
>
>         I already have this flag and my code mostly work like this, so
>that would be trivial to do.
>         I looked at the code, and you are right, killing the tasklet
>within itself is by far the safest way to do it.
Sounds like what you need is tasklet_disable.
tasklet_kill needs process context so you can't use it in timer.

>It's a shame that the code doesn't explitely allow for it (i.e. you will 
>deadlock every time
>in tasklet_unlock_wait(t);).
Use tasklet_disable_nosync within the tasklet itself.

Max




