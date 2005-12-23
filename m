Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVLWAZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVLWAZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLWAZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:25:36 -0500
Received: from pat.uio.no ([129.240.130.16]:45453 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751222AbVLWAZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:25:35 -0500
Subject: Re: [PATCH] sched: Fix adverse
	effects	of	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 01:25:25 +0100
Message-Id: <1135297525.3685.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.95, required 12,
	autolearn=disabled, AWL 2.00, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 19:02 -0500, Kyle Moffett wrote:
> On Dec 22, 2005, at 17:59, Trond Myklebust wrote:
> > On Fri, 2005-12-23 at 09:33 +1100, Peter Williams wrote:
> >>> It still has sod all business being in the NFS code. We don't  
> >>> touch task scheduling in the filesystem code.
> >>
> >> How do you explain the use of the TASK_INTERRUPTIBLE flag then?
> >
> > Oh, please...
> >
> > TASK_INTERRUPTIBLE is used to set the task to sleep. It has NOTHING  
> > to do with scheduling.
> 
> Putting a task to sleep _is_ rescheduling it.  TASK_NONINTERACTIVE  
> means that you are about to reschedule and are willing to tolerate a  
> higher wakeup latency.  TASK_INTERRUPTABLE means you are about to  
> sleep and want to be woken up using the "standard" latency.  If you  
> do any kind of sleep at all, both are valid, independent of what part  
> of the kernel you are.  There's a reason that both are TASK_* flags.

Tolerance for higher wakeup latencies is a scheduling _policy_ decision.
Please explain why the hell we should have to deal with that in
filesystem code?

As far as a filesystem is concerned, there should be 2 scheduling
states: running and sleeping. Any scheduling policy beyond that belongs
in kernel/*.

  Trond

