Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264454AbSIVSZg>; Sun, 22 Sep 2002 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264455AbSIVSZg>; Sun, 22 Sep 2002 14:25:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:16144
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264454AbSIVSZg>; Sun, 22 Sep 2002 14:25:36 -0400
Subject: Re: 2.5.38 scheduling oops? at boot
From: Robert Love <rml@tech9.net>
To: scott781@attbi.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209220749280.918-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0209220749280.918-200000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 14:30:45 -0400
Message-Id: <1032719445.10108.988.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 09:04, Scott M. Hoffman wrote:

>   I booted into 2.5.38 on a dual amd duron system using profile=2 on 
> command line, and the system seemed a bit sluggish just to get bash to 
> complete a filename in /proc.  I found the attached oops after these  
> messages:
> 	Starting migration thread for cpu 1
> 	bad: Scheduling while atomic!
> ...
> Trace; c01186ed <schedule+3d/430>
> Trace; c0118d9c <wait_for_completion+9c/100>
> Trace; c0118b30 <default_wake_function+0/40>
> Trace; c0118b30 <default_wake_function+0/40>
> Trace; c011a2c5 <set_cpus_allowed+145/170>
> Trace; c011a33e <migration_thread+4e/340>
> Trace; c011a2f0 <migration_thread+0/340>
> Trace; c0106f0d <kernel_thread_helper+5/18>
> Trace; c01186ed <schedule+3d/430>
> Trace; c0118d9c <wait_for_completion+9c/100>
> Trace; c0118b30 <default_wake_function+0/40>
> Trace; c0118b30 <default_wake_function+0/40>
> Trace; c011a2c5 <set_cpus_allowed+145/170>
> Trace; c012274f <ksoftirqd+4f/f0>
> Trace; c0122700 <ksoftirqd+0/f0>
> Trace; c0106f0d <kernel_thread_helper+5/18>

This particular occurrence is known; thanks.  The startup of the
migration_threads calls set_cpus_allowed(), and set_cpus_allowed()
sleeps while disabling preemption.

It will not hurt anything, but it needs to be fixed.  Before that, I
need to find out why set_cpus_allowed() dies without the
preempt_disable() in there.

	Robert Love

