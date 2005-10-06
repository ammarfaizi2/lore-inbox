Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVJFIKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVJFIKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJFIKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:10:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47851 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750728AbVJFIKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:10:22 -0400
Date: Thu, 6 Oct 2005 10:10:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051006081055.GA20491@elte.hu>
References: <20051004130009.GB31466@elte.hu> <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com> <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Found the problem.  You're using a 64 bit machine and flags in the 
> acpi code is defined as u32 and not unsigned long.  Ingo's tests put 
> some checks in the flags at the MSBs and these are being truncated.

ahh ... I would not be surprised if this caused actual problems on x64 
in the upstream kernel too: using save_flags() over u32 will corrupt a 
word on the stack ...

Andi?

	Ingo
