Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTKCREZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTKCREZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:04:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:34469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262156AbTKCREU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:04:20 -0500
Date: Mon, 3 Nov 2003 09:04:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Charles Martin <martinc@ucar.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: interrupts across  PCI bridge(s) not handled
In-Reply-To: <004201c3a224$bad501b0$c3507580@atdsputnik>
Message-ID: <Pine.LNX.4.44.0311030859190.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Charles Martin wrote:
>
> I have a pci backplane extender, with 4 cards 
> (named piraq) in it. The cards are detected by 
> the PCI system, and irqs 92-95 are assigned, 
> as shown in /var/log/messages:
> 
> kernel: PCI->APIC IRQ transform: (B6,I4,P0) -> 93 
> kernel: PCI->APIC IRQ transform: (B6,I6,P0) -> 95 
> kernel: PCI->APIC IRQ transform: (B6,I7,P0) -> 92
> kernel: PCI->APIC IRQ transform: (B6,I9,P0) -> 94

Can you enable APIC_DEBUG debugging in "include/asm-i386/apic.h", and make 
sure that you build the kernel with a big printk buffer. Then, in case 
your distribution comes with a broken "dmesg" binary that doesn't show 
more than about 20kB of data, compile this trivial program and run it 
after bootup, and send the whole log out..

It would be a pity to have to boot with "noapic", since this is exactly 
the kind of situation where you _want_ the extra interrupts.

		Linus

- stupid-dmesg.c -
#include <sys/klog.h>

int main(int argc, char **argv)
{
	static char buffer[128*1024];
	int i;

	i = klogctl(3, buffer, sizeof(buffer));
	if (i > 0)
		write(1, buffer, i);
}


