Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUJXNRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUJXNRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUJXNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:17:30 -0400
Received: from samba.ing.unimo.it ([155.185.54.131]:49853 "EHLO
	weblab.ing.unimo.it") by vger.kernel.org with ESMTP id S261466AbUJXNNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:13:16 -0400
Message-ID: <32810.155.185.54.160.1098623594.squirrel@155.185.54.160>
Date: Sun, 24 Oct 2004 15:13:14 +0200 (CEST)
Subject: 2.6.9 suspend-to-disk bug (during resume)
From: andreoli@weblab.ing.unimo.it
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I just installed 2.6.9 (gentoo patchset, but I think the swsusp code is
not touched, tell me if I'm wrong). After giving an

echo disk > /sys/power/state

my laptop seems to suspend fine, but on resume I get the following oops:

subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<c01cd4e6>] pci_set_power_state+0xc6/0x160
 [<ec9e5a50>] usb_hcd_pci_resume+0x130/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<eca243f6>] ohci_hub_resume+0x196/0x360 [ohci_hcd]
 [<ec9e0f60>] hcd_hub_resume+0x20/0x30 [usbcore]
 [<ec9ddfae>] usb_resume_device+0x9e/0xd0 [usbcore]
 [<eca2719d>] ohci_pci_resume+0x2d/0x6b [ohci_hcd]
 [<ec9e59f0>] usb_hcd_pci_resume+0xd0/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<eca24428>] ohci_hub_resume+0x1c8/0x360 [ohci_hcd]
 [<ec9e0f60>] hcd_hub_resume+0x20/0x30 [usbcore]
 [<ec9ddfae>] usb_resume_device+0x9e/0xd0 [usbcore]
 [<eca2719d>] ohci_pci_resume+0x2d/0x6b [ohci_hcd]
 [<ec9e59f0>] usb_hcd_pci_resume+0xd0/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946ed>] schedule_timeout+0x6d/0xc0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c01257ef>] msleep+0x2f/0x40
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<ec9ddf90>] usb_resume_device+0x80/0xd0 [usbcore]
 [<eca2719d>] ohci_pci_resume+0x2d/0x6b [ohci_hcd]
 [<ec9e59f0>] usb_hcd_pci_resume+0xd0/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<c01cd4e6>] pci_set_power_state+0xc6/0x160
 [<ec9e5a50>] usb_hcd_pci_resume+0x130/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c023769d>] pci_bios_read+0xad/0xf0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<ec9fe3e6>] ehci_hub_resume+0xd6/0x170 [ehci_hcd]
 [<ec9e0f60>] hcd_hub_resume+0x20/0x30 [usbcore]
 [<ec9ddfae>] usb_resume_device+0x9e/0xd0 [usbcore]
 [<eca0268a>] ehci_resume+0x2a/0x70 [ehci_hcd]
 [<ec9e59f0>] usb_hcd_pci_resume+0xd0/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<ec9ddf90>] usb_resume_device+0x80/0xd0 [usbcore]
 [<eca0268a>] ehci_resume+0x2a/0x70 [ehci_hcd]
 [<ec9e59f0>] usb_hcd_pci_resume+0xd0/0x160 [usbcore]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<c01cd4e6>] pci_set_power_state+0xc6/0x160
 [<ec93e682>] sis900_resume+0x62/0x120 [sis900]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<c01cd4e6>] pci_set_power_state+0xc6/0x160
 [<eca338cd>] yenta_dev_resume+0x2d/0xc0 [yenta_socket]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02377b8>] pci_bios_write+0xd8/0xe0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<eca3fa80>] socket_remove_drivers+0x20/0x40 [pcmcia_core]
 [<c01257ef>] msleep+0x2f/0x40
 [<eca3fac9>] socket_shutdown+0x29/0x40 [pcmcia_core]
 [<eca3ff6c>] socket_resume+0xbc/0x110 [pcmcia_core]
 [<eca3f446>] pcmcia_socket_dev_resume+0x96/0xb0 [pcmcia_core]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<c01cd4e6>] pci_set_power_state+0xc6/0x160
 [<eca338cd>] yenta_dev_resume+0x2d/0xc0 [yenta_socket]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02377b8>] pci_bios_write+0xd8/0xe0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<eca3fa80>] socket_remove_drivers+0x20/0x40 [pcmcia_core]
 [<c01257ef>] msleep+0x2f/0x40
 [<eca3fac9>] socket_shutdown+0x29/0x40 [pcmcia_core]
 [<eca3ff6c>] socket_resume+0xbc/0x110 [pcmcia_core]
 [<eca3f446>] pcmcia_socket_dev_resume+0x96/0xb0 [pcmcia_core]
 [<c01cf2bc>] pci_device_resume+0x2c/0x30
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
ACPI: PCI interrupt 0000:00:0a.2[C] -> GSI 11 (level, low) -> IRQ 11
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c022d6ef>] do_rw_taskfile+0x15f/0x260
 [<c022d960>] task_no_data_intr+0x0/0xa0
 [<c0294328>] wait_for_completion+0x78/0xd0
 [<c0118f60>] default_wake_function+0x0/0x20
 [<c0118f60>] default_wake_function+0x0/0x20
 [<c0216795>] __elv_add_request+0x45/0xa0
 [<c0229476>] ide_do_drive_cmd+0xf6/0x140
 [<c011d4bd>] profile_hook+0x2d/0x50
 [<c0226853>] generic_ide_resume+0x93/0xc0
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
hub 1-0:1.0: reactivate --> -22
hub 2-0:1.0: reactivate --> -22
hub 3-0:1.0: reactivate --> -22
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c02946e3>] schedule_timeout+0x63/0xc0
 [<c0125410>] process_timeout+0x0/0x10
 [<c01257ef>] msleep+0x2f/0x40
 [<ec9ddf90>] usb_resume_device+0x80/0xd0 [usbcore]
 [<c0216227>] resume_device+0x27/0x30
 [<c0216292>] dpm_resume+0x62/0x70
 [<c02162b9>] device_resume+0x19/0x30
 [<c0136cc8>] finish+0x8/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
