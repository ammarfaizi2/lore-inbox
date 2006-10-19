Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946372AbWJSTEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946372AbWJSTEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946382AbWJSTEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:04:11 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:58339 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946372AbWJSTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:04:09 -0400
Message-ID: <4537CC24.2070708@qumranet.com>
Date: Thu, 19 Oct 2006 21:04:04 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <4537C807.4@us.ibm.com>
In-Reply-To: <4537C807.4@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 19:04:08.0713 (UTC) FILETIME=[5AF0CF90:01C6F3B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Sorry if I missed this, but can you provide a link to the QEMU changes?
>

I'll do that once I get my sourceforge page and post it here.  Watch 
this space.


> It's hard to tell what's going on without seeing the userspace 
> portions of this.
>
> My initial impression is that you've taken the Xen approach of trying 
> to use QEMU only for IO emulation.  If this is the case, it won't work 
> long term.  While you can use vm86 mode for 16 bit virtualization for 
> most cases, it cannot handle big real mode.  You need the ability to 
> transfer down to QEMU and allow it to do emulation.
>

We started using VT only for 64 bit, then added 32 bit, then 16-bit 
protected, then vm86 and real mode.  We'd transfer the x86 state on each 
mode change, but it was (a) fragile (b) considered unclean.

You're right that "big real" mode is not supported, but so far that 
hasn't been a problem.  Do you know of an OS that needs big real mode?

> Ideally, instead of having as large of an x86 emulator in kernel 
> space, you would just drop down to QEMU to do emulation as needed 
> (doing only a single basic block and returning).  This would let you 
> have a much reduced partial emulator in kernel space that only did the 
> most common (and performance critical) instructions.
>

Over time that emulator would grow as OSes and compilers evolve... and 
we'd really like to keep basic things like the apic in the kernel (as 
does Xen).


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

