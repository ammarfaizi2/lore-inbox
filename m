Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTBBBW5>; Sat, 1 Feb 2003 20:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBBBW5>; Sat, 1 Feb 2003 20:22:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15631 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265095AbTBBBW4>;
	Sat, 1 Feb 2003 20:22:56 -0500
Date: Sun, 2 Feb 2003 02:28:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Simon Kirby <sim@netnation.com>
Subject: [Nearly Solved]: APIC routing broken on ASUS P2B-DS
Message-ID: <20030202012820.GB19346@alpha.home.local>
References: <20030128004906.GA3439@netnation.com> <20030128060629.GA19346@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128060629.GA19346@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 07:06:29AM +0100, Willy Tarreau wrote:
> On Mon, Jan 27, 2003 at 04:49:06PM -0800, Simon Kirby wrote:
> > Something broke between 2.4.20 and 2.4.21-pre3 which is causing
> > interrupts to not be routed the second CPU.  I saw the problem on one box
> > and copied the kernel to another which then had the same problem (both
> > ASUS P2B-DS boards, one with PIII CPUs, one with PII CPUs).  

Hi !

I noticed that 2.4.21-pre4 had the same problem whereas -ac1 and -aa1 worked
fine. But unfortunately, this was unrelated since both use irq_balance which
seems to work around or fix the problem. So I searched back the earlier
versions, and finally narrowed this problem down to the introduction of
CONFIG_X86_NUMA and associated code in 2.4.21pre1.

If I compile my kernel for an SMP K7, only CPU0 gets the interrupts. But if
I enable CONFIG_X86_CLUSTERED_APIC by enabling either CONFIG_X86_NUMAQ or
CONFIG_X86_SUMMIT (CONFIG_X86_NUMA alone isn't enough), then I get my interrupts
distributed across both CPUs. This is on an Asus A7M266D with 2 Athlon XP 1800+.
I don't know if this option can affect performance or stability.
BTW, the system runs in Flat APIC mode, as reported at boot time. I can provide
dmesg on request, but didn't want to pollute the list.

I looked through the code but since I don't know much about APIC, I didn't
understand the changes nor how they would affect what I observed.

Anyone has any clue ?

Cheers,
Willy

