Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSFRSaX>; Tue, 18 Jun 2002 14:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSFRSaW>; Tue, 18 Jun 2002 14:30:22 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:59100 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317540AbSFRSaW>;
	Tue, 18 Jun 2002 14:30:22 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206181829.WAA13590@sex.inr.ac.ru>
Subject: Re: [PATCH] Replace timer_bh with tasklet
To: george@mvista.com (george anzinger)
Date: Tue, 18 Jun 2002 22:29:31 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D0F79CA.A0FAC230@mvista.com> from "george anzinger" at Jun 18, 2 11:19:54 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > But this is impossible, timers must not race with another BHs,
> > all the code using BHs depends on this. That's why they are BHs.
> 
> If indeed they do "race" the old code had the timer_bh being first.
> So does this patch.

I do not understand what you mean here.

I feel you misunderstand my comment. I said the patch is one pure big bug,
because tasklets are not serialized wrt BHs. Timer MUST. If you are going
to get rid of this must, start from editing all the code which makes this
assumption.


> This is one of the most hard to control paths in the system as ALL it 
> does is execute functions that are unknown as to size, duration, etc.
> One would hope that they never run for long, but...

Pardon, your code has an effect only after this "but..." happens
and this effect is insane.


> Not really.  One REALLY expects timers to expire in timed order :)  Using
> a separate procedure to deliver a timer just because it is of a different
> resolution opens one up to a world of pathology.

Are you going to mix use of hires and lores timers for one task?

Alexey
