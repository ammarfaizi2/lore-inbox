Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTHCXVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 19:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271327AbTHCXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 19:21:12 -0400
Received: from d40.sstar.com ([209.205.179.40]:29436 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S271324AbTHCXVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 19:21:07 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
Date: Sun, 3 Aug 2003 18:21:34 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.6.0-test2 with USB flash reader
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308031821.34673.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Imation FlashGO! 2.0 USB 7-in-1 flash reader that
works a few times, then things go bad.  I can mount, read from,
write to, and unmount a CF card a few times, but eventually it
quits working.

Here are the modules loaded:

Module                  Size  Used by
sg                     32716  0
snd_mixer_oss          19072  1
snd_emu10k1            93828  1
snd_rawmidi            24960  1 snd_emu10k1
snd_pcm                97472  1 snd_emu10k1
snd_timer              25728  1 snd_pcm
snd_seq_device          8068  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         49924  1 snd_emu10k1
snd_page_alloc         10436  2 snd_emu10k1,snd_pcm
snd_util_mem            4416  1 snd_emu10k1
snd_hwdep               8768  1 snd_emu10k1
snd                    50820  9 snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep
radeon                119704  30
via_agp                 7168  1
agpgart                31336  2 via_agp
sd_mod                 13664  2
usb_storage            26624  1
mousedev                8660  1
hid                    32768  0
uhci_hcd               31816  0
usbcore               108500  5 usb_storage,hid,uhci_hcd
sr_mod                 16288  0
cdrom                  35168  1 sr_mod
ide_scsi               16192  0
scsi_mod              106772  5 sg,sd_mod,usb_storage,sr_mod,ide_scsi
8139too                24576  0
mii                     5248  1 8139too
crc32                   4352  1 8139too
nls_iso8859_1           3968  2
nls_cp437               5632  2
vfat                   15872  3
fat                    47584  1 vfat
ext3                  117672  6
jbd                    61528  1 ext3
unix                   27276  211

The  tail of dmesg:

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 4
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0111
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 31232 512-byte hdwr sectors (16 MB)
sda: Write Protect is off
sda: Mode Sense: 00 06 00 00
SCSI device sda: drive cache: none
 sda: sda1
Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
usb 1-2: USB disconnect, address 4
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 5
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0111
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
usb 1-2: USB disconnect, address 5
drivers/usb/core/hub.c: USB device not accepting new address (error=-32)
Unable to handle kernel paging request at virtual address 4d554e95
 printing eip:
e092d3d4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e092d3d4>]    Not tainted
EFLAGS: 00010292
EIP is at scsi_try_host_reset+0x24/0xb0 [scsi_mod]
eax: 4d554e51   ebx: d4f61fa4   ecx: dcac7800   edx: 00000000
esi: d4f61fac   edi: df8281c0   ebp: d4f61f50   esp: d4f61f38
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_3 (pid: 3148, threadinfo=d4f60000 task=dc42f280)
Stack: 00002003 df8281c0 df8281c0 d4f61fa4 d4f61fac d4f61fac d4f61f6c e092d596
       df8281c0 00000001 d4f61fa4 d4f61fac dcac7a00 d4f61f8c e092d9b7 d4f61fac
       d4f61fa4 d4f61fa4 dcac7a20 d4f60000 00000282 d4f61fc0 e092db00 dcac7a00
Call Trace:
 [<e092d596>] scsi_eh_host_reset+0x36/0x90 [scsi_mod]
 [<e092d9b7>] scsi_eh_ready_devs+0x57/0x70 [scsi_mod]
 [<e092db00>] scsi_unjam_host+0xc0/0xd0 [scsi_mod]
 [<e092dbd6>] scsi_error_handler+0xc6/0x110 [scsi_mod]
 [<e092db10>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107259>] kernel_thread_helper+0x5/0xc

Code: 8b 40 44 8b 40 2c 85 c0 75 10 b8 03 20 00 00 8b 5d f4 8b 75

What else would be helpful?

Thanks,

Andy Johnson

