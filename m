Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTKHIJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 03:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTKHIJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 03:09:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59831 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261640AbTKHIJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 03:09:34 -0500
Date: Sat, 8 Nov 2003 09:05:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg OREL <oleg_orel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel preemption (kernel 2.6 of course)
In-Reply-To: <20031108012755.41882.qmail@web80007.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56.0311080808590.19316@earth>
References: <20031108012755.41882.qmail@web80007.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Oleg OREL wrote:

> I was browsing linux kernel to undetsnand how kernel preemption does
> work. I was hacking around schedulee_tick and other functions called out
> of timer interrupt and was unable to found any call to schedule() or
> switch_to() to peempt currently running task, instead just mangling
> around current and inactive runqueues.

the timer interrupt indeed cannot reschedule because interrupt contexts
must never schedule. But the timer interrupt does have the ability to
reschedule the currently running task, via setting the 'need resched'
flag:

                set_tsk_need_resched(p);

this flag then gets detected by the entry.S 'return from interrupt' code
[right when the timer irq returns] which then calls schedule().

	ingo
