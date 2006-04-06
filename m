Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWDFKdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWDFKdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDFKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:33:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751144AbWDFKdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:33:14 -0400
Date: Thu, 6 Apr 2006 03:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [BUG] No PS/2 mouse in 2.6.16 - bisect result
Message-Id: <20060406033156.7de39739.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0604061145230.2262@be1.lrz>
References: <Pine.LNX.4.58.0604061145230.2262@be1.lrz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:
>
> As decribed in the thread
> http://groups.google.com/groups?selm=5V6m7-81J-11@gated-at.bofh.it ,
> my mouse does not work in 2.6.16.
> 
> Copying the drivers/input/mouse directory from 2.6.15 helped, but 
> bisecting gave the below result. Reverting this patch did help,
> so it must be some kind of conflict with an input patch, but I can't find 
> a way to make git tell me all commits between foo and bar affecting baz.
> I don't intend to do it manually.
> 

I assume you meant "didn't help"?

> 
> 8ba7b0a14b2ec19583bedbcdbea7f1c5008fc922 is first bad commit
> diff-tree 8ba7b0a14b2ec19583bedbcdbea7f1c5008fc922 (from 
> 91c0bce29e4050a59ee5fdc1192b60bbf8693a6d)
> Author: Linus Torvalds <torvalds@g5.osdl.org>
> Date:   Mon Mar 6 17:38:49 2006 -0800
> 
>     Add early-boot-safety check to cond_resched()
> 
>     Just to be safe, we should not trigger a conditional reschedule during
>     the early boot sequence.  We've historically done some questionable
>     early on, and the safety warnings in __might_sleep() are generally
>     turned off during that period, so there might be problems lurking.
> 
>     This affects CONFIG_PREEMPT_VOLUNTARY, which takes over might_sleep() 
> to
>     cause a voluntary conditional reschedule.
> 

I'd be suspecting that your bisection went wrong, frankly.

If you're sure this patch was the one, one thing you could do is to redo
the bisection, but unapply this patch each time, before compiling and
testing.


