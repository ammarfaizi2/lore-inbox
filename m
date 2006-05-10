Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWEJBsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWEJBsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 21:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWEJBsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 21:48:42 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:48267 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751108AbWEJBsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 21:48:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ValbBXZ+ny7mSDc4+9NKKyLe3fXCIkBHboonQ09IBqbYhAzJSEm1b/1mRUrp1HeNPnqUgtLu+156M4svmZI6WdCjf+ML4wpauUtxy+bgPyE9TwwlQNDpbmpCC2Wp8I8WxOWky4rbaEjW+eVvBw96Ytav9tEOls4cT23bpOgbhNk=
Message-ID: <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
Date: Tue, 9 May 2006 21:48:36 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Updated libata PATA patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147196676.3172.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147196676.3172.133.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> - Re-enable per device speed setting
> - Fix VIA cable detect bug  (reporter: Mathieu Castet)
> - Fix AMD cable detect bug  (reporter: Sangoi Leonard)
> - Fix CS5535 build (reporter: Meelis Roos)
> - Trap 0 IRQ case
> - Fix IRQ allocation for pata_pcmcia (reporter: Kevin Radloff)

Slightly different this time, but still another oops ;)

pccard: PCMCIA card inserted into slot 1
cs: memory probe 0x50000000-0x53ffffff: excluding 0x50000000-0x53ffffff
cs: memory probe 0xd0200000-0xd02fffff: excluding 0xd0200000-0xd021ffff
pcmcia: registering new device pcmcia1.0
ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
setup_irq: irq handler mismatch
 <b012a6ae> setup_irq+0xfb/0x10e   <b02414b3> ata_interrupt+0x0/0x13d
 <b012a72d> request_irq+0x6c/0x88   <b0240ca5> ata_device_add+0x2f8/0x599
 <f01bb506> pcmcia_init_one+0x4b4/0x512 [pata_pcmcia]   <f01a417e>
pcmcia_device_probe+0x7b/0x109 [pcmcia]
 <b023350e> __driver_attach+0x0/0x59   <b0233471> driver_probe_device+0x42/0x8b
 <b0233544> __driver_attach+0x36/0x59   <b0232f9c> bus_for_each_dev+0x33/0x55
 <b02333db> driver_attach+0x11/0x13   <b023350e> __driver_attach+0x0/0x59
 <b0232cc6> bus_add_driver+0x64/0xfa   <f01a3d1f>
pcmcia_register_driver+0x4a/0xab [pcmcia]
 <b0128815> sys_init_module+0x1221/0x13ae   <b0102aeb> syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000000
 printing eip:
b0233b54
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: pata_pcmcia snd_intel8x0 snd_intel8x0m joydev
snd_ac97_codec snd_ac97_bus pcmcia firmware_class sg snd_pcm_oss
snd_mixer_oss snd_pcm ohci1394 ehci_hcd uhci_hcd snd_timer ieee1394
8139too mii usbcore psmouse sr_mod snd soundcore snd_page_alloc evdev
yenta_socket rsrc_nonstatic pcmcia_core crc32 cdrom
CPU:    0
EIP:    0060:[<b0233b54>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-rc3-ck3-ide2-fu-mw #1)
EIP is at make_class_name+0x29/0x88
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000009
esi: b02efb2c   edi: 00000000   ebp: 00000000   esp: b18fbb9c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 991, threadinfo=b18fb000 task=eef42540)
Stack: <0>eea7f9f8 eea7f9f8 b02efb2c b02efb34 b02efac0 b0233d2d
00000000 00000000
       eea7f9f8 00000246 eea7f800 eea7f828 b0233dc8 eea7f8d0 b02376b4 eea7fa90
       eedf84c0 00003100 0000310e b023e697 00000000 b0240ecf b18fbc4c eedf84c0
Call Trace:
 <b0233d2d> class_device_del+0x6f/0x102   <b0233dc8>
class_device_unregister+0x8/0x10
 <b02376b4> scsi_remove_host+0xe5/0xf0   <b023e697> ata_host_remove+0xe/0x18
 <b0240ecf> ata_device_add+0x522/0x599   <f01bb506>
pcmcia_init_one+0x4b4/0x512 [pata_pcmcia]
 <f01a417e> pcmcia_device_probe+0x7b/0x109 [pcmcia]   <b023350e>
__driver_attach+0x0/0x59
 <b0233471> driver_probe_device+0x42/0x8b   <b0233544> __driver_attach+0x36/0x59
 <b0232f9c> bus_for_each_dev+0x33/0x55   <b02333db> driver_attach+0x11/0x13
 <b023350e> __driver_attach+0x0/0x59   <b0232cc6> bus_add_driver+0x64/0xfa
 <f01a3d1f> pcmcia_register_driver+0x4a/0xab [pcmcia]   <b0128815>
sys_init_module+0x1221/0x13ae
 <b0102aeb> syscall_call+0x7/0xb
Code: d0 c3 55 31 ed 57 56 53 83 cb ff 83 ec 04 89 d9 89 04 24 8b 40
44 8b 38 89 e8 f2 ae f7 d1 49 8b 04 24 89 ca 89 d9 8b 78 08 89 e8 <f2>
ae f7 d1 49 8d 44 0a 02 ba d0 00 00 00 e8 b9 d9 f0 ff ba f4
EIP: [<b0233b54>] make_class_name+0x29/0x88 SS:ESP 0068:b18fbb9c

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
