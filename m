Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVDETkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVDETkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDETh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:37:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:20666 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261928AbVDETgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:36:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 05 Apr 2005 15:36:02 -0400
Message-Id: <1112729762.5147.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our first victim!! :-) 

On Tue, 2005-04-05 at 20:06 +0100, Rui Nuno Capela wrote:
> >
> I'm having plenty of this on boot, on my SMP/HT desktop (P4/x86), while
> running RT-V0.7.44-01 (SMP+PREEMPT_RT):
> 
>   BUG: kstopmachine:xxxx RT task yield()-ing!
> 
> See sample dmesg and .config on attach.
> 
> OTOH, on my laptop (P4/UP), all seems to be clear fine.
> 

The kstopmachine is only run on SMP environments, so it won't show up on
your UP machine.


> Is this something to be affraid of? :)
> 

If your box is still running, then no.  But it's now a chore to remove
the yield from this algorithm, since yields have a possibility to
deadlock the system.  Although in this particular case, it may not be a
problem, since the threads that are being waited on are created for
other CPUs.  But I haven't looked too much into what stop_machine is
doing so I can very well be wrong.

Thank you for reporting it, we want to weed out all the yields that a RT
task may call.



-- Steve


