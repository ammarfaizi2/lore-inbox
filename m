Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUHQN17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUHQN17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUHQN16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:27:58 -0400
Received: from postman.fhs-hagenberg.ac.at ([193.170.124.96]:4819 "EHLO
	postman.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S268222AbUHQNZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:25:50 -0400
Message-ID: <412207F2.8070404@fh-hagenberg.at>
Date: Tue, 17 Aug 2004 15:28:18 +0200
From: Manuel Lauss <manuel.lauss@fh-hagenberg.at>
Organization: FH Hagenberg / HSSE
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
CC: manuel.lauss@fh-hagenberg.at
Subject: 2.6.8.1-mm1: oops with firmware loading
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2004 13:25:44.0428 (UTC) FILETIME=[B3110AC0:01C4845D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The new sysfs-backingstore patches cause an oops when I ifup a
prism54 based device, heres the dmesg section:

Loaded prism54 driver, version 1.2
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 9 (level, low) -> IRQ 9
eth0: no IPv6 routers present
eth2: islpci_open()
eth2: resetting device...
eth2: uploading firmware...
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: prism54 firmware_class sonypi ipv6 usbhid ds ohci_hcd
ohci1394 yenta_socket pcmcia_core ehci_hcd uhci_hcd intel_agp agpgart
snd_intel8x0 snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_timer
snd_page_alloc snd_mixer_oss snd soundcore usbcore ntfs vfat fat eth1394
ieee1394 hidp rfcomm l2cap bluetooth
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010296   (2.6.8.1-mm1)
EIP is at 0x0
eax: f749542c   ebx: 00000000   ecx: 00000000   edx: f7227000
esi: f7495388   edi: 00001000   ebp: f789d99c   esp: f74dbf38
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 9839, threadinfo=f74db000 task=f7a5abb0)
Stack: c018745e 00000000 00000000 00001000 00001000 f78c9a40 c0187526
00000000
        00000000 00001000 00000000 00000000 f7227000 bfffe5b0 c03914e0
f78c9a40
        00001000 f74dbfac c015402e f74dbfac 00014e00 00000003 bfffe5b0
f78c9a40
Call Trace:
  [<c018745e>] flush_write+0x2e/0x40
  [<c0187526>] write+0xb6/0x120
  [<c015402e>] vfs_write+0xfe/0x130
  [<c0154111>] sys_write+0x41/0x70
  [<c0103fe9>] sysenter_past_esp+0x52/0x71
Code:  Bad EIP value.
  <3>prism54: request_firmware() failed for 'isl3890'
eth2: could not upload firmware ('isl3890')


Backing out all sysfs-backing-store patches cures the problem.
(sysfs-backing-store-prepare-file_perations.patch alone triggers the
  oops)

I think the oops comes from
  drivers/base/firmware_class.c:423


Thanks,

-- 
Manuel Lauss
Student HSSE / FH Hagenberg
