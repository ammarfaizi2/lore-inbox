Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUCMMxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 07:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbUCMMxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 07:53:49 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:3756 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S263085AbUCMMxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 07:53:41 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] Removing USB Bluetooth dongle Oopses 2.6.4
Date: Sat, 13 Mar 2004 13:51:44 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gPwUA5bK9bF0o6E"
Message-Id: <200403131351.44682.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gPwUA5bK9bF0o6E
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello lkml!

Here comes the oops:

PREEMPT
CPU:	0
EIP:	0060:[<e1921149>]	Not tainted
EIP is at urb_unlink+0x31/0x8e [usbcore]
eax: c17c069c	ebx: 00000000	ecx: 00000000	edx: dec74000
esi: 00000246	edi: c17c0694	ebp: de5aa1f0	esp: dec75e14
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 6150, threadinfo=dec74000 task=dfa6a100)
Stack: c17c0694 de5aa000 dec75edc c17c0694 dec75edc de5aa000 e19218af c17c0694
       c17c0694 dec74000 c17c0694 e19f5db4 de5aa000 c17c0694 dec75edc dec75edc
       de5aa1d0 de5aa1d0 de5aa000 dec75edc e19f5f72 de5aa000 dec75edc 00701300
Call trace:
 [<e19218af>] usb_hcd_giveback_urb+0x1b/0x39 [usbcore]
 [<e19f5db4>] uhci_finish_completion+0x61/0x9c [uhci_hcd]
 [<e19f5f72>] uhci_irq+0x103/0x165 [uhci_hcd]
 [<e1921903>] usb_hcd_irq+0x36/0x67 [usbcore]
 [<c010ae8a>] handle_IRQ_event+0x3a/0x64
 [<c010b1f7>] do_IRQ+0x94/0x136
 [<c0116eea>] do_page_fault+0x0/0x50c
 [<c0109750>] common_interrupt+0x18/0x20
 [<c0116eea>] do_page_fault+0x0/0x50c
 [<c0116f11>] do_page_fault+0x27/0x50c
 [<c0141c0b>] unmap_vmas+0xdc/0x212
 [<c01451b7>] unmap_vma+0x40/0x7d
 [<c0145210>] unmap_vma_list+0x1c/0x28
 [<c0145625>] do_munmap+0x146/0x183
 [<c0116eea>] do_page_fault+0x0/0x50c
 [<c010980d>] error_code+0x2d/0x38

Code: 89 59 04 89 0b 89 40 04 89 47 08 8b 5f 14 56 9d 8b 42 08 83
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


Here is the modules list:

Module                  Size  Used by
rfcomm                 33820  0 
l2cap                  21124  3 rfcomm
hci_usb                 9728  1 
bluetooth              43108  3 rfcomm,l2cap,hci_usb
ide_cd                 37636  0 
cdrom                  35872  1 ide_cd
ds                     11524  2 
hid                    23040  0 
intel_agp              15772  1 
agpgart                25896  1 intel_agp
uhci_hcd               29200  0 
ehci_hcd               23428  0 
snd_intel8x0           28804  0 
snd_ac97_codec         58756  1 snd_intel8x0
snd_mpu401_uart         6272  1 snd_intel8x0
snd_rawmidi            20128  1 snd_mpu401_uart
snd_seq_oss            31488  0 
snd_seq_midi_event      6272  1 snd_seq_oss
snd_seq                50192  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          6536  3 snd_rawmidi,snd_seq_oss,snd_seq
snd_pcm_oss            48164  0 
snd_pcm                84900  2 snd_intel8x0,snd_pcm_oss
snd_page_alloc          9348  2 snd_intel8x0,snd_pcm
snd_timer              21380  2 snd_seq,snd_pcm
snd_mixer_oss          17280  1 snd_pcm_oss
snd                    45796  12 
snd_intel8x0,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7392  1 snd
rtc                    10552  0 
usbcore                89820  6 hci_usb,hid,uhci_hcd,ehci_hcd
md5                     3712  1 
ipv6                  228160  11 
fan                     4236  0 
button                  6296  0 
thermal                16400  0 
processor              24496  1 thermal
battery                10636  0 
ac                      5004  0 
e100                   29056  0 
yenta_socket           14336  0 
pcmcia_core            59872  2 ds,yenta_socket
unix                   23472  12 


You'll find the kernel config attached:

Steps to reproduce the problem:

1) Insert the usb bt dongle
2) Start the bluetooth services (rfcomm, hcid...)
3) Stop the bluetooth services
4) Extrach the dongle - Doing rmmod uhci_hcd also causes the same oops.

Notice that SCO BT support is NOT compiled into the kernel, so this is a 
different oops than similar ones reported before.
After step 3 it is possible to remove rfcomm and l2cap, but hci_usb and 
bluetooth seem to lock one another, making it impossible to remove them from 
the running kernel.

Regards,
Silla

--Boundary-00=_gPwUA5bK9bF0o6E
Content-Type: application/x-bzip2;
  name="2.6.4.cfg.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="2.6.4.cfg.bz2"

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
ChIZJojEoA==

--Boundary-00=_gPwUA5bK9bF0o6E--
