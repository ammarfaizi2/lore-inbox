Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275329AbTHGNQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275332AbTHGNQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:16:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22286 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275329AbTHGNQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:16:53 -0400
Date: Thu, 7 Aug 2003 14:16:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tim Small <tim@buttersideup.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Roskin <proski@gnu.org>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI yenta-alikes
Message-ID: <20030807141650.C25908@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Small <tim@buttersideup.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Roskin <proski@gnu.org>,
	linux-pcmcia@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com> <20030807100211.A17690@flint.arm.linux.org.uk> <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk> <3F324DDE.3040409@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F324DDE.3040409@buttersideup.com>; from tim@buttersideup.com on Thu, Aug 07, 2003 at 02:02:22PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 02:02:22PM +0100, Tim Small wrote:
> "device control register bits2,1:  R/W, Interrupt mode.
> Bits 2 1 select the interrupt mode used by the PCI1031. Bits 2 1 are 
> encoded as: 00 = No interrupts enabled (default) 01 = ISA 10 = 
> Serialized IRQ type interrupt scheme 11 = Reserved"

When you look at some other TI device, you'll notice that these bits
have a similar meaning, but, for instance 10 will be reserved (because
the device doesn't support Serialised ISA IRQs) but supports 11 (serial
PCI IRQs.)  00 means PCI IRQ mode only on some TI devices, and is a
valid setting.

You can do what you're suggesting as long as you take account of the
device itself.  However, once you've decided the device isn't setup,
how can the kernel determine exactly what the _correct_ setup of the
device is?  You can't say "well, its a PCI1031 device, therefore I'll
select ISA interrupt mode" because you don't know if it has been
wired up that way.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

