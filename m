Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVB0Uca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVB0Uca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 15:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVB0Uca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 15:32:30 -0500
Received: from mail.suse.de ([195.135.220.2]:37575 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261224AbVB0UcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 15:32:19 -0500
Date: Sun, 27 Feb 2005 21:32:14 +0100
From: Olaf Hering <olh@suse.de>
To: linux-fbdev-devel@lists.sourceforge.net, linux-nvidia@lists.surfsouth.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5, rivafb i2c oops, bogus error handling
Message-ID: <20050227203214.GA15572@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Feb 23, Linus Torvalds wrote:

> This time it's really supposed to be a quickie, so people who can, please 
> check it out, and we'll make the real 2.6.11 asap.

Here is another one, probably not new.
Is riva_get_EDID_i2c a bit too optimistic by not having a $i2cadapter_ok
member in riva_par->riva_i2c_chan? It calls riva_probe_i2c_connector
even if riva_create_i2c_busses fails to register all 3 busses.


 
Feb 27 00:32:51 vdr kernel:     ACPI-0367: *** Warning: Unable to derive IRQ 
for device 0000:01:00.0 
Feb 27 00:32:51 vdr kernel: ACPI: PCI interrupt 0000:01:00.0[A]: no GSI - 
using IRQ 11 
Feb 27 00:32:51 vdr kernel: rivafb: nVidia device/chipset 10DE0029 
Feb 27 00:32:51 vdr kernel: rivafb: RIVA MTRR set to ON 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (0) scl=60, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (1) scl=53, sda=0 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (2) scl=63, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (3) scl=59, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: SCL stuck high! 
Feb 27 00:32:51 vdr kernel: rivafb 0000:01:00.0: Failed to register I2C bus 
BUS1. 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (0) scl=30, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (1) scl=23, sda=0 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (2) scl=31, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (3) scl=59, sda=1 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: SCL stuck high! 
Feb 27 00:32:51 vdr kernel: rivafb 0000:01:00.0: Failed to register I2C bus 
BUS2. 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: (0) scl=0, sda=0 
Feb 27 00:32:51 vdr kernel: i2c-algo-bit.o: BUS3 seems to be busy. 
Feb 27 00:32:51 vdr kernel: rivafb 0000:01:00.0: Failed to register I2C bus 
BUS3. 
Feb 27 00:32:51 vdr kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000024 
Feb 27 00:32:51 vdr kernel:  printing eip: 
Feb 27 00:32:51 vdr kernel: d09bcafc 
Feb 27 00:32:51 vdr kernel: *pde = 00000000 
Feb 27 00:32:51 vdr kernel: Oops: 0000 [#1] 
Feb 27 00:32:51 vdr kernel: Modules linked in: usbhid evdev joydev sg st 
sd_mod sr_mod scsi_mod rivafb i2c_algo_bit vgastate dvb_ttpci dvb_core 
saa7146_vv video_buf saa7146 v4l1_compat v4l2_common v 
ideodev ves1820 stv0299 tda8083 stv0297 8139too mii sp8870 firmware_class 
ves1x93 i2c_piix4 ttpci_eeprom i2c_core intel_agp uhci_hcd pci_hotplug agpgart 
usbcore subfs dm_mod ide_cd cdrom ide_floppy  
ide_disk reiserfs piix ide_core 
Feb 27 00:32:51 vdr kernel: CPU:    0 
Feb 27 00:32:51 vdr kernel: EIP:    0060:[<d09bcafc>]    Not tainted VLI 
Feb 27 00:32:51 vdr kernel: EFLAGS: 00010286   (2.6.11-rc4-bk9-27-default)  
Feb 27 00:32:51 vdr kernel: EIP is at i2c_transfer+0xc/0x40 [i2c_core] 
Feb 27 00:32:51 vdr kernel: eax: 00000000   ebx: ffffffda   ecx: 00000002   
edx: cd6f3e18 
Feb 27 00:32:51 vdr kernel: esi: cfa35624   edi: cfe40160   ebp: 00000003   
esp: cd6f3e04 
Feb 27 00:32:51 vdr kernel: ds: 007b   es: 007b   ss: 0068 
Feb 27 00:32:51 vdr kernel: Process modprobe (pid: 2613, threadinfo=cd6f2000 
task=cddfd080) 
Feb 27 00:32:51 vdr kernel: Stack: cd6f3e18 cfa3561c d0a1ce3f 00000246 
003b5219 00000050 00000001 cd6f3e17  
Feb 27 00:32:51 vdr kernel:        00010050 00000080 cfe40160 d0a1de98 
cd6f3e40 00000000 000001e4 cfa35290  
Feb 27 00:32:51 vdr kernel:        cfa355f4 d0a1cec7 cfa35290 00000001 
00000000 cfa355f4 d0a17de8 00000001  
Feb 27 00:32:51 vdr kernel: Call Trace: 
Feb 27 00:32:51 vdr kernel:  [<d0a1ce3f>] riva_do_probe_i2c_edid+0x7f/0xe0 
[rivafb] 
Feb 27 00:32:51 vdr kernel:  [<d0a1cec7>] riva_probe_i2c_connector+0x27/0xa0 
[rivafb] 
Feb 27 00:32:51 vdr kernel:  [<d0a17de8>] riva_get_EDID_i2c+0x48/0x90 [rivafb] 
Feb 27 00:32:51 vdr kernel:  [<c010528d>] do_IRQ+0x3d/0x60 
Feb 27 00:32:51 vdr kernel:  [<c0103cba>] common_interrupt+0x1a/0x20 
Feb 27 00:32:51 vdr kernel:  [<c0228288>] poke_blanked_console+0x68/0xb0 
Feb 27 00:32:51 vdr kernel:  [<c02274c5>] vt_console_print+0x295/0x340 
Feb 27 00:32:51 vdr kernel:  [<c0227230>] vt_console_print+0x0/0x340 
Feb 27 00:32:51 vdr kernel:  [<c0119f51>] __call_console_drivers+0x41/0x50 
Feb 27 00:32:51 vdr kernel:  [<c011a028>] call_console_drivers+0x78/0x110 
Feb 27 00:32:51 vdr kernel:  [<c011a29b>] vprintk+0xeb/0x100 
Feb 27 00:32:51 vdr kernel:  [<d0a17ec5>] riva_get_EDID+0x5/0x20 [rivafb] 
Feb 27 00:32:51 vdr kernel:  [<d0a182eb>] rivafb_probe+0x2db/0x510 [rivafb] 
Feb 27 00:32:51 vdr kernel:  [<c01dab82>] pci_device_probe_static+0x32/0x50 
Feb 27 00:32:51 vdr kernel:  [<c01dabc7>] __pci_device_probe+0x27/0x40 
Feb 27 00:32:51 vdr kernel:  [<c01dabfb>] pci_device_probe+0x1b/0x40 
Feb 27 00:32:51 vdr kernel:  [<c0234531>] driver_probe_device+0x21/0x60 
Feb 27 00:32:51 vdr kernel:  [<c023465d>] driver_attach+0x4d/0x80 
Feb 27 00:32:51 vdr kernel:  [<c0234a4d>] bus_add_driver+0x6d/0xa0 
Feb 27 00:32:51 vdr kernel:  [<c0234f48>] driver_register+0x28/0x30 
Feb 27 00:32:51 vdr kernel:  [<c01dadc4>] pci_register_driver+0x54/0x70 
Feb 27 00:32:51 vdr kernel:  [<c012e774>] sys_init_module+0x104/0x180 
Feb 27 00:32:51 vdr kernel:  [<c0102c49>] sysenter_past_esp+0x52/0x79 
Feb 27 00:32:51 vdr kernel: Code: 31 db 8b 50 70 85 d2 74 07 8b 4a 68 85 c9 75 
04 89 d8 5b c3 31 d2 ff d1 89 c3 89 d8 5b c3 90 56 53 89 c6 8b 40 0c bb da ff 
ff ff <8b> 40 24 85 c0 74 1e ff 4e 1c 0f  
88 59 13 00 00 8b 5e 0c 89 f0  
