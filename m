Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131912AbRCVCmL>; Wed, 21 Mar 2001 21:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbRCVCmC>; Wed, 21 Mar 2001 21:42:02 -0500
Received: from scaup.prod.itd.earthlink.net ([207.217.121.49]:7343 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131912AbRCVClx>; Wed, 21 Mar 2001 21:41:53 -0500
Message-ID: <3AB9664B.10451E6D@mcn.net>
Date: Wed, 21 Mar 2001 19:41:15 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Will Newton <will@misconception.org.uk>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103211333440.1541-100000@dogfox.localdomain> <3AB8B877.D36E8719@mandrakesoft.com> <20010321144907.D1323@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Wed, Mar 21, 2001 at 09:19:35AM -0500, Jeff Garzik wrote:
> 
> > Attempting to pretend that the parallel port is not in an interrupt
> > driven mode by passing irq=none is folly.
> 
> No, that's not what it's for.  It means 'for Christ sake don't use
> interrupts, I know what I'm doing'.
> 
> > If irq=none is passed to tell the Via code to -force- the parallel
> > port into a non-irq-driven mode is one thing.  If irq=none is passed
> > to hide a problem with spurious interrupts, we need to fix that
> > problem, not hide it.
> 
> irq=none is passed in order to diagnose whether a problem happens on
> only the interrupt-driven path or not.  Read the trouble-shooting
> section parport.txt.  Understand that there are lots of printing code
> paths nowadays (polling, interrupt-driven, PIO, DMA, etc).
> 
> > I still am not convinced that irq=<anything> should affect the Via
> > code at all.  Maybe I can print out a message "irq=foo ignored".
> 
> Jeff, it needs to.  If you want to make irq=auto the default
> (currently it's 'probe only'), then that is an entirely different
> thing.
> 
> When the user tells you not to use interrupts, you'd better not.
> 
> > Optionally, I could handle irq=none by force-disabling the parallel
> > port's interrupt driven modes, if they are active.
> 
> What the hell for?  Just don't use the interrupts.
> 
> Tim.
> */
> 

Hi, Tim

What is the default anyway?  My BIOS is 0x378, 7, 3 and the driver
reports this:

0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!       [Don't know why it always reports
this]
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO
[PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)

With no options in modules.conf, lp0 uses polling; with irq=auto
dma=auto
it uses interrupt-driven but no dma?.

-- 
===============
-- Tim
