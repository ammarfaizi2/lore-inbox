Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUBEEdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUBEEdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:33:51 -0500
Received: from d40.sstar.com ([209.205.179.40]:14347 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S263082AbUBEEds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:33:48 -0500
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with USB scanner in 2.6.2
Date: Wed, 4 Feb 2004 22:33:45 -0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402042233.45790.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't happen with 2.4.22.  The scanner works OK until I turn it off.
Then I get the oops.  rmmod scanner hangs, with and without the -f switch.

usb 1-4: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
 printing eip:
e08d71fc
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e08d71fc>]    Not tainted
EFLAGS: 00010246
EIP is at disconnect_scanner+0x2c/0x5d [scanner]
eax: df692740   ebx: df692754   ecx: e08d71d0   edx: 00000002
esi: 00000000   edi: df37a8c0   ebp: df6e3e1c   esp: df6e3e0c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 397, threadinfo=df6e2000 task=df6e58c0)
Stack: df692740 e08db638 df692740 e08db6a0 df6e3e38 e0928107 df692740 df692740
       df692754 df692754 e08db6c0 df6e3e50 c01e01d0 df692754 df692780 df37a8fc
       df37a8e8 df6e3e6c e08d6af6 df692754 df692740 df37a8fc e08db5cc 00000000
Call Trace:
 [<e0928107>] usb_unbind_interface+0x77/0x80 [usbcore]
 [<c01e01d0>] device_release_driver+0x60/0x70
 [<e08d6af6>] destroy_scanner+0x76/0xd0 [scanner]
 [<c0198edd>] kobject_cleanup+0x8d/0x90
 [<e0928107>] usb_unbind_interface+0x77/0x80 [usbcore]
 [<c01e01d0>] device_release_driver+0x60/0x70
 [<c01e034d>] bus_remove_device+0x6d/0xb0
 [<c01df164>] device_del+0x74/0xb0
 [<e092e8c1>] usb_disable_device+0x71/0xb0 [usbcore]
 [<e0928c16>] usb_disconnect+0xc6/0x120 [usbcore]
 [<e092b438>] hub_port_connect_change+0x338/0x340 [usbcore]
 [<e092ad21>] hub_port_status+0x41/0xb0 [usbcore]
 [<e092b784>] hub_events+0x344/0x3b0 [usbcore]
 [<e092b825>] hub_thread+0x35/0xe0 [usbcore]
 [<c011a310>] default_wake_function+0x0/0x20
 [<e092b7f0>] hub_thread+0x0/0xe0 [usbcore]
 [<c01071c9>] kernel_thread_helper+0x5/0xc

Code: 80 7e 1e 00 75 1e 85 f6 74 12 8d 46 3c 8b 5d f8 8b 75 fc 89

lsmod output:

radeon                122392  28
via_agp                 7616  1
agpgart                32648  2 via_agp
via686a                20036  0
i2c_isa                 1920  0
i2c_sensor              3072  1 via686a
i2c_dev                10560  0
i2c_core               23872  4 via686a,i2c_isa,i2c_sensor,i2c_dev
snd_pcm_oss            54020  0
snd_mixer_oss          19712  2 snd_pcm_oss
snd_emu10k1            96644  1
snd_rawmidi            25664  1 snd_emu10k1
snd_pcm                98624  2 snd_pcm_oss,snd_emu10k1
snd_timer              26304  1 snd_pcm
snd_seq_device          8516  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         53508  1 snd_emu10k1
snd_page_alloc         12036  2 snd_emu10k1,snd_pcm
snd_util_mem            4672  1 snd_emu10k1
snd_hwdep               9984  1 snd_emu10k1
snd                    52804  10 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep
soundcore               9824  2 snd
tmdc                    6912  0
joydev                 10624  0
emu10k1_gp              3520  0
gameport                4736  2 tmdc,emu10k1_gp
pcspkr                  3464  0
parport_pc             36492  1
lp                     11108  0
parport                43648  2 parport_pc,lp
usbmouse                5568  0
hid                    33408  0
scanner                23040  0
uhci_hcd               32136  0
ohci_hcd               16256  0
ehci_hcd               24832  0
usbcore               110484  8 usbmouse,hid,scanner,uhci_hcd,ohci_hcd,ehci_hcd
8139too                22336  0
mii                     5248  1 8139too
crc32                   4352  1 8139too
nls_iso8859_1           3968  1
nls_cp437               5632  1
vfat                   15360  1
fat                    48288  1 vfat
nls_base                7616  4 nls_iso8859_1,nls_cp437,vfat,fat
ext3                  111560  5
jbd                    61976  1 ext3
unix                   28684  202

Any other info that would be helpful?

Thanks,

Andy Johnson


