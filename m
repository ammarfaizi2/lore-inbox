Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVDCLPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVDCLPR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVDCLPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:15:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:43958 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261666AbVDCLPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:15:10 -0400
Date: Sun, 3 Apr 2005 13:17:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: sched /HT processor
In-Reply-To: <BAY10-F53F98A846BEB2918701804D93A0@phx.gbl>
Message-ID: <Pine.LNX.4.62.0504031253060.2448@dragon.hyggekrogen.localhost>
References: <BAY10-F53F98A846BEB2918701804D93A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005, Arun Srinivas wrote:

> 
> I looked at my "include/asm-i386/param.h" and the HZ value is 1000.So, I
> suppose the timer interrupt frequency is 1000 times per sec. or once every 1
> millisec.
> 
> So, is scheduler_tick() ( for resceduling) called only once every 1 ms?? I am
> measuring the time when 2  of my processes are scheduled in a HT processor.So,
> the possible timedifference of when my 2 processes are scheduled can be only
> the following:
> 
> 1) 0 (if both of my processes are scheduled @ the same time since its a HT)
> 2) 1ms ( this is the min. possible time diff.
> 3) some value greater than 1 ms
> Is the above argument correct?

A reschedule can happen once every ms, but also upon returning to 
userspace and when returning from an interrupt handler, and also when 
something in the kernel explicitly calls schedule() or sleeps (which in 
turn results in a call to schedule()). And each CPU runs schedule() 
independently.
At least that's my understanding of it - if I'm wrong I hope someone on 
the list will correct me.


-- 
Jesper Juhl


