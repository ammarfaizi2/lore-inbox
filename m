Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSEaNfp>; Fri, 31 May 2002 09:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSEaNef>; Fri, 31 May 2002 09:34:35 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:47499 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315287AbSEaNea>; Fri, 31 May 2002 09:34:30 -0400
Date: Fri, 31 May 2002 15:34:29 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531133429.GF8310@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that a 2.5 kernel boots again on my laptop (thanks to the ACPI
IRQ routing problems being resolved :-) ), I tested the different
USB host drivers available (I used to use usb-uhci before).

lspci:
	00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)

Results (only simple tests with a USB mouse performed):
	ehci-hcd.o
		does load, no output messages, does NOT work
	ohci-hcd.o 
		does load, no output messages, does NOT work
	uhci-hcd.o 
		does load, does work correctly
	usb-uhci-hcd.o
		does load, does work correctly.


1. Shouldn't the ehci/ohci drivers give some error on loading,
since I obviously don't have the hardware ?

2 When doing a rmmod on one of the two last drivers, 
the kernel oopses with a (hand copied trace):

	bad EIP: c784fbda <[usbcore]rh_report_status+63/143>
	
	c0118f34 <__run_task_queue+61/6a>
	c784f677 <[usbcore]usb_reset_device+1d4/2df>
	c011be58 <timer_bh+22b/27c>
	c0118e48 <bh_action+26/74>
	c0118d79 <tasklet_hi_action+38/59>
	c0118bb7 <do_softirq+57/b1>
	c01099a0 <do_IRQ+da/e5>
	c0108656 <common_interrupt+22/28>
	c01abd54 <acpi_processor_idle+e9/1eb>
	c0106b54 <gunzip+45c/4bc>
	c0106bd0 <default_idle+0/27>
	c01abc6b <acpi_processor_idle+0/1eb>
	c0106bd0 <default_idle+0/27>
	c0106c5a <cpu_idle+2e/3d>
	c0105000 <_stext+0/0>

Another one:
	bad EIP: <c78ed365> <[yenta_socket]yenta_allocate_resources+d/41>

	Adhoc c011be58 <timer_bh+22b/27c>
	Adhoc c0118e48 <bh_action+26/74>
	Adhoc c0118d79 <tasklet_hi_action+38/59>
	Adhoc c0118bb7 <do_softirq+57/b1>
	Adhoc c01099a0 <do_IRQ+da/e5>
	Adhoc c0108656 <common_interrupt+22/28>
	Adhoc c01abd54 <acpi_processor_idle+e9/1eb>

I'm not sure what this trace has to do with USB at all, but I haven't
been able to reproduce the oops otherwise...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
