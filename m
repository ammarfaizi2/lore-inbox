Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSFRFRp>; Tue, 18 Jun 2002 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSFRFRo>; Tue, 18 Jun 2002 01:17:44 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:23508 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317327AbSFRFRn>;
	Tue, 18 Jun 2002 01:17:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206180516.JAA11563@sex.inr.ac.ru>
Subject: Re: [PATCH] Replace timer_bh with tasklet
To: george@mvista.COM (george anzinger)
Date: Tue, 18 Jun 2002 09:16:54 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D0EACCA.3290139@mvista.com> from "george anzinger" at Jun 18, 2 08:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This patch replaces the timer_bh with a tasklet.

But this is impossible, timers must not race with another BHs,
all the code using BHs depends on this. That's why they are BHs. 

Also, looping for timers seems to be pure pathalogy.
It can be raised only if you looped in softirq for a jiffie,
in this case waking ksoftirqd is not unusual.

I feel your goal is high res timers, right? You can do them separately
to avoid conflicts with classic timers.

Alexey
