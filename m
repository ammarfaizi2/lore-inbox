Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVDDS1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVDDS1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDDS1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:27:41 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:40745 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261238AbVDDS1X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:27:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=X39wVKrJ+heduhJPJB1LjCjVnCI0vBLGB7ajn4kQTtWy1NwuOlsddR4txoCoYZERelaAINDdw6EvpfGmO/mrgs9f57eXarI2q0F/oLTk2HAvsTV9AacJ9L+USlaErxEIkv3l4JButgLAYEXFOS6VoPnJiE4RnS3gm6aQtZEBKwQ=
Message-ID: <fe726f4e05040411273256c98f@mail.gmail.com>
Date: Mon, 4 Apr 2005 20:27:21 +0200
From: Carlos Martin <carlosmn@gmail.com>
Reply-To: Carlos Martin <carlosmn@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/sysfs/symlink.c:87 on 2.6.12-rc1-mm4
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This just jumped on my dmesg. It happens when you take the usb
'network' cable out of the machine and then plug it back in. The usb0
interface is up.
On earlier kernels it just wouldn't accept the usb address given, but
on -mm4 this bug comes out.
This also has the side-effect of killing USB until reboot.

------------[ cut here ]------------
kernel BUG at fs/sysfs/symlink.c:87!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usbnet ntfs nls_iso8859_1 nls_cp437 vfat fat sd_mod
usb_storage scsi_mod ipv6 eth1394 natsemi ohci1394 ieee1394 ehci_hcd
yenta_socket rsrc_nonstatic pcmcia_core 8250_pci 8250 serial_core
snd_ali5451 snd_ac97_codec snd_pcm snd_timer snd soundcore
snd_page_alloc ext3 jbd mbcache
CPU:    0
EIP:    0060:[<c018a1e7>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc1-mm4)
EIP is at sysfs_create_link+0x5f/0x69
eax: e8babf01   ebx: c710cbb4   ecx: 00000000   edx: c8322600
esi: 00000000   edi: c8322674   ebp: c4e09ebc   esp: c1557d90
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 82, threadinfo=c1556000 task=c1496540)
Stack: c8322614 c8322674 00000000 c023cd37 c8322614 e0aabb80 c0260a9c de752da9
       00000000 e0aa847e c0296ad1 4b87ad6e c4e09c00 00000000 c23eee00 c4e09e20
       c4e09e20 e0aaa812 c4e09c06 c4e09c00 e0aaa0d2 de6f5664 c0169395 00000286
Call Trace:
[<c023cd37>] device_bind_driver+0x33/0x52
[<c0260a9c>] usb_driver_claim_interface+0x53/0x55
[<e0aa847e>] generic_cdc_bind+0xce/0x2be [usbnet]
[<c0296ad1>] alloc_netdev+0x70/0xa7
[<e0aaa0d2>] usbnet_probe+0x2ee/0x456 [usbnet]
[<c0169395>] d_lookup+0x19/0x39
[<c01896af>] sysfs_lookup+0x6f/0xc7
[<c018921c>] sysfs_new_dirent+0x25/0x72
[<c026084b>] usb_probe_interface+0x55/0x75
[<c023cd86>] driver_probe_device+0x30/0x7f
[<c023cdda>] __device_attach+0x5/0x8
[<c023c696>] bus_for_each_drv+0x39/0x57
[<c01681a6>] dput+0x8a/0x284
[<c023ce12>] device_attach+0x35/0x39
[<c023cdd5>] __device_attach+0x0/0x8
[<c023c7da>] bus_add_device+0x2b/0x7b
[<c023bc75>] device_add+0xbb/0x137
[<c02681db>] usb_set_configuration+0x2d9/0x45e
[<c0262d46>] usb_new_device+0x91/0x1b1
[<c0263876>] check_highspeed+0x47/0xbd
[<c0263be9>] hub_port_connect_change+0x1d4/0x3b3
[<c0263fa6>] hub_events+0x1de/0x3ad
[<c02641aa>] hub_thread+0x35/0xf9
[<c01290f8>] autoremove_wake_function+0x0/0x43
[<c01027c2>] ret_from_fork+0x6/0x14
[<c01290f8>] autoremove_wake_function+0x0/0x43
[<c0264175>] hub_thread+0x0/0xf9
[<c0100ccd>] kernel_thread_helper+0x5/0xb
Code: 00 89 f9 89 f2 89 d8 e8 f5 fe ff ff 8b 53 08 89 c1 ff 42 70 0f
8e 57 02 00 00 89 c8 8b 1c 24 8b 74 24 04 8b 7c 24 08 83 c4 0c c3 <0f>
0b 57 00 e2 bb 30 c0 eb c0 8b 40 30 e9 1b e6 ff ff 55 57 56

-- 
Carlos Martín         http://www.cmartin.tk

"I'll wager it's the most extraordinary thing to happen round here
since Queen Elizabeth's handmaid got hit by lightning and sprouted a
beard"
     -- T. C. Boyle, "Water Music"
