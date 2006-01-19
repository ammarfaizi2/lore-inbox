Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWASVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWASVps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWASVps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:45:48 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:8531 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161437AbWASVpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:45:47 -0500
Message-ID: <43D00887.6010409@bigpond.net.au>
Date: Fri, 20 Jan 2006 08:45:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>
Subject: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and 2.6.16-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 19 Jan 2006 21:45:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version continues the major gutting of the SPA based schedulers to
reduce overhead.  The inclusion of the mechanisms for gathering and
displaying accrued scheduling statistics have been remove as they are 
not an integral part of the scheduler and were mainly there to help with 
tuning.  Sorry Jake, if you still need these for your genetic algorithm 
work I can provide a patch to add them to all schedulers?

Additionally, the mechanism for auto detection and preferential
treatment of media streamers in the spa_ws scheduler has been removed. 
The reason for this is that my testing shows that the performance of 
media streamers on spa_ws is adequate without it.

Modifications have been made to spa_ws to (hopefully) address the issues 
raised by Paolo Ornati recently and a new entitlement based 
interpretation of "nice" scheduler, spa_ebs, which is a cut down version 
of the Zaphod schedulers "eb" mode has been added as this mode of Zaphod 
performed will for Paolo's problem when he tried it at my request. 
Paolo, could you please give these a test drive on your problem?

A patch for 2.6.16-rc1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.2-for-2.6.16-rc1.patch?download>

and a patch for 2.6.16-rc1-mm1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.2-for-2.6.16-rc1-mm1.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs or zaphod. 
  If you don't change the default when you build the kernel the default 
scheduler will be ingosched (which is the normal scheduler).

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
