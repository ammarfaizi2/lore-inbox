Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVESMsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVESMsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVESMsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:48:21 -0400
Received: from odin2.bull.net ([192.90.70.84]:15266 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262474AbVESMsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:48:11 -0400
Subject: Re: Resent: BUG in RT 45-01 when RT program dumps core
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kus Kusche Klaus <kus@keba.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1116503763.15866.9.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1116506317.17833.34.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Thu, 19 May 2005 14:38:38 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 19/05/2005 à 13:56, Steven Rostedt a écrit :
> On Thu, 2005-05-19 at 08:36 +0200, kus Kusche Klaus wrote:
> > Quoting my mail from Apr 11th (received no response up to now):
...
> > > Apr 11 13:44:23 OF455 kern.err kernel: BUG: rtc2:833 RT task 
> > > yield()-ing!
> 
> This is a check that we have to flag when a RT task calls yield.  This
> in itself may not really be a bug, but it can be. There's places in the
> kernel that call yield to wait for a bit to clear or a lock to become
> unlock (doesn't grab it directly to prevent deadlocking).  This may be
> OK with non RT tasks, since other tasks will get a chance to run. But
> with RT tasks, a yield won't yield to any task with less priority than
> the RT task. So if the RT task is yielding to let a lower priority task
> do something it needs, it will in effect deadlock the system for all
> tasks lower in priority than itself.
> 
> > This is still absolutely reproducable, in RT 7.47-01,
> > with slight variations in the stack trace.
> > 
> > Is this something to worry about?
> 
> I'll take a look into it.
> 
> 
> Ingo,
> 
> Did you get my patch to fix the kstop_machine yielding problem?
> 
> -- Steve

Does it solve this problem ? is it the same ? I'm in RT 47-03.
If yes, I'm interested in this patch.
...
May 16 09:59:52 dtb2 kernel: BUG: kstopmachine:1037 RT task yield()-ing!
May 16 09:59:52 dtb2 kernel: [dump_stack+35/48]  (20)
May 16 09:59:52 dtb2 kernel: [<c01044b3>]  (20)
May 16 09:59:52 dtb2 kernel: [yield+101/112]  (20)
May 16 09:59:52 dtb2 kernel: [<c0344c55>]  (20)
May 16 09:59:52 dtb2 kernel: [stop_machine+261/368]  (40)
May 16 09:59:52 dtb2 kernel: [<c014c915>]  (40)
May 16 09:59:52 dtb2 kernel: [do_stop+21/128]  (20)
May 16 09:59:52 dtb2 kernel: [<c014c9b5>]  (20)
May 16 09:59:52 dtb2 kernel: [kthread+182/256]  (48)
May 16 09:59:52 dtb2 kernel: [<c013a576>]  (48)
May 16 09:59:52 dtb2 kernel: [kernel_thread_helper+5/16]  (140156956)
May 16 09:59:52 dtb2 kernel: [<c0101515>]  (140156956)
May 16 09:59:53 dtb2 kernel: ts: Compaq touchscreen protocol output
May 16 09:59:53 dtb2 kernel: Generic RTC Driver v1.07
...


