Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVGGAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVGGAXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGFUDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:03:17 -0400
Received: from animx.eu.org ([216.98.75.249]:29389 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262126AbVGFReA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:34:00 -0400
Date: Wed, 6 Jul 2005 13:51:27 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: USB OOPS 2.6.12
Message-ID: <20050706175127.GA11912@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I plugged in a USB 2.0 external hard disk (ION) and the usb controller
apparently could not power the device (wouldn't spin up, the device itself
works on other machines).  I unplug the drive and I received an OOPS.

DMESG:
usb 4-5: new high speed USB device using ehci_hcd and address 6
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
scsi: Device offlined - not ready after error recovery: host 5 channel 0 id 0 lun 0
usb 4-5: USB disconnect, address 6
usb-storage: device scan complete
Unable to handle kernel NULL pointer dereference at virtual address 00000050
 printing eip:
c018cdef
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: nls_utf8 hfsplus nls_base mga drm nfsd exportfs tun ipv6 nfs lockd sunrpc parport_pc parport 8250_pnp sg sr_mod cdrom snd_ens1370 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ak4531_codec snd soundcore usb_storage ehci_hcd tsdev ohci_hcd usbhid i2c_piix4 i2c_core uhci_hcd usbcore piix ide_core intel_agp agpgart typhoon crc32 bridge reiserfs dm_mod 8250 serial_core
CPU:    0
EIP:    0060:[<c018cdef>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12) 
eax: 00000000   ebx: c02c2603   ecx: 0000001f   edx: 00000000
esi: cbe1264c   edi: c02fe7b0   ebp: c02fe740   esp: de84ade0
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1057, threadinfo=de84a000 task=dfdf4590)
Stack: 00000202 00000202 cbe12400 cbe12654 cbe1264c c02fe7b0 c02fe740 c0206808 
       00000000 c02c2603 cbe1264c cbe12598 d0b22800 db0f00e0 c0206833 cbe1264c 
       cbe12400 c02217f8 cbe1264c 00000003 cbe12400 d0b22800 d0b227f8 c02218fb 
Call Trace:
 [<c0206808>]
 [<c0206833>]
 [<c02217f8>]
 [<c02218fb>]
 [<c02207e5>]
 [<c0219339>]
 [<e0c7aba3>]
 [<e0c19136>]
 [<c0205208>]
 [<c02054bb>]
 [<c0204269>]
 [<e0c20a50>]
 [<e0c1b6e6>]
 [<e0c1cb9f>]
 [<e0c1bac9>]
 [<e0c1ce68>]
 [<e0c1cfd5>]
 [<c0131520>]
 [<c0103272>]
 [<c0131520>]
 [<e0c1cfa0>]
 [<c010148d>]
Code: 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 57 56 53 83 ec 0c 8b 44 24 20 8b 5c 24 24 <8b> 48 50 8b 50 10 f0 ff 4a 78 0f 88 e3 00 00 00 8b 51 0c 8d 6a 

