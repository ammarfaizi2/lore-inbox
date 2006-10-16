Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWJPGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWJPGgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWJPGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:36:47 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:3071 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1161194AbWJPGgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:36:47 -0400
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op:
	`.cfi_signal_frame'
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <20061016061037.GA12020@elte.hu>
References: <20061016061037.GA12020@elte.hu>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 23:36:43 -0700
Message-Id: <1160980603.2388.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 08:10 +0200, Ingo Molnar wrote:
> using latest -git i'm getting this build bug on gcc 3.4:
> 
>  arch/x86_64/kernel/entry.S: Assembler messages:
>  arch/x86_64/kernel/entry.S:157: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:215: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:333: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:548: Error: unknown pseudo-op: `.cfi_signal_frame'
> 
>  gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)
> 
> using gcc 4.1 it doesnt happen
> 
>  gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
> 
> this is caused by the following commit:
> 
>  commit adf1423698f00d00b267f7dca8231340ce7d65ef
>  Author: Jan Beulich <jbeulich@novell.com>
>  Date:   Tue Sep 26 10:52:41 2006 +0200
> 
> reverting that patch solves the build problem and the resulting kernel 
> builds and boots fine.
> 
> 	Ingo

This is a binutils/gas feature; gcc has nothing to do with it. I take it
the gcc 4.1 system is FC5 with binutils 2.16.91.0.6-5 and the gcc 3.4
system is something older?

The kernel build system is supposed to detect gas support
for .cfi_signal_frame -- and while the i386 test is obviously broken
(the i386 test for the directive doesn't actually use the directive),
the AMD64 test looks like it should work (assuming as-instr works).

-- 
Nicholas Miell <nmiell@comcast.net>

