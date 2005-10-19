Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVJSLXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVJSLXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVJSLXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:23:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17836 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750728AbVJSLW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:22:59 -0400
Date: Wed, 19 Oct 2005 13:22:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: scsi_eh / 1394 bug - -rt7
Message-ID: <20051019112246.GA32378@elte.hu>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com> <1129693423.8910.54.camel@mindpipe> <1129695564.8910.64.camel@mindpipe> <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> > usb 2-1: USB disconnect, address 2
> > prev->state: 2 != TASK_RUNNING??
> > scsi_eh_0/12648[CPU#0]: BUG in __schedule at kernel/sched.c:3326
> >  [<c01048b9>] dump_stack+0x19/0x20 (20)
> >  [<c011e766>] __WARN_ON+0x46/0x80 (12)
> >  [<c02c0bf7>] __schedule+0x547/0x790 (84)
> >  [<c012057a>] do_exit+0x26a/0x430 (28)
> >  [<c010147b>] kernel_thread_helper+0xb/0x10 (1020129312)
> >
> 
> This is also a problem in the upstream kernel.  It's just that RT 
> catches it!  Here's the patch. I'll also write one for the upstream 
> kernel, although this patch would probably work there as well. But 
> I'll make it official.
> 
> Ingo,
> 
> Here's the patch.  The problem is similar to the pcmcia bug.  It seems 
> that the loop usually exits in the TASK_INTERRUPTIBLE state.

thanks, applied and released in 2.6.14-rc4-rt10.

	Ingo
