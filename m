Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUJYTqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUJYTqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbUJYTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:46:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:33723 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261259AbUJYTpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:45:00 -0400
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all kernels
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2004 21:44:57 +0200
In-Reply-To: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
Message-ID: <p73u0sik2fa.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> writes:

> I had a customer on x86 notice that sometimes offset 0xf in the CMOS
> RAM was getting set to invalid values.  Their BIOS used this for
> information about how to boot, and this caused the BIOS to lock up.
> 
> They traced it down to the following code in arch/kernel/traps.c (now
> in include/asm-i386/mach-default/mach_traps.c):
> 
>     outb(0x8f, 0x70);
>     inb(0x71);              /* dummy */
>     outb(0x0f, 0x70);
>     inb(0x71);              /* dummy */

Just use a different dummy register, like 0x80 which is normally used
for delaying IO (I think that is what the dummy access does) 

But I'm pretty sure this NMI handling is incorrect anyways, its
use of bits doesn't match what the datasheets say of modern x86
chipsets say. Perhaps it would be best to just get rid of 
that legacy register twiddling completely.

I will also remove it from x86-64.

-Andi
