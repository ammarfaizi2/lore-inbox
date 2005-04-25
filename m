Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVDYSSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVDYSSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDYSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:18:05 -0400
Received: from s383.jpl.nasa.gov ([137.79.94.127]:50329 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S262714AbVDYSQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:16:42 -0400
Subject: IRQ Disabling
From: Al Niessner <Al.Niessner@jpl.nasa.gov>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2005 11:16:41 -0700
Message-Id: <1114453001.19173.47.camel@morte.jpl.nasa.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.3.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How do I prevent (do I need to install a new general handler or does the
report given below contain enough information to track down the
offending hardware) the disabling of an IRQ (shared) just because the
kernel things nobody cares?

I searched the archives already. I know the kernel I am using is a
distribution specific kernel and not the latest available. Meaning, I
know the problem that I am having may already be solved, but I doubt it
as the current behavior seems to be the optimal one in the general case
and, therefore, not a problem for the general user. Lastly, I lurk here
(archives actually) occasionally becoming active when I have a problem I
need a tad of help with.

uname -a == Linux bbb 2.6.8.1-12mdk #1 Fri Oct 1 12:53:41 CEST 2004 i686
Intel(R) Pentium(R) 4 CPU 2.40GHz unknown GNU/Linux

Report in /var/log/messages:
Apr 21 15:55:02 bbb kernel: irq 16: nobody cared!
Apr 21 15:55:02 bbb kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Apr 21 15:55:02 bbb kernel:  [<c0107bfe>] dump_stack+0x1e/0x20
Apr 21 15:55:02 bbb kernel:  [__report_bad_irq+43/144] __report_bad_irq
+0x2b/0x90
Apr 21 15:55:02 bbb kernel:  [<c01090ab>] __report_bad_irq+0x2b/0x90
Apr 21 15:55:02 bbb kernel:  [note_interrupt+144/176] note_interrupt
+0x90/0xb0
Apr 21 15:55:02 bbb kernel:  [<c01091c0>] note_interrupt+0x90/0xb0
Apr 21 15:55:02 bbb kernel:  [do_IRQ+224/256] do_IRQ+0xe0/0x100
Apr 21 15:55:02 bbb kernel:  [<c0109430>] do_IRQ+0xe0/0x100
Apr 21 15:55:02 bbb kernel:  [common_interrupt+24/32] common_interrupt
+0x18/0x20Apr 21 15:55:02 bbb kernel:  [<c010778c>] common_interrupt
+0x18/0x20
Apr 21 15:55:02 bbb kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Apr 21 15:55:02 bbb kernel:  [<c01050ed>] cpu_idle+0x2d/0x40
Apr 21 15:55:02 bbb kernel:  [start_kernel+388/448] start_kernel
+0x184/0x1c0
Apr 21 15:55:02 bbb kernel:  [<c0364824>] start_kernel+0x184/0x1c0
Apr 21 15:55:02 bbb kernel:  [L6+0/2] 0xc010019f
Apr 21 15:55:02 bbb kernel:  [<c010019f>] 0xc010019f
Apr 21 15:55:02 bbb kernel: handlers:
Apr 21 15:55:02 bbb kernel: [pg0+543305600/1069613056] (usb_hcd_irq
+0x0/0x70 [usbcore])
Apr 21 15:55:02 bbb kernel: [<e0a10f80>] (usb_hcd_irq+0x0/0x70
[usbcore])
Apr 21 15:55:02 bbb kernel: [pg0+548746464/1069613056] (apc8620_handler
+0x0/0xa0 [acromag8620])
Apr 21 15:55:02 bbb kernel: [<e0f414e0>] (apc8620_handler+0x0/0xa0
[acromag8620])
Apr 21 15:55:02 bbb kernel: Disabling IRQ #16

The apc8620 module subscribes to several interrupts and I think I
recognize those. It also looks like there is a usb handler on the same
IRQ. The primary problem is, I need to keep getting interrupts from that
hardware even though their is some piece of hardware that is
interrupting with no handler attached.

The question is then, how do I prevent the disabling of the interrupt
even though there is some rouge hardware generating unwanted signals?

Would it be best to:

1) Write some general handler that resets the IRQ and nothing else and
install it as the default handler instead of the current one that is
disabling the IRQ?

2) Is there critical information in the report from /var/log/messages
that I am missing or do not recognize that would allow me to locate and
identify the rouge hardware that is generating the anomalous interrupt?

3) Some other option that I am totally unaware of?

I am hoping for a solution that involves (2) more than any of the
others, but any and all help is appreciated.


-- 
Al Niessner
818.354.0859

All opinions stated above are mine and do not necessarily reflect those
of JPL or NASA.

--------
|  dS  | >= 0
--------

