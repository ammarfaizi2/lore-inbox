Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFDKbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFDKbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 06:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFDKbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 06:31:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62699 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261215AbVFDKbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 06:31:12 -0400
Message-ID: <1117881061.42a182e535f40@imap.linux.ibm.com>
Date: Sat,  4 Jun 2005 06:31:01 -0400
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.63.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> On Fri, Jun 03, 2005 at 04:55:24PM +0530, Vivek Goyal wrote:
> > Hi,
> > 
> > In kdump, sometimes, general driver initialization issues seems to be
> cropping 
> > in second kernel due to devices not being shutdown during crash and these
> 
> > devices are sending interrupts while second kernel is booting and drivers
> are 
> > not expecting any interrupts yet.
> 
> What are the errors you are seeing?
> How would the drivers be able to be getting interrupts delivered to them
> if they haven't registered the irq handler yet?

Probably the boot log with error messages could have been inlined instead
of putting as attachement. This is from attachement in Vievk's post


irq 11: nobody cared (try booting with the "irqpoll" option. 
 [<c103a3ef>] __report_bad_irq+0x2a/0x8d 
 [<c1039c28>] handle_IRQ_event+0x39/0x6d 
 [<c103a4eb>] note_interrupt+0x7f/0xe4 
 [<c1039dc5>] __do_IRQ+0x169/0x194 
 [<c1004cc6>] do_IRQ+0x1b/0x28 
 [<c1003256>] common_interrupt+0x1a/0x20 
 [<c101d61b>] __do_softirq+0x2b/0x88 
 [<c101d69e>] do_softirq+0x26/0x2a 
 [<c101d759>] irq_exit+0x33/0x35 
 [<c1004ccb>] do_IRQ+0x20/0x28 
 [<c1003256>] common_interrupt+0x1a/0x20 
 [<c1018916>] release_console_sem+0x43/0xf6 
 [<c101875f>] vprintk+0x16c/0x277 
 [<c1074dd8>] d_lookup+0x23/0x46 
 [<c10748ac>] d_alloc+0x136/0x1a6 
 [<c10185ef>] printk+0x17/0x1b 
 [<c120f33f>] hub_probe+0xa0/0x168 
 [<c1096dd1>] sysfs_new_dirent+0x1f/0x64 
 [<c120d37f>] usb_probe_interface+0x59/0x71 
 [<c116c9b2>] driver_probe_device+0x2f/0xa7 
 [<c116ca2a>] __device_attach+0x0/0x5 
 [<c116c259>] bus_for_each_drv+0x58/0x78 
 [<c116ca8f>] device_attach+0x60/0x64 
 [<c116ca2a>] __device_attach+0x0/0x5 
 [<c116c383>] bus_add_device+0x29/0xa6 
 [<c116f9c7>] device_pm_add+0x56/0x9c 
 [<c116b7c3>] device_add+0xc5/0x14a 
 [<c121557e>] usb_set_configuration+0x346/0x528 
 [<c120fa47>] usb_new_device+0xab/0x1be 
 [<c120007b>] ohci_iso_recv_set_channel_mask+0x3/0xc6 
 [<c12124e1>] register_root_hub+0xaf/0x162 
 [<c12133bf>] usb_add_hcd+0x172/0x396 
 [<c1217bce>] usb_hcd_pci_probe+0x26e/0x375 
 [<c10284e7>] __call_usermodehelper+0x0/0x61 
 [<c110cbe4>] pci_device_probe_static+0x40/0x54 
 [<c110cc27>] __pci_device_probe+0x2f/0x42 
 [<c110cc63>] pci_device_probe+0x29/0x47 
 [<c116c9b2>] driver_probe_device+0x2f/0xa7 
 [<c116ca93>] __driver_attach+0x0/0x43 
 [<c116cad4>] __driver_attach+0x41/0x43 
 [<c116c1c2>] bus_for_each_dev+0x5a/0x7a 
 [<c116cafc>] driver_attach+0x26/0x2a 
 [<c116ca93>] __driver_attach+0x0/0x43 
 [<c116c5cb>] bus_add_driver+0x6b/0xa5 
 [<c110ce97>] pci_register_driver+0x5e/0x7c 
 [<c14246f5>] init+0x1d/0x25 
 [<c140c7ed>] do_initcalls+0x54/0xb6 
 [<c100029c>] init+0x0/0x10c 
 [<c100029c>] init+0x0/0x10c 
 [<c10002c6>] init+0x2a/0x10c 
 [<c1001348>] kernel_thread_helper+0x0/0xb 
 [<c100134d>] kernel_thread_helper+0x5/0xb 
handlers: 
[<c11e3421>] (ahd_linux_isr+0x0/0x284) 
Disabling IRQ #11 


Thanks
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center
IBM India Software Labs,
Bangalore, India
Ph. 91-80-25044990
email: maneesh@in.ibm.com
