Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUBXMkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUBXMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:40:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32014 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262240AbUBXMkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:40:16 -0500
Date: Tue, 24 Feb 2004 12:40:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: daniel.ritz@gmx.ch
Cc: Pavel Roskin <proski@gnu.org>, Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Message-ID: <20040224124011.A30975@flint.arm.linux.org.uk>
Mail-Followup-To: daniel.ritz@gmx.ch, Pavel Roskin <proski@gnu.org>,
	Andrew Morton <akpm@osdl.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402240132.31659.daniel.ritz@gmx.ch> <Pine.LNX.4.58.0402231947520.30747@marabou.research.att.com> <200402241259.50046.daniel.ritz@alcatel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402241259.50046.daniel.ritz@alcatel.ch>; from daniel.ritz@alcatel.ch on Tue, Feb 24, 2004 at 12:59:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 12:59:50PM +0100, Daniel Ritz wrote:
> there's another bug btw. one that is probably never hit and harmless too:
> rmk's notbook has parellel isa interrupts, INTA is _not_ routed.

Not true.  It has parallel ISA interrupts _and_ parallel PCI interrupts.
It's a TI 1250.  Unfortunately, the 1250 data sheet isn't available,
however there seems to be some consistency in the device codes to
features offered.

The 1450 and 1251A (both of which seem similar to 1250) has separate pins
for PCI parallel interrupts which are outside the control of the "IRQMUX"
register.  When these pins are not used for parallel PCI interrupts,
they function as "GPIO3" and "IRQSER" (for PCI serial interrupts)
respectively.  The function of these pins is controlled by the device
control register.

Please note that "IRQMUX" is a misleading definition of the register in
question.  The register programs various multifunction pins on the device
which _may_ be IRQ outputs, LED outputs, ZV switching outputs, audio, or
even GPIO.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
