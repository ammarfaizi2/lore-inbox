Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbUB0Nof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbUB0Nof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:44:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2946 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262868AbUB0No0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:44:26 -0500
Date: Fri, 27 Feb 2004 08:45:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Frank <mhf@linuxmail.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Mark Gross <mgross@linux.co.intel.com>, arjanv@redhat.com,
       Tim Bird <tim.bird@am.sony.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
In-Reply-To: <opr306i5cm4evsfm@smtp.pacific.net.th>
Message-ID: <Pine.LNX.4.53.0402270838210.6853@chaos>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
 <1077859968.22213.163.camel@gaston> <opr30muhyf4evsfm@smtp.pacific.net.th>
 <20040227090548.A15644@flint.arm.linux.org.uk> <opr306i5cm4evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Michael Frank wrote:

> On Fri, 27 Feb 2004 09:05:48 +0000, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > On Fri, Feb 27, 2004 at 02:26:31PM +0800, Michael Frank wrote:
> >> Is this to imply that edge triggered shared interrupts are used anywhere?
> >
> > It is (or used to be) rather common with serial ports.  Remember that
> > COM1 and COM3 were both defined to use IRQ4 and COM2 and COM4 to use
> > IRQ3.
> >
> >> Never occured to me to use shared IRQ's edge triggered as this mode
> >> _cannot_ work reliably for HW limitations.
> >
> > The serial driver takes great care with this - when we service such an
> > interrupt, we keep going until we have scanned all the devices until
> > such time that we can say "all devices are no longer signalling an
> > interrupt".
> >
> > This is something it has always done - it's nothing new.
> >
>
> Sorry, i think the serial driver IRQ is level triggered :)

           CPU0       CPU1
  0:    7904936    7922491    IO-APIC-edge  timer
  1:      74277      70096    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:        535        556    IO-APIC-edge  serial <--- EDGE
  4:          2          1    IO-APIC-edge  serial <--- EDGE
 10:    3435637    3440251   IO-APIC-level  eth0
 11:     295018     296838   IO-APIC-level  BusLogic BT-958
 13:       4567       4591   IO-APIC-level  Analogic(tm) AMX/AFF Driver
 14:       1331       1239   IO-APIC-level  Analogic(tm) DSP/DSS Driver
 15:          2          3   IO-APIC-level  Analogic(tm) VXI/MSG Driver
NMI:          0          0
LOC:   15826338   15826337
ERR:          0
MIS:          2

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


