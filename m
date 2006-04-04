Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWDDL6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWDDL6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWDDL6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 07:58:03 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56459 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932356AbWDDL6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 07:58:01 -0400
Date: Tue, 4 Apr 2006 13:57:45 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Ingo Molnar <mingo@elte.hu>
Cc: Simon Derr <simon.derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
In-Reply-To: <20060328204944.GA1217@elte.hu>
Message-ID: <Pine.LNX.4.61.0604041344000.15050@openx3.frec.bull.fr>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk>
 <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
 <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon>
 <20060328204944.GA1217@elte.hu>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/04/2006 14:00:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/04/2006 14:00:08,
	Serialize complete at 04/04/2006 14:00:08
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Ingo Molnar wrote:

> 
> * Simon Derr <simon.derr@bull.net> wrote:
> 
> > On Mon, 27 Mar 2006, Ingo Molnar wrote:
> > 
> > > i've released -rt10
> > 
> > Is anyone working on a port of this patch to the IA64 architecture ?
> 
> not that i know of. If someone wants to do that, take a look at the 
> x86_64 changes (or ppc/mips/i386 changes) to get an idea. These are the 
> rough steps needed:
> [snip]


Work in progress... (based on -rt11)
So far I have a kernel that almost boots, but not quite.

First issue: 'BUG: udev:45 task might have lost a preemption check!'

When looking at the code in preempt_enable_no_resched(), why is the value 
of preempt_count() checked to be non-zero _after_ calling 
dec_preempt_count() ?

I saw several posts on this list claiming that this message is harmless, 
but I'd like to figure what's going on.

My boot process is stuck later when insmod loads the driver for the MPT 
Fusion SCSI adapter. It's waiting for a second interrupt to arrive, and 
that never happens.

I see that the -rt patch touches many drivers by changing calls to 
local_irq_save (and friends), changing the type of the semaphores, but the 
MPT driver makes no use of these.

Any ideas ?

Thanks, 

	Simon.

