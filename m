Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTC0WH6>; Thu, 27 Mar 2003 17:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTC0WG1>; Thu, 27 Mar 2003 17:06:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:21518 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261412AbTC0WGI>;
	Thu, 27 Mar 2003 17:06:08 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 correct scheduling of idle tasks [ all arch ] 
In-reply-to: Your message of "Thu, 27 Mar 2003 16:54:47 BST."
             <16003.7879.340300.737153@gargle.gargle.HOWL> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Mar 2003 09:17:12 +1100
Message-ID: <19527.1048803432@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003 16:54:47 +0100, 
mikpe@csd.uu.se wrote:
>Keith Owens writes:
> > There are several inconsistencies in the scheduling of idle tasks and,
> > for UP, tracking which task is on the cpu.  This patch standardizes
> > idle task scheduling across all architectures and corrects the UP
> > error, it is just a bug fix.
>...
> > To make it worse, on UP a task is assigned to a cpu but never released.
> > Very quickly, all tasks are marked as currently running on cpu 0 :(.
>
>->cpus_runnable and task_has_cpu() are SMP-only, as a quick grep
>through 2.4.20 will tell you. There is no UP bug here to fix.

cpus_runnable has task_has_cpu are not guarded by CONFIG_SMP.
task_set_cpu() is called for UP as well as SMP.  UP is missing the
corresponding call to task_release_cpu().

