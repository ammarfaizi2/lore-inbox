Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRHXUCV>; Fri, 24 Aug 2001 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272311AbRHXUCL>; Fri, 24 Aug 2001 16:02:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48900 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272304AbRHXUBy>; Fri, 24 Aug 2001 16:01:54 -0400
Subject: Re: Is it bad to have lots of sleeping tasks?
To: ddade@digitalstatecraft.com
Date: Fri, 24 Aug 2001 21:05:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F45F3VcuiDqPkMseLHP00010e68@hotmail.com> from "Donald Dade" at Aug 24, 2001 12:39:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aNCX-0006PH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My questions are these:
> 1) Are there any kernel structures that are O(n) or just as bad, where n is 
> the total number of processes, not just the total number of runnable 
> processes? i.e. will the performance of the system be adversely affected by 
> the number of tasks in wait queues?

Linus scheduler is pretty dire beyond about 8 runnable threads, but very 
good below that. It also has a refresh loop that is O(n) tasks, which is
strange, and actually looks easily to eliminate.

The critical bit is threads runnable at any given time. When that is low as
it is in almost all normal workloads the performance of the scheduler is
very good indeed.

> 2) If I have 1000 threads, and each calls sleep(), I assume that my 
...
> difference in the system's responsiveness?

Read kernel/timer.c.

Alan
