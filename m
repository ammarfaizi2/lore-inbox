Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTIOTmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbTIOTmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:42:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:14987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbTIOTmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:42:51 -0400
Date: Mon, 15 Sep 2003 12:24:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: grendel@caudium.net
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@intel.com
Subject: Re: 2.6.0-test5-mm2
Message-Id: <20030915122412.02d3c5eb.akpm@osdl.org>
In-Reply-To: <20030915192629.GA4472@thanes.org>
References: <20030914234843.20cea5b3.akpm@osdl.org>
	<20030915192629.GA4472@thanes.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Habersack <grendel@caudium.net> wrote:
>
> Hello,
> 
>  There's a problem with both 2.6.0-test5-{mm1,mm2} on my MaxData M1000T
> notebook. Details are in the attached dmesg output - in a word, via-rhine
> times out on the transfer rendering the network inaccessible:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 1003, PHY status 786d, resetting...
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
> 
> and USB HCD reports an unhandled IRQ and throws a call trace:
> 
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
> v2.1
> uhci-hcd 0000:00:11.2: UHCI Host Controller
> irq 9: nobody cared!
> Call Trace:
>  [<c010c71a>] __report_bad_irq+0x2a/0x90
>  [<c010c810>] note_interrupt+0x70/0xa0
>  [<c010caa0>] do_IRQ+0x120/0x130
>  [<c0432800>] common_interrupt+0x18/0x20
>  [<c0121f00>] do_softirq+0x40/0xa0
>  [<c010ca7c>] do_IRQ+0xfc/0x130
>  [<c0432800>] common_interrupt+0x18/0x20
>  [<c0267b91>] pci_bus_write_config_word+0x61/0x90
>  [<c03326cf>] uhci_reset+0x3f/0x60
>  [<c0324ff5>] usb_hcd_pci_probe+0x195/0x4a0
>  [<c026b952>] pci_device_probe_static+0x52/0x70
>  [<c026b9ab>] __pci_device_probe+0x3b/0x50
>  [<c026b9ec>] pci_device_probe+0x2c/0x50
>  [<c02afc2f>] bus_match+0x3f/0x70
>  [<c02afd7f>] driver_attach+0x6f/0xa0
>  [<c02b001d>] bus_add_driver+0x8d/0xa0
>  [<c02b045f>] driver_register+0x2f/0x40
>  [<c026bbdf>] pci_register_driver+0x5f/0x90
>  [<c0545684>] uhci_hcd_init+0xc4/0x140
>  [<c053270b>] do_initcalls+0x2b/0xa0
>  [<c012db3f>] init_workqueues+0xf/0x50
>  [<c01070cd>] init+0x2d/0x160
>  [<c01070a0>] init+0x0/0x160
>  [<c0109089>] kernel_thread_helper+0x5/0xc
> 
> handlers:
> [<c026eefb>] (acpi_irq+0x0/0x16)
> Disabling IRQ #9
> 
> Vanilla test5 works fine.
> 

Looks like ACPI broke.  Here is the procedure for reporting
ACPI problems:


Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.  Send to linux-acpi@intel.com
