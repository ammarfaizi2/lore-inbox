Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCZPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCZPz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCZPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:55:56 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:20743
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261153AbVCZPzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:55:50 -0500
Date: Sat, 26 Mar 2005 07:55:49 -0800
From: Phil Oester <kernel@linuxace.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Luca <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326155549.GA5881@linuxace.com>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr> <20050326151005.D12809@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326151005.D12809@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
> Doesn't matter.  The problem is that dwmw2's NS16550A patch (from ages
> ago) changes the prescaler setting for this device so we can use the
> higher speed baud rates.  This means any programmed divisor (programmed
> at early serial console initialisation time) suddenly becomes wrong as
> soon as we fiddle with the prescaler during normal UART initialisation
> time.

FWIW, I see the same thing here on some Dell Poweredge boxes:

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<garbage>

But intererstingly, on identical boxes, the garbage only appears on
those hooked up to a PortMaster device - those using a Cyclades never
display this problem. (???)

Phil
