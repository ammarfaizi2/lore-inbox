Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUAUS5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUAUS5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:57:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:45455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266064AbUAUS5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:57:05 -0500
Date: Wed, 21 Jan 2004 10:56:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Georg C. F. Greve" <greve@gnu.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Loschwitz <madkiss@madkiss.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <m3isj5a73u.fsf@reason.gnu-hamburg>
Message-ID: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
References: <m3isj5a73u.fsf@reason.gnu-hamburg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004, Georg C. F. Greve wrote:
> 
> I'm now seeing the _exact same problem_ on an ASUS M2400N [*] with a
> Linux 2.6.1 (unpatched) kernel. The kernel freezes after printing 
> 
>  "ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd" 

Does it go away if you just make "acpi_pic_set_level_irq()" do nothing (ie 
just remove the "outb()" call

	arch/i386/kernel/acpi/boot.c line 273

or just make the if-statement be always false).

It's entirely possible that the SCI is just horribly broken, and can't be 
level-triggered.

Btw, usually a good idea to at least cc the developer list for the 
particular subsystem. In this case <acpi-devel@lists.sourceforge.net>. 
Many people don't have the time to follow linux-kernel.

		Linus
