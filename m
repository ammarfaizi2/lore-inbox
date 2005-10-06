Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJFIsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJFIsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVJFIso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:48:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38826 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750757AbVJFIsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:48:43 -0400
Date: Thu, 6 Oct 2005 10:49:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051006084920.GB22397@elte.hu>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain>
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

> > ahh ... I would not be surprised if this caused actual problems on x64
> > in the upstream kernel too: using save_flags() over u32 will corrupt a
> > word on the stack ...
> >
> 
> Actually, it's still safe upstream.  The locks are taken via a function
> defined as:
> 
> unsigned long acpi_os_acquire_lock(acpi_handle handle)
> {
> 	unsigned long flags;
> 	spin_lock_irqsave((spinlock_t *) handle, flags);
> 	return flags;
> }
> 
> So a u32 flags with
> 
>   flags = acpi_os_acquire_lock(lock);
> 
> would be safe, unless a 64 bit machine stored the value of IR in the 
> upper word, which I don't know of any archs that do that.

ok. But this still looks very volatile. Nowhere do we guarantee (or can 
we guarantee) that silently zeroing out the upper 32 bits of flags is 
safe!

	Ingo
