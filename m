Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTDNLZE (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDNLZD (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:25:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262749AbTDNLZB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 07:25:01 -0400
Date: Mon, 14 Apr 2003 12:36:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 pcmcia - insmod ds.ko hangs
Message-ID: <20030414123645.B13664@flint.arm.linux.org.uk>
Mail-Followup-To: Sean Estabrooks <seanlkml@rogers.com>,
	linux-kernel@vger.kernel.org
References: <1050319324.31740.13.camel@linux1.classroom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050319324.31740.13.camel@linux1.classroom.com>; from seanlkml@rogers.com on Mon, Apr 14, 2003 at 07:22:04AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:22:04AM -0400, Sean Estabrooks wrote:
> # insmod pcmcia_core.ko
> # insmod yenta_socket.ko
>     PCI: Found IRQ 11 for device 00:0b.0
>     PCI: Sharing IRQ 11 with 01:00.0
>     Yenta IRQ list 04b0, PCI irq11
>     Socket status: 30000020
>     PCI: Found IRQ 11 for device 00:0b.1
>     PCI: Sharing IRQ 11 with 00:0c.0
>     Yenta IRQ list 04b0, PCI irq11
>     Socket status: 30000007
> # insmod ds.ko  
>     PCI: Enabling device 02:00.0 (0000 -> 0003)
>     [hang]
> 
>   And hangs here permanently, and i should mention it hangs 
> the same way when compiled into the kernel.  Changing to
> another virtual console and bringing up the network works
> without a hitch, but the insmod above never returns.

Known problem - don't insert ds.ko with any cards in the sockets.
It's caused by a deadlock in the device model handling, caused by
the expectations of PCMCIA.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

