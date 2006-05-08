Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWEHRaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWEHRaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWEHRaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:30:00 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:18730 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932473AbWEHRaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:30:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LOHPMGKfUq/rfOr/OY5WWH+20A0IxQcSjXYfsQDazTa7lV4WbYTrVgBnjMOza/eVqzhxRWJLTDFunqvOvHUps+Y4ajgWurCKesWOovAdAqp542GE05MnUxArHZedTItHwFHRPEHaPQKQXU2QXbfjRaNIiRVaHhyWbxFB2jsfyew=
Message-ID: <3b0ffc1f0605081029o604e5a3eu62f58b765a10bf65@mail.gmail.com>
Date: Mon, 8 May 2006 13:29:59 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch update
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147104400.3172.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147104400.3172.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I've posted a new patch versus 2.6.17-rc3 up at the usual location.

Thanks for the update. I'm still getting the same oops when inserting
a CF card, though:

pccard: PCMCIA card inserted into slot 1
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xdc000-0xfffff
cs: memory probe 0x50000000-0x53ffffff: excluding 0x50000000-0x53ffffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xd0200000-0xd02fffff: excluding 0xd0200000-0xd021ffff
pcmcia: registering new device pcmcia1.0
ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 0
setup_irq: irq handler mismatch
 <b012a6ae> setup_irq+0xfb/0x10e   <b02414f6> ata_interrupt+0x0/0x13e
 <b012a72d> request_irq+0x6c/0x88   <b0240ce8> ata_device_add+0x2b8/0x559
 <f01a9b8c> pcmcia_request_io+0xa3/0xc0 [pcmcia]   <f02314d4>
pcmcia_init_one+0x482/0x4e2 [pata_pcmcia]
 <f01a917e> pcmcia_device_probe+0x7b/0x109 [pcmcia]   <b023350e>
__driver_attach+0x0/0x59
 <b0233471> driver_probe_device+0x42/0x8b   <b0233544> __driver_attach+0x36/0x59
 <b0232f9c> bus_for_each_dev+0x33/0x55   <b02333db> driver_attach+0x11/0x13
 <b023350e> __driver_attach+0x0/0x59   <b0232cc6> bus_add_driver+0x64/0xfa
 <f01a8d1f> pcmcia_register_driver+0x4a/0xab [pcmcia]   <b0128815>
sys_init_module+0x1221/0x13ae
 <b0102aeb> syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000000
 printing eip:
b0233b54
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: pata_pcmcia ipt_LOG xt_limit xt_state
iptable_filter ip_conntrack i915 drm fuj02b1_acpi joydev snd_intel8x0
snd_intel8x0m snd_ac97_codec snd_ac97_bus pcmcia firmware_class sg
snd_pcm_oss snd_mixer_oss uhci_hcd ehci_hcd snd_pcm snd_timer ohci1394
ieee1394 sr_mod psmouse yenta_socket rsrc_nonstatic pcmcia_core
usbcore 8139too mii crc32 snd soundcore snd_page_alloc evdev cdrom
CPU:    0
EIP:    0060:[<b0233b54>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-rc3-ck3-ide1-fu-mw #1)
EIP is at make_class_name+0x29/0x88
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000009
esi: b02efb2c   edi: 00000000   ebp: 00000000   esp: b18c3b98
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2412, threadinfo=b18c3000 task=eea3b070)
Stack: <0>ef3fa9f8 ef3fa9f8 b02efb2c b02efb34 b02efac0 b0233d2d
00000000 00000000
       ef3fa9f8 00000246 ef3fa800 ef3fa828 b0233dc8 ef3fa8d0 b02376b4 ef3faa90
       ee432140 00003100 0000310e b023e697 00000000 b0240f12 b18c3c4c ee432140
Call Trace:
 <b0233d2d> class_device_del+0x6f/0x102   <b0233dc8>
class_device_unregister+0x8/0x10
 <b02376b4> scsi_remove_host+0xe5/0xf0   <b023e697> ata_host_remove+0xe/0x18
 <b0240f12> ata_device_add+0x4e2/0x559   <f01a9b8c>
pcmcia_request_io+0xa3/0xc0 [pcmcia]
 <f02314d4> pcmcia_init_one+0x482/0x4e2 [pata_pcmcia]   <f01a917e>
pcmcia_device_probe+0x7b/0x109 [pcmcia]
 <b023350e> __driver_attach+0x0/0x59   <b0233471> driver_probe_device+0x42/0x8b
 <b0233544> __driver_attach+0x36/0x59   <b0232f9c> bus_for_each_dev+0x33/0x55
 <b02333db> driver_attach+0x11/0x13   <b023350e> __driver_attach+0x0/0x59
 <b0232cc6> bus_add_driver+0x64/0xfa   <f01a8d1f>
pcmcia_register_driver+0x4a/0xab [pcmcia]
 <b0128815> sys_init_module+0x1221/0x13ae   <b0102aeb> syscall_call+0x7/0xb
Code: d0 c3 55 31 ed 57 56 53 83 cb ff 83 ec 04 89 d9 89 04 24 8b 40
44 8b 38 89 e8 f2 ae f7 d1 49 8b 04 24 89 ca 89 d9 8b 78 08 89 e8 <f2>
ae f7 d1 49 8d 44 0a 02 ba d0 00 00 00 e8 b9 d9 f0 ff ba f4
EIP: [<b0233b54>] make_class_name+0x29/0x88 SS:ESP 0068:b18c3b98

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
