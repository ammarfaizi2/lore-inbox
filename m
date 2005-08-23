Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVHWCD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVHWCD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 22:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHWCDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 22:03:55 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:21859 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751320AbVHWCDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 22:03:55 -0400
Message-ID: <430A8408.4040101@bigpond.net.au>
Date: Tue, 23 Aug 2005 12:03:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: [ANNOUNCE][RFC] PlugSched-6.0 for 2.6.12 and 2.6.13-rc6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 23 Aug 2005 02:03:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version contains the following changes:

1. upgrade the staircase scheduler to version 11.6,
2. major reorganization of the spa_no_frills and zaphod code to clean up 
the mechanism by which they share code.  This includes the definition of 
a simple interface which can be used to extend spa_no_frills to create 
new schedulers relatively easily, and
3. a new scheduler, spa_ws, which is an extension of spa_no_frills 
intended for use on work stations.

The spa_ws aspires to provide good interactive responsiveness and glitch 
free audio/video playing by giving tasks that are forking or waking from 
a sleep a "latency bonus".  The latency bonus is composed of a small 
fixed bonus plus a component based on the tasks sleepiness.  Certain 
tasks (e.g. those with a "nice" value greater than zero or tagged with 
the TASK_NONINTERACTIVE flag do not receive any bonus as it is assumed 
that latency is not an issue for these tasks).  This scheduler tries to 
identify audio/video tasks based on the regularity of their wake 
intervals and their length (currently between 10 and 100 milliseconds) 
and if it does so gives them a bonus one greater than the maximum that 
could be attained for other tasks subject to their cpu usage rate being 
less than a specified minimum.  The mechanisms involved are very simple 
in an attempt to not degrade the compute performance of the scheduler.

A patch for 2.6.12 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.0-for-2.6.12.patch?download>

and for 2.6.13-rc6 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.0-for-2.6.13-rc6.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills, spa_ws or zaphod.  If you don't 
change the default when you build the kernel the default scheduler will 
be ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
