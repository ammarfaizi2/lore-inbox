Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVEEERB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEEERB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVEEERA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 00:17:00 -0400
Received: from fmr22.intel.com ([143.183.121.14]:61675 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261863AbVEEEQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 00:16:58 -0400
Subject: RE: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
From: Len Brown <len.brown@intel.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Asit K Mallick <asit.k.mallick@intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60049EE972@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB60049EE972@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1115266581.7644.52.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 May 2005 00:16:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 22:43, Pallipadi, Venkatesh wrote:

> The patch as it is should handle 8259 case using the regular APIC
> timer.  It only adds broadcast when IOAPIC is used for timer
> interrupt.

While they don't need the broadcast capability of this patch,
uniprocessors do need the change to stop using LAPIC timer
if they support C3 (as virtually all laptops do).
It was a mistake to allow using the LOC on a uniprocessor
in the first place -- as the UP system runs perfectly fine
with timers coming in on IRQ0 and doesn't need another interrupt.

Re: SMP using i8259
While Linux in ACPI mode allows "noapic" on SMP, it isn't recommended.
It is there for comparisons, debugging, and to work-around the odd
broken system.  It is an exception configuration, and supporting it
should in no way impact the design for other 99.99% normal systems.

Indeed, note that SMP systems using i8259 instead of IOAPIC
is explicity forbidden by MPS, and thus would probably fail
the compatibility test for your favorite high volume binary OS.

-Len


