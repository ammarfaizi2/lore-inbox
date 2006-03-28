Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWC1ADu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWC1ADu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWC1ADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:03:50 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60079 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932101AbWC1ADt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:03:49 -0500
Date: Tue, 28 Mar 2006 02:03:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/2] hrtimer
In-Reply-To: <20060327235530.GA7024@oleg>
Message-ID: <Pine.LNX.4.64.0603280155350.17704@scrub.home>
References: <20060325121219.172731000@localhost.localdomain>
 <20060325121223.966390000@localhost.localdomain> <20060325183213.63ab667c.akpm@osdl.org>
 <1143411016.5344.139.camel@localhost.localdomain> <20060327235530.GA7024@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 28 Mar 2006, Oleg Nesterov wrote:

> I also think this is racy.
> 
> CPU_0					CPU_1
> 
> hrtimer_wakeup:
> 
> 	task = t->task;
> 	t->task = NULL;
> 
> 	<--- INTERRUPT --->
> 
> 					task is woken by signal,
> 					do_nanosleep() sees t->task == NULL,
> 					returns without hrtimer_cancel(),
> 					and __exits__.
> 
> 	<--- RESUME --->
> 
> 	wake_up_process(task);
> 
> Instead of exit(), 'task' can go to TASK_STOPPED or TASK_UNINTERRUPTIBLE
> after return from do_nanosleep(), it will be awakened by hrtimer_wakeup()
> unexpectedly.

Indeed and my original patch did call hrtimer_cancel() unconditionally to 
synchronize with a possibly running timer.
Thomas, could you please document it a bit better, when you modify my 
patches?

bye, Roman
