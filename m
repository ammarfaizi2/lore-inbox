Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWANM4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWANM4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWANM4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:56:44 -0500
Received: from mail.gmx.net ([213.165.64.21]:9709 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932241AbWANM4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:56:43 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060114134639.00c453d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 14 Jan 2006 13:56:30 +0100
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 2/5]
  sched-alter_uninterruptible_sleep_interactivity.patch
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200601132123.12844.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

At 09:23 PM 1/13/2006 +1100, Con Kolivas wrote:
>Index: linux-2.6.15/kernel/sched.c
>===================================================================
>--- linux-2.6.15.orig/kernel/sched.c
>+++ linux-2.6.15/kernel/sched.c
>@@ -756,26 +756,17 @@ static int recalc_task_prio(task_t *p, u

<snip>

>+                       * If a task was sleeping with the noninteractive
>+                       * label do not apply this non-linear boost
>                         */
>-                       if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
>-                               if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
>-                                       sleep_time = 0;
>-                               else if (p->sleep_avg + sleep_time >=
>-                                               INTERACTIVE_SLEEP(p)) {
>-                                       p->sleep_avg = INTERACTIVE_SLEEP(p);
>-                                       sleep_time = 0;
>-                               }
>-                       }
>+                       if (p->sleep_type != SLEEP_NONINTERACTIVE || p->mm)

Typo alert.  Looks like that should be || 
!p->mm.                                     ^

         -Mike 

