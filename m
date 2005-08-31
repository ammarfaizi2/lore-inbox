Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVHaAqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVHaAqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHaAqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:46:10 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:53961 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932307AbVHaAqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:46:09 -0400
Message-ID: <4314FDCF.3050502@bigpond.net.au>
Date: Wed, 31 Aug 2005 10:46:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: [ANNOUNCE][RFC] PlugSched-6.1 for 2.6.13
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 31 Aug 2005 00:46:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version contains a modified spa_ws scheduler with a more persistent 
bonus mechanism. Although the "bonus only at wake up" mechanism of the 
original worked well on the first systems it was tested on (an old SMP 
system and a 3GHz SMT system) subsequent tests on a 2GHz single 
processor system were disappointing.  (Apart from a bug in the original 
implementation) the primary reason for this was that the X server was 
not always able to complete its work in the first time slice after 
waking and had to try and complete it without the benefit of the bonus 
which causes obvious delays when the system is loaded.  The new 
mechanism is a simplification of the persistent interactive bonus 
mechanism in zaphod.

A patch for 2.6.13 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1-for-2.6.13.patch?download>

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
