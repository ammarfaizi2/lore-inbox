Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272561AbTHFXJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272918AbTHFXJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:09:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43533 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272561AbTHFXJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:09:19 -0400
Date: Thu, 7 Aug 2003 00:09:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jochen Friedrich <jochen@scram.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dahinds@users.sourceforge.net
Subject: Re: PCI1410 Interrupt Problems
Message-ID: <20030807000914.J16116@flint.arm.linux.org.uk>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dahinds@users.sourceforge.net
References: <20030803222314.C15221@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308032347580.25885-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308032347580.25885-100000@gfrw1044.bocc.de>; from jochen@scram.de on Sun, Aug 03, 2003 at 11:52:29PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 11:52:29PM +0200, Jochen Friedrich wrote:
> The kernel messages don't differ if the hack is applied or not. The hack
> simply configures the PCI1410 to use a particular pin for INTA output.
> Without the hack, the counter for IRQ9 in /proc/interrupt simply stays at 0.
> 
> Aug  3 14:51:02 rt1-sp kernel: Linux Kernel Card Services 3.1.22
> Aug  3 14:51:02 rt1-sp kernel:   options:  [pci] [cardbus] [pm]
> Aug  3 14:51:02 rt1-sp kernel: PCI: Enabling device 02:0a.0 (0000 -> 0002)
> Aug  3 14:51:02 rt1-sp kernel: PCI: Found IRQ 9 for device 02:0a.0
> Aug  3 14:51:02 rt1-sp kernel: Yenta IRQ list 0000, PCI irq9
> Aug  3 14:51:02 rt1-sp kernel: Socket status: 30000010
> Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0c00-0x0cff: clean.
> Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0800-0x08ff: clean.
> Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3b8-0x3df 0x4d0-0x4d7
> Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0a00-0x0aff: clean.
> Aug  3 14:51:03 rt1-sp kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.

Ok, well, register 0x8c is highly machine specific, so we need to find
a way to identify your machine and fix it up based on that information.

Unfortunately, there are some hacks in the kernel at the moment which
mess up the Cardbus IRQ routing by touching this register - the kernel
should not be the one to play with hardware design specific register
settings, especially when they are applied without thought across
many hardware variants.

I notice your lspci didn't list a subvendor / subdevice ID for your
cardbus bridges - can you confirm by reporting the output of:

# setpci -s bus:slot.func 0x40.l

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

