Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272358AbTHIOCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272359AbTHIOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:02:54 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:63899 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S272358AbTHIOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:02:53 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
Date: Sat, 9 Aug 2003 15:05:45 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091505.45295.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Sunday 13 July 2003 22:51, Davide Libenzi wrote:
> This should (hopefully) avoid other tasks starvation exploits :
>
> http://www.xmailserver.org/linux-patches/softrr.html

   "We will define a new scheduler policy SCHED_SOFTRR that will make the
   target task to run with realtime priority while, at the same time, we will
   enforce a bound for the CPU time the process itself will consume."

This needs to be a global bound, not per-task, otherwise realtime tasks can 
starve the system, as others have noted.

But the patch has a much bigger problem: there is no way a SOFTRR task can be 
realtime as long as higher priority non-realtime tasks can preempt it.  The 
new dynamic priority adjustment makes it certain that we will regularly see 
normal tasks with priority elevated above so-called realtime tasks.  Even 
without dynamic priority adjustment, any higher priority system task can 
unwttingly make a mockery of realtime schedules.

So this approach will not produce the desired result.  To do this properly, 
each realtime task has to have greater priority than any nonrealtime task, 
and obviously, a global bound on realtime CPU share has to be enforced.

Regards,

Daniel

