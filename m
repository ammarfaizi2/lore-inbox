Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbUKXXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbUKXXDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUKXXBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:01:30 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:11726 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262900AbUKXWwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:52:01 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041124221754.GA31512@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu>
	 <1101324238.29045.62.camel@cmn37.stanford.edu>
	 <20041124221754.GA31512@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1101333369.29045.233.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Nov 2004 13:56:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 14:17, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Using PREEMPT_DESKTOP I see a irq related problem with my network
> > interface:

(I don't think this is only with PREEMPT_DESKTOP, on a previous kernel
_RT was giving the same error)

> > IRQ#11 thread RT prio: 38.
> > irq 16: nobody cared!
> >  [<c0104173>] dump_stack+0x23/0x30 (20)
> >  [<c0147970>] __report_bad_irq+0x30/0xa0 (24)
> >  [<c0147a80>] note_interrupt+0x70/0xb0 (32)
> >  [<c01477dc>] do_hardirq+0x13c/0x150 (40)
> >  [<c0147889>] do_irqd+0x99/0xd0 (32)
> >  [<c0139fda>] kthread+0xaa/0xb0 (48)
> >  [<c0101335>] kernel_thread_helper+0x5/0x10 (153083924)
> 
> does it otherwise get detected and does it work fine afterwards?

Anything network related activity hangs (for example, trying to ping).
Otherwise the machine seems to work. 

Same kernel on my laptop loads the network driver with no problems
(different driver, e100), but has problems with the usb uhci-hcd driver.
This is when the driver is loaded:

USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma
inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma
  Vendor: Sony      Model: MSC-U03           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma

Also, after the driver is loaded I get a "subdevfs not supported in
kernel" message when I try to:
  mount -t usbdevfs usbdevfs /proc/bus/usb
But I do have (I think) the right kernel options for this to work...

And this is when I try to remove it:

uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
rmmod/3999: BUG in do_drain at mm/slab.c:1522
 [<c0104173>] dump_stack+0x23/0x30 (20)
 [<c0151fc9>] do_drain+0xb9/0xc0 (44)
 [<c0151ece>] smp_call_function_all_cpus+0x2e/0x70 (28)
 [<c0151ff1>] drain_cpu_caches+0x21/0x90 (24)
 [<c0152079>] __cache_shrink+0x19/0x160 (36)
 [<c01522cf>] kmem_cache_destroy+0xaf/0x1c0 (28)
 [<e094657b>] scsi_destroy_command_freelist+0x6b/0xa0 [scsi_mod] (28)
 [<e0947917>] scsi_host_dev_release+0x37/0xa0 [scsi_mod] (36)
 [<c0271725>] device_release+0x85/0x90 (32)
 [<c01ef505>] kobject_cleanup+0x95/0xa0 (28)
 [<c01f00f5>] kref_put+0x45/0x100 (40)
 [<c01ef556>] kobject_put+0x26/0x30 (16)
 [<e0adfd18>] usb_stor_release_resources+0x78/0x150 [usb_storage] (24)
 [<e0ae0294>] storage_disconnect+0xa4/0xb1 [usb_storage] (20)
 [<c02ba207>] usb_unbind_interface+0x87/0x90 (28)
 [<c0272e46>] device_release_driver+0x86/0x90 (28)
 [<c0273109>] bus_remove_device+0x89/0xd0 (28)
 [<c0271c14>] device_del+0x74/0xb0 (28)
 [<c02c1fd8>] usb_disable_device+0xb8/0x100 (28)
 [<c02bcb76>] usb_disconnect+0xc6/0x1a0 (40)
 [<c02bcc18>] usb_disconnect+0x168/0x1a0 (40)
 [<c02c50d5>] usb_hcd_pci_remove+0x85/0x1c0 (36)
 [<c01fbec6>] pci_device_remove+0x46/0x50 (16)
 [<c0272e46>] device_release_driver+0x86/0x90 (28)
 [<c0272e7b>] driver_detach+0x2b/0x40 (20)
 [<c02733c1>] bus_remove_driver+0x71/0xc0 (28)
 [<c02739e9>] driver_unregister+0x19/0x30 (16)
 [<c01fc15c>] pci_unregister_driver+0x1c/0x30 (16)
 [<e0ac2147>] uhci_hcd_cleanup+0x17/0x68 [uhci_hcd] (16)
 [<c013eec6>] sys_delete_module+0x146/0x190 (96)
 [<c01032a1>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0151ec3>] .... smp_call_function_all_cpus+0x23/0x70
.....[<c0151ff1>] ..   ( <= drain_cpu_caches+0x21/0x90)
.. [<c013c98d>] .... print_traces+0x1d/0x60
.....[<c0104173>] ..   ( <= dump_stack+0x23/0x30)

inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma
inserting floppy driver for 2.6.9-1.520.1rV0.7.30_9.ll.rhfc2.ccrma
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
rmmod/3999: BUG in do_drain at mm/slab.c:1522
 [<c0104173>] dump_stack+0x23/0x30 (20)
 [<c0151fc9>] do_drain+0xb9/0xc0 (44)
 [<c0151ece>] smp_call_function_all_cpus+0x2e/0x70 (28)
 [<c0151ff1>] drain_cpu_caches+0x21/0x90 (24)
 [<c0152079>] __cache_shrink+0x19/0x160 (36)
 [<c01522cf>] kmem_cache_destroy+0xaf/0x1c0 (28)
 [<e0ac2154>] uhci_hcd_cleanup+0x24/0x68 [uhci_hcd] (16)
 [<c013eec6>] sys_delete_module+0x146/0x190 (96)
 [<c01032a1>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0151ec3>] .... smp_call_function_all_cpus+0x23/0x70
.....[<c0151ff1>] ..   ( <= drain_cpu_caches+0x21/0x90)
.. [<c013c98d>] .... print_traces+0x1d/0x60
.....[<c0104173>] ..   ( <= dump_stack+0x23/0x30)

-- Fernando


