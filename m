Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932837AbWF1PZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWF1PZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbWF1PZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:25:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:46569 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932837AbWF1PZr (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:25:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DpLsQudD5R3TAPg+wb8bc8nl/fNFPkYP8EXXzHCpJNo0G51lMUf9Eq34wsERFtQp+gNJ3PL1PDvIpbxl21Q7wA00SnQAowrQnrVpO4VT/M/psABo2LqUj74GG3y2EKtruKjA2hIADFoLzcg0Go4K4UdCREtrP/9PsdUUZLWj8mo=
Message-ID: <3b0ffc1f0606280825t7d84f4d9u3ce1e5a97dc849aa@mail.gmail.com>
Date: Wed, 28 Jun 2006 11:25:45 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Cc: Linux-Kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0606250823h49ec5c9cy180d4941d6c9c8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <3b0ffc1f0606250823h49ec5c9cy180d4941d6c9c8b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/06, Kevin Radloff <radsaq@gmail.com> wrote:
> On 6/19/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > http://zeniv.linux.org.uk/~alan/IDE
> >
> > This is basically a resync versus 2.6.17, the head of the PATA tree is
> > now built against Jeffs tree with revised error handling and the like.
> >
> > Alan
>
> Hrm, I finally tried a different CF card (Viking 256MB) from the one I
> usually use in my camera, and it failed to work:
[...]

Ick, apparently I wasn't running what I was thought I was running. It
appears that the only reason pata_pcmcia was working at all was
because I was still using the 2.6.17-rc4-ide1 version of the patch (on
2.6.17 final). The 2.6.17-ide1 version of pata_pcmcia fails like so
(with my usual 1GB Sandisk card):

pccard: PCMCIA card inserted into slot 1
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xdc000-0xfffff
cs: memory probe 0x50000000-0x53ffffff: excluding 0x50000000-0x53ffffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xd0200000-0xd02fffff: excluding 0xd0200000-0xd021ffff
pcmcia: registering new device pcmcia1.0
ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
setup_irq: irq handler mismatch
 <b012a19d> setup_irq+0x106/0x119  <b023fc25> ata_interrupt+0x0/0x13f
 <b012a21c> request_irq+0x6c/0x88  <b023f3e8> ata_device_add+0x2f8/0x599
 <f02a3514> pcmcia_init_one+0x4c2/0x522 [pata_pcmcia]  <f0193198>
pcmcia_device_probe+0x7f/0x117 [pcmcia]
 <b0231c3a> __driver_attach+0x0/0x59  <b0231b9d> driver_probe_device+0x42/0x8b
 <b0231c70> __driver_attach+0x36/0x59  <b02316c8> bus_for_each_dev+0x33/0x55
 <b0231b07> driver_attach+0x11/0x13  <b0231c3a> __driver_attach+0x0/0x59
 <b02313f2> bus_add_driver+0x64/0xfa  <f0192d1b>
pcmcia_register_driver+0x4a/0xab [pcmcia]
 <b0128311> sys_init_module+0x1215/0x13a2  <b0102ae7> syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000000
 printing eip:
b0232280
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: pata_pcmcia rfcomm l2cap bluetooth ipt_LOG xt_limit
xt_state iptable_filter ip_conntrack i915 drm fuj02b1_acpi
snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus pcmcia
firmware_class snd_pcm_oss snd_mixer_oss joydev snd_pcm sg ehci_hcd
uhci_hcd ohci1394 snd_timer yenta_socket snd sr_mod rsrc_nonstatic
pcmcia_core usbcore ieee1394 soundcore psmouse cdrom 8139too
snd_page_alloc evdev mii
CPU:    0
EIP:    0060:[<b0232280>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-ck1-ide1-fu #1)
EIP is at make_class_name+0x29/0x88
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000009
esi: b02eca8c   edi: 00000000   ebp: 00000000   esp: e6159b9c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3094, threadinfo=e6159000 task=ef406070)
Stack: eb1451f8 eb1451f8 b02eca8c b02eca94 b02eca20 b0232459 00000000 00000000
       eb1451f8 00000246 eb145000 eb145028 b0232513 eb1450d0 b0235e0e eb145294
       e67cab80 00003100 0000310e b023cdf3 00000000 b023f612 e6159c4c e67cab80
Call Trace:
 <b0232459> class_device_del+0x6f/0x121  <b0232513>
class_device_unregister+0x8/0x10
 <b0235e0e> scsi_remove_host+0xdf/0xea  <b023cdf3> ata_host_remove+0xe/0x18
 <b023f612> ata_device_add+0x522/0x599  <f02a3514>
pcmcia_init_one+0x4c2/0x522 [pata_pcmcia]
 <f0193198> pcmcia_device_probe+0x7f/0x117 [pcmcia]  <b0231c3a>
__driver_attach+0x0/0x59
 <b0231b9d> driver_probe_device+0x42/0x8b  <b0231c70> __driver_attach+0x36/0x59
 <b02316c8> bus_for_each_dev+0x33/0x55  <b0231b07> driver_attach+0x11/0x13
 <b0231c3a> __driver_attach+0x0/0x59  <b02313f2> bus_add_driver+0x64/0xfa
 <f0192d1b> pcmcia_register_driver+0x4a/0xab [pcmcia]  <b0128311>
sys_init_module+0x1215/0x13a2
 <b0102ae7> syscall_call+0x7/0xb
Code: d0 c3 55 31 ed 57 56 53 83 cb ff 83 ec 04 89 d9 89 04 24 8b 40
44 8b 38 89 e8 f2 ae f7 d1 49 8b 04 24 89 ca 89 d9 8b 78 08 89 e8 <f2>
ae f7 d1 49 8d 44 0a 02 ba d0 00 00 00 e8 90 e4 f0 ff ba f4
EIP: [<b0232280>] make_class_name+0x29/0x88 SS:ESP 0068:e6159b9c

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
