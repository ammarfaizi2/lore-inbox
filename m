Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263037AbTCLFEB>; Wed, 12 Mar 2003 00:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263038AbTCLFEB>; Wed, 12 Mar 2003 00:04:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:18219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263037AbTCLFEA>;
	Wed, 12 Mar 2003 00:04:00 -0500
Message-Id: <5.2.0.9.2.20030312060926.00cfc920@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 06:19:16 +0100
To: jim.houston@attbi.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] self tuning scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E6E6B81.4E7CD256@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:04 PM 3/11/2003 -0500, Jim Houston wrote:
>Hi Mike
>
>I made a bit of progress on understanding the irman problem with
>my scheduler change.  When I run irman and top, the processes end
>up with priorities like:
>
>         irman parent    36
>         irman child     21
>         process_child   31-33   (group of 9 processes)
>
>Since I expanded the range of priorities (to 0-79) these are quite
>favorable priorities.  They are all have MAX_SLEEP_AVG bonus
>equivelent of nice +10.
>
>It's a priority inversion problem.  The irman child is waiting for
>a read.  The process_child processes are happly running as a group
>at approximately the same priority.  The irman parent is starved
>because it is at a lower priority.  It is at a lower priority because
>it uses more cpu on each pass.  It is doing the gettimeofday calls
>while the child only does the pipe read & write.  The parent gets
>an occasional boost from the fairness_update() code so it doesn't
>totally starve.

I forgot to mention something odd I encountered wrt the parent's 
priority.  I can set the irman child SCHED_RR, and it shows up in top with 
priority -2.  The parent remains at priority 36 and remains starved.  Max 
renice doesn't help either.

         -Mike 

