Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293410AbSCKAjT>; Sun, 10 Mar 2002 19:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293411AbSCKAjJ>; Sun, 10 Mar 2002 19:39:09 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:2579 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293410AbSCKAiz>; Sun, 10 Mar 2002 19:38:55 -0500
Date: Mon, 11 Mar 2002 01:38:53 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
Message-ID: <20020311013853.A1545@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <1015784104.1261.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1015784104.1261.8.camel@phantasy>; from rml@tech9.net on Sun, Mar 10, 2002 at 01:15:03PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 01:15:03PM -0500, Robert Love wrote:
> 
> This patch implements
> 
>         int sched_set_affinity(pid_t pid, unsigned int len,
>                                unsigned long *new_mask_ptr);
> 
>         int sched_get_affinity(pid_t pid, unsigned int *user_len_ptr,
>                                unsigned long *user_mask_ptr)
> 
> which set and get the cpu affinity (task->cpus_allowed) for a task,
> using the set_cpus_allowed function in Ingo's scheduler.  The functions
> properly support changes to cpus_allowed, implement security, and are
> well-tested.

Setting the affinity of a whole process group also makes sense IMHO.
Therefore I think an interface more like the setpriority syscall
for sched_set_affinity (with two parameters which/who instead of a
single PID) would be more flexible, eg.

    int sched_set_affinity(int which, int who, unsigned int len,
                           unsigned long *new_mask_ptr);

with who one of {PRIO_PROCESS,PRIO_PGRP,PRIO_USER} and which according
to the value of who.


Getting the mask of a group of processes doesn't make sense though
(what if they differ?), so the current interface of sched_get_affinity
is just fine IMHO.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
