Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVBKJxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVBKJxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVBKJxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:53:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36592 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262230AbVBKJxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:53:34 -0500
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <george@mvista.com>, "'William Weston'" <weston@lysdexia.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Date: Fri, 11 Feb 2005 01:53:32 -0800
Message-ID: <000601c5101f$8ca3c1e0$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050211082841.GA3349@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo wrote:

> 
> * Sven Dietrich <sdietrich@mvista.com> wrote:
> 
> > This patch adds a config option to allow you to select 
> whether timer 
> > IRQ runs in thread or not.
> 
> this patch only changes xtime_lock back and forth - it does 
> in no way impact the 'threadedness' of the timer IRQ. (it 
> does not move the timer IRQ into an interrupt thread.)
> 
> nor do we really want to make it configurable - it's 
> non-threaded right now and we'll see what effect this has on 
> the worst-case latencies. 
> 
> 	Ingo
> 

Its clear that there are all sorts of issues 
with process accounting and other race conditions
associated with running the timer in a thread.

The timer IRQ does have a noticable impact 
especially on the slower CPUS. In this domain,
precise process time accounting may not be 
all that important, as long as the scheduler
does not get confused, and that lone NODELAY
IRQ doesn't get delayed (as much).

It would be nice if some of the process 
accounting could be pipelined or deferred,
but I don't have those answers right now.

Sven