I guess I don't have symbols turned on, so here's the same thing from syslog:
Jul  6 13:47:01 ani kernel: usb 4-5: new high speed USB device using ehci_hcd and address 6
Jul  6 13:47:01 ani kernel: scsi5 : SCSI emulation for USB Mass Storage devices
Jul  6 13:47:01 ani kernel: usb-storage: device found at 6
Jul  6 13:47:01 ani kernel: usb-storage: waiting for device to settle before scanning
Jul  6 13:47:30 ani kernel: scsi: Device offlined - not ready after error recovery: host 5 channel 0 id 0 lun 0
Jul  6 13:47:30 ani kernel: usb 4-5: USB disconnect, address 6
Jul  6 13:47:30 ani kernel: usb-storage: device scan complete
Jul  6 13:47:30 ani kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000050
Jul  6 13:47:30 ani kernel:  printing eip:
Jul  6 13:47:30 ani kernel: c018cdef
Jul  6 13:47:30 ani kernel: *pde = 00000000
Jul  6 13:47:30 ani kernel: Oops: 0000 [#1]
Jul  6 13:47:30 ani kernel: PREEMPT SMP 
Jul  6 13:47:30 ani kernel: Modules linked in: nls_utf8 hfsplus nls_base mga drm nfsd exportfs tun ipv6 nfs lockd sunrpc parport_pc parport 8250_pnp sg sr_mod cdrom snd_ens1370 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ak4531_codec snd soundcore usb_storage ehci_hcd tsdev ohci_hcd usbhid i2c_piix4 i2c_core uhci_hcd usbcore piix ide_core intel_agp agpgart typhoon crc32 bridge reiserfs dm_mod 8250 serial_core
Jul  6 13:47:30 ani kernel: CPU:    0
Jul  6 13:47:30 ani kernel: EIP:    0060:[sysfs_hash_and_remove+15/258]    Not tainted VLI
Jul  6 13:47:30 ani kernel: EFLAGS: 00010282   (2.6.12) 
Jul  6 13:47:30 ani kernel: eax: 00000000   ebx: c02c2603   ecx: 0000001f   edx: 00000000
Jul  6 13:47:30 ani kernel: esi: cbe1264c   edi: c02fe7b0   ebp: c02fe740   esp: de84ade0
Jul  6 13:47:30 ani kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 13:47:30 ani kernel: Process khubd (pid: 1057, threadinfo=de84a000 task=dfdf4590)
Jul  6 13:47:30 ani kernel: Stack: 00000202 00000202 cbe12400 cbe12654 cbe1264c c02fe7b0 c02fe740 c0206808 
Jul  6 13:47:30 ani kernel:        00000000 c02c2603 cbe1264c cbe12598 d0b22800 db0f00e0 c0206833 cbe1264c 
Jul  6 13:47:30 ani kernel:        cbe12400 c02217f8 cbe1264c 00000003 cbe12400 d0b22800 d0b227f8 c02218fb 
Jul  6 13:47:30 ani kernel: Call Trace:
Jul  6 13:47:30 ani kernel:  [class_device_del+184/208]
Jul  6 13:47:30 ani kernel:  [class_device_unregister+19/48]
Jul  6 13:47:30 ani kernel:  [scsi_remove_device+72/176]
Jul  6 13:47:30 ani kernel:  [__scsi_remove_target+155/192]
Jul  6 13:47:30 ani kernel:  [scsi_forget_host+69/112]
Jul  6 13:47:30 ani kernel:  [scsi_remove_host+25/128]
Jul  6 13:47:30 ani kernel:  [pg0+546339747/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545939766/1070117888]
Jul  6 13:47:30 ani kernel:  [device_release_driver+120/128]
Jul  6 13:47:30 ani kernel:  [bus_remove_device+123/192]
Jul  6 13:47:30 ani kernel:  [device_del+89/160]
Jul  6 13:47:30 ani kernel:  [pg0+545970768/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545949414/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545954719/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545950409/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545955432/1070117888]
Jul  6 13:47:30 ani kernel:  [pg0+545955797/1070117888]
Jul  6 13:47:30 ani kernel:  [autoremove_wake_function+0/96]
Jul  6 13:47:30 ani kernel:  [ret_from_fork+6/20]
Jul  6 13:47:30 ani kernel:  [autoremove_wake_function+0/96]
Jul  6 13:47:30 ani kernel:  [pg0+545955744/1070117888]
Jul  6 13:47:30 ani kernel:  [kernel_thread_helper+5/24]
Jul  6 13:47:30 ani kernel: Code: 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 57 56 53 83 ec 0c 8b 44 24 20 8b 5c 24 24 <8b> 48 50 8b 50 10 f0 ff 4a 78 0f 88 e3 00 00 00 8b 51 0c 8d 6a 

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
