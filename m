Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTHSXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTHSXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:50:24 -0400
Received: from holomorphy.com ([66.224.33.161]:3458 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261528AbTHSXuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:50:21 -0400
Date: Tue, 19 Aug 2003 16:51:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by cpumask_t conversion
Message-ID: <20030819235126.GC4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org
References: <mnCB.1md.29@gated-at.bofh.it> <m3y8xpqktd.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y8xpqktd.fsf@averell.firstfloor.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:
> Nasty.
> But why does i386/UP work?

On Wed, Aug 20, 2003 at 01:39:10AM +0200, Andi Kleen wrote:
> > (I believe this is the correct thing to do, except having
> > CONFIG_X86_IO_APIC in generic code isn't quite right.)
> Better would be to undo the cpumask_t changes in io_apic.c
> and go back to unsigned long masks there again.
> Obviously a cpu mask is not the right data structure to manage APICs
> Another way would be to do whatever i386 does to avoid the problem.
> The IO-APIC code is unfortunately quite out of date/unsynced compared to i386,
> maybe it just needs some bug fix ported over. I will check that later.

Odd; I have a UP IO-APIC ia32 box here and it appears to do okay; there
is a question of sparse APIC ID's and APIC ID space needing to be
independent of NR_CPUS handled in the ia32 code that isn't handled in
the x86_64 code. It was handled for ia32 by using a bitmap of size
MAX_APICS (physid_mask_t) instead of cpumask_t for the things, which
appears to eliminate various special cases for xAPIC's too.


-- wli