hub 4-0:1.0: reactivate --> -22
hub 4-0:1.0: reactivate --> -22
Restarting tasks...<3>bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c01186ce>] wake_up_process+0x1e/0x20
 [<c01356c5>] thaw_processes+0xa5/0xe0
 [<c0136cd6>] finish+0x16/0x40
 [<c0136e2e>] pm_suspend_disk+0x7e/0xc0
 [<c0135271>] enter_state+0xa1/0xb0
 [<c013c19a>] __alloc_pages+0x1ca/0x360
 [<c01353b0>] state_store+0xa0/0xa8
 [<c0187fda>] subsys_attr_store+0x3a/0x40
 [<c018824b>] flush_write_buffer+0x3b/0x50
 [<c01882ba>] sysfs_write_file+0x5a/0x70
 [<c01554ac>] vfs_write+0xbc/0x170
 [<c0155631>] sys_write+0x51/0x80
 [<c01061c9>] sysenter_past_esp+0x52/0x71
 done
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c0155631>] sys_write+0x51/0x80
 [<c0106242>] work_resched+0x5/0x16
bad: scheduling while atomic!
 [<c029424f>] schedule+0x4cf/0x4e0
 [<c0110036>] mtrr_write+0x2e6/0x300
 [<c01199b3>] sys_sched_yield+0x53/0x70
 [<c01614d8>] coredump_wait+0x38/0xa0
 [<c016160b>] do_coredump+0xcb/0x20f
 [<c01186ea>] wake_up_state+0x1a/0x20
 [<c0126362>] signal_wake_up+0x22/0x30
 [<c01268da>] specific_send_sig_info+0xca/0xe0
 [<c012590f>] free_uid+0x1f/0x80
 [<c01261f5>] __dequeue_signal+0xe5/0x1a0
 [<c01262e5>] dequeue_signal+0x35/0x90
 [<c0128015>] get_signal_to_deliver+0x205/0x330
 [<c0105fbd>] do_signal+0x9d/0x130
 [<c0106242>] work_resched+0x5/0x16
 [<c0106f26>] print_context_stack+0x26/0x70
 [<c0106242>] work_resched+0x5/0x16
 [<c0106fbe>] show_trace+0x4e/0x90
 [<c011842f>] recalc_task_prio+0x8f/0x190
 [<c0294043>] schedule+0x2c3/0x4e0
 [<c0117270>] do_page_fault+0x0/0x599
 [<c0106087>] do_notify_resume+0x37/0x3c
 [<c0106266>] work_notifysig+0x13/0x15
note: bash[14272] exited with preempt_count 1
eth0: Abnormal interrupt,status 0x03008001.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000000
eth0: Media Link On 100mbps full-duplex

after which my bash gets killed. It seems to be usb related, but on resume
I have all of my devices working again (included network and usb, which
wasn't happening before).
I tested this on an ASUS L8400, sis chipsets.
If you need any other info, I'll post them.
Please CC me since I'm not subscribed to the list.

Mauro Andreolini
