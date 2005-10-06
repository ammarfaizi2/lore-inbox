Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJFJgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJFJgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJFJgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:36:33 -0400
Received: from ns1.suse.de ([195.135.220.2]:9092 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750770AbVJFJgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:36:33 -0400
Date: Thu, 6 Oct 2005 11:36:31 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051006093631.GB6642@verdi.suse.de>
References: <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com> <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006081055.GA20491@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 10:10:55AM +0200, Ingo Molnar wrote:
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Found the problem.  You're using a 64 bit machine and flags in the 
> > acpi code is defined as u32 and not unsigned long.  Ingo's tests put 
> > some checks in the flags at the MSBs and these are being truncated.
> 
> ahh ... I would not be surprised if this caused actual problems on x64 
> in the upstream kernel too: using save_flags() over u32 will corrupt a 
> word on the stack ...
> 
> Andi?

Yes it should be using unsigned long. The actual flag word is still
only 32bit, but the inline assembly expects 64bit. And save_flags 
might corrupt the target if it's too small.

Normally you should get a warning from warn_if_not_ulong() though.
You didn't get it in that case?  I don't remember any such warnings
from the ACPI code.

Which code does it exactly? 

-Andi
