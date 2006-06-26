Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933297AbWFZW5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbWFZW5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933310AbWFZW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:57:44 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:34754 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S933303AbWFZW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:57:39 -0400
Date: Mon, 26 Jun 2006 18:54:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
To: Bjorn Steinbrink <B.Steinbrink@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606261856_MC3-1-C384-91D6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060625184244.GA11921@atjola.homenet>

On Sun, 25 Jun 2006 20:42:44 +0200, Bjorn Steinbrink wrote:

> Btw, which path do apic irqs go? I stumbled across the nmi stuff, but
> didn't see anything special for the apic irqs.

arch/i386/kernel/entry.S has the macro BUILD_INTERRUPT(name, nr).

The code that uses this macro is in arch/i386/mach-*/entry_arch.h.

The macro prepends "smp_" to the name passed to the macro and the
generated asm code calls that function after saving registers, etc.

arch/i386/kernel/apic.c::apic_intr_init() calls set_intr_gate() to
point some of the interrupt gates at the correct functions.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
