Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUCEMvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbUCEMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:51:46 -0500
Received: from uh02.cern.ch ([137.138.53.31]:1152 "EHLO uh02.cern.ch")
	by vger.kernel.org with ESMTP id S262580AbUCEMvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:51:41 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <E1AzEnk-00020j-00@uh02.cern.ch>
From: Anton Empl <empl@cern.ch>
Date: Fri, 05 Mar 2004 13:51:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


this is not to complain but rather to report and try to sort out problems
experienced with the 2.6.x kernel for quite a long time. I am not a kernel
expert so please forgive any not helpful statements here. Also, the hardware
used is a Thinkpad T30 (2366-96U) laptop and all might just be specific to
that system.


 APM/ACPI
-----------
There is no problem when using APM and suspending to ram - the system will
turn off the LCD display at the end just fine. But when using ACPI
(the BIOS is updated and other ACPI features work just fine) the system
will suspend and NOT turn the LCD back-light off. This is true for both
running X11 or not.


 CPU speed
-----------
Another detail is that unless one responds to the boot manager (here grub)
quickly with a RETURN to start the boot process the system will come up at
about half the actual CPU speed (1.2GHz instead of 2GHz) independent of
selecting CPUfreq stuff. Absolutely repeatable. The system is still recognized
as:
     CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07


 USB hub
-----------
Since this system only has USB1 available internally I purchased a PCMCIA
USB2 hub (ATEN USB 2.0 2 Port Host Control Card: PU-212). Inserting this
card into a running kernel about every other time locks up the system. The
lockup is more likely if the card is inserted later. Here's a transcript
(by hand) of the oops:

  *pde=    00000000
  Oops:    0002 [#1]
  CPU:     0
  EIP:     0060: [<f8a079e9>] Not tainted
  EFLAGS:  00010296

  EIP is at end_unlink_async+0x1a/0xf6 [ehci_hcd]

  Process usb.agent

  Call trace:    ehci_work
                 ehci_irq
                 usb_hcd_irq
                 handle_IRQ_event
                 do_IRQ
                 common_interrupt

  kernel panic: fatal exception in interrupt
  In interrupt handler - not syncing


I can certainly provide more information but the problems described above
are rather independent of the actual details of building the kernel and
rather stable.

thanks,


Anton.Empl@cern.ch

