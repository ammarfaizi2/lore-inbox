Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275440AbTHJAii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 20:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275442AbTHJAiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 20:38:24 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:32733 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S275440AbTHJAiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 20:38:22 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
Date: Sun, 10 Aug 2003 01:41:12 +0100
User-Agent: KMail/1.5.3
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308100141.13074.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 18:47, Mike Galbraith wrote:
> > But the patch has a much bigger problem: there is no way a SOFTRR task can
> > be realtime as long as higher priority non-realtime tasks can preempt it.
> > The new dynamic priority adjustment makes it certain that we will
> > regularly see normal tasks with priority elevated above so-called
> > realtime tasks.  Even without dynamic priority adjustment, any higher
> > priority system task can unwttingly make a mockery of realtime schedules.
>
> Not so.

Yes so.  A SCHED_NORMAL task with priority n can execute even when a 
SCHED_FIFO/RR/SOFTRR task of priority n-1 is ready.  In the case of FIFO and 
RR we don't care because they're already unusable by normal users but in the 
case of SOFTRR it defeats the intended realtime gaurantee.

> Dynamic priority adjustment will not put a SCHED_OTHER task above
> SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.

Are you sure?  I suppose that depends on the particular flavor of dynamic 
priority adjustment.  The last I saw, dynamic priority can adjust the task 
priority by 5 up or down.  If I'm wrong, please show me why and hopefully 
point at specific code.

On the other hand, this doesn't really matter, because the first problem above 
still exists, and causes the same result: attempted realtime scheduling that 
isn't.

Regards,

Daniel


