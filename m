Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSGIKao>; Tue, 9 Jul 2002 06:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSGIKan>; Tue, 9 Jul 2002 06:30:43 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:22190 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S313202AbSGIKam>;
	Tue, 9 Jul 2002 06:30:42 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207091030.OAA22445@sex.inr.ac.ru>
Subject: Re: readprofile from 2.5.25 web server benchmark
To: akpm@zip.COM.AU (Andrew Morton)
Date: Tue, 9 Jul 2002 14:30:38 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2A8B81.42042058@zip.com.au> from "Andrew Morton" at Jul 9, 2 11:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


> --- 2.5.25/kernel/timer.c~timer-speedup	Tue Jul  9 00:04:33 2002
> +++ 2.5.25-akpm/kernel/timer.c	Tue Jul  9 00:06:09 2002
> @@ -211,6 +211,9 @@ int mod_timer(struct timer_list *timer, 
>  	int ret;
>  	unsigned long flags;
>  
> +	if (timer_pending(timer) && timer->expires == expires)
> +		return 1;
> +
>  	spin_lock_irqsave(&timerlist_lock, flags);
>  	timer->expires = expires;
>  	ret = detach_timer(timer);

Does this not lose timer sometimes? 

Alexey

