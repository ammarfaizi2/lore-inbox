Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTKWE6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTKWE6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 23:58:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:34783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263260AbTKWE6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 23:58:36 -0500
Date: Sat, 22 Nov 2003 20:58:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Darren Dupre <darren@dmdtech.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: irq 9: nobody cared! on 2.6.0-test9
In-Reply-To: <001a01c3b17a$b509f140$1e01a8c0@dmdtech2>
Message-ID: <Pine.LNX.4.44.0311222052590.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Nov 2003, Darren Dupre wrote:
>
>   9:     100000   IO-APIC-level  acpi (Curious note: Every time its done
> this, the count stops at 100000)

Not curious at all. That's the cut-off-point of the message: we only check
to complain about an interrupt after it has triggered spuriously (ie
nobody claimed to handle it) for 99900 times out of the last 100000 times
the interrupt happened.

So what seems to happen is that you have a lot of interrupts on irq9, but
each time they happen the ACPI interrupt handler says "it wasn't for me",
and we end up clearing the count. The kernel just doesn't react until it 
has seen a _lot_ of these spurious interrupts.

At that point it says "enough already, this irq is broken", and shuts it 
down.

		Linus

