Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbREZXAH>; Sat, 26 May 2001 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbREZW7K>; Sat, 26 May 2001 18:59:10 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262081AbREZW67>;
	Sat, 26 May 2001 18:58:59 -0400
Date: Sat, 26 May 2001 18:05:29 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: new aic7xxx oopses with AHA2940
Message-ID: <20010526180529.A7595@lisa.links2linux.home>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,

I have problems with the new aic7xxx-Driver. These problems exist
with vanilla (2.4.4, 2.5.5, other d.k.) and -ac

When I built it into the Kernel, it will panic on boot when it tries
to access the adapter.

Built as modules it segfaults when i try to insmod (modprobe) it, 
following this Oops in messages:


May 26 17:52:33 homer kernel: PCI: Found IRQ 9 for device 00:0d.0
May 26 17:52:33 homer kernel: PCI: The same IRQ used for device 00:04.2
May 26 17:52:33 homer kernel: PCI: The same IRQ used for device 00:04.3
May 26 17:52:33 homer kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 26 17:52:33 homer kernel:  printing eip:
May 26 17:52:33 homer kernel: e0a7b3a7
May 26 17:52:33 homer kernel: *pde = 00000000
May 26 17:52:33 homer kernel: Oops: 0000
May 26 17:52:33 homer kernel: CPU:    0
May 26 17:52:33 homer kernel: EIP:    0010:[usbcore:usb_devfs_handle_Re9c5f87f+161255/198895517]
May 26 17:52:33 homer kernel: EFLAGS: 00010096
May 26 17:52:33 homer kernel: eax: 00000041   ebx: 00000000   ecx: dd5d6e00   edx: 00000000
May 26 17:52:33 homer kernel: esi: 00000000   edi: 000000ff   ebp: dd5d6e00   esp: dd165cbc
May 26 17:52:33 homer kernel: ds: 0018   es: 0018   ss: 0018
May 26 17:52:33 homer kernel: Process modprobe (pid: 766, stackpage=dd165000)
May 26 17:52:33 homer kernel: Stack: 00000000 00000000 000000ff dd5d6e00 41000357 e0a7b79d dd5d6e00 00000000 
May 26 17:52:33 homer kernel:        ffffffff 00000041 ffffffff 000000ff 00000000 00000041 00000000 dd5d6e00 
May 26 17:52:33 homer kernel:        dd5d6e00 00000001 00000001 00000001 00000001 00000001 00000000 00000001 
May 26 17:52:33 homer kernel: Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+162269/198894503] [usbcore:usb_devfs_handle_Re9c5f87f+164966/198891806] [__delay+19/48] [usbcore:usb_devfs_handle_Re9c5f87f+166493/198890279] [usbcore:usb_devfs_handle_Re9c5f87f+117712/198939060] [usbcore:usb_devfs_handle_Re9c5f87f+185577/198871195] [usbcore:usb_devfs_handle_Re9c5f87f+171751/198885021] 
May 26 17:52:33 homer kernel:        [rpc_new_task+240/368] [usbcore:usb_devfs_handle_Re9c5f87f+113534/198943238] [usbcore:usb_devfs_handle_Re9c5f87f+150165/198906607] [usbcore:usb_devfs_handle_Re9c5f87f+113361/198943411] [usbcore:usb_devfs_handle_Re9c5f87f+113392/198943380] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [pci_announce_device+28/80] [usbcore:usb_devfs_handle_Re9c5f87f+202048/198854724] 
May 26 17:52:33 homer kernel:        [usbcore:usb_devfs_handle_Re9c5f87f+202144/198854628] [pci_register_driver+68/96] [usbcore:usb_devfs_handle_Re9c5f87f+202144/198854628] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [usbcore:usb_devfs_handle_Re9c5f87f+125626/198931146] [usbcore:usb_devfs_handle_Re9c5f87f+113038/198943734] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [usbcore:usb_devfs_handle_Re9c5f87f+111272/198945500] 
May 26 17:52:33 homer kernel:        [scsi_register_host+73/720] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [usbcore:usb_devfs_handle_Re9c5f87f+111272/198945500] [usbcore:usb_devfs_handle_Re9c5f87f+111168/198945604] [usbcore:usb_devfs_handle_Re9c5f87f+111272/198945500] [scsi_register_module+45/96] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] 
May 26 17:52:33 homer kernel:        [usbcore:usb_devfs_handle_Re9c5f87f+111168/198945604] [usbcore:usb_devfs_handle_Re9c5f87f+125206/198931566] [usbcore:usb_devfs_handle_Re9c5f87f+201920/198854852] [sys_init_module+1277/1440] [eepro100:__insmod_eepro100_O/lib/modules/2.4.5/kernel/drivers/net/ee+0/96] [usbcore:usb_devfs_handle_Re9c5f87f+111264/198945508] [system_call+51/56] 
May 26 17:52:33 homer kernel: 
May 26 17:52:33 homer kernel: Code: 8b 02 8b 7c 24 20 8b 6c 24 28 0f b6 40 19 f6 81 f0 00 00 00 

Does it crash with the USB-Driver?? But USB works fine... even after
the Oops

BTW: The old aic7xxx-Driver works fine for me

Devices connected to the adapter:
 - teac CDR
 - old plextor cdrom
 - ibm 4G HD

System is an AMD Thunderbird 800, 512MB, ASUS A7V

Do you need any further information?

Cheers
-Marc
-- 
|                                                                  |
|                                                                  |
| http://www.links2linux.de <-- Von Linux-Usern fuer Linux-User    |

