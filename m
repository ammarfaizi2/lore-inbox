Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271214AbTHCVYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTHCVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:24:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42253 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271214AbTHCVXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:23:18 -0400
Date: Sun, 3 Aug 2003 22:23:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jochen Friedrich <jochen@scram.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dahinds@users.sourceforge.net
Subject: Re: PCI1410 Interrupt Problems
Message-ID: <20030803222314.C15221@flint.arm.linux.org.uk>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dahinds@users.sourceforge.net
References: <Pine.LNX.4.44.0308032205210.25885-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308032205210.25885-100000@gfrw1044.bocc.de>; from jochen@scram.de on Sun, Aug 03, 2003 at 10:15:09PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 10:15:09PM +0200, Jochen Friedrich wrote:
> when using this PCI Cardbus bridge, i got an interrupt assigned to the
> card by the BIOS, but no interrupts were ever delivered, at all. So no
> insert/remove events have been handled and devices couldn't generate
> interrupts, as well:
> 
> 02:0a.0 Class 0607: 104c:ac50 (rev 01)
> 02:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
>         Flags: bus master, medium devsel, latency 168, IRQ 9
>         Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>         Memory window 0: 14400000-147ff000 (prefetchable)
>         Memory window 1: 14800000-14bff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         16-bit legacy interface ports at 0001
> 
> It looks like the designers of this card "forgot" to put a sane
> configuration of the Multifunction Routing Register (0x8C) in their
> EEPROM. After setting up the INTA output pin of the PCI1410, the device
> started to work like a charm :-)
> 
> This i added to yenta_config_init():
> 
> config_writew(socket, 0x8C, 0x02);
> 
> I'm not sure if this will help with all of these devices of if it even
> makes problems on others. But it might be an idea to add a config option
> for this hack...

Can you provide the kernel messages without the hack applied please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

