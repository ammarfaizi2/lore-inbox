Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUELLHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUELLHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUELLHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:07:38 -0400
Received: from palma.portsdebalears.com ([195.53.243.35]:5775 "EHLO
	cochise.portsdebalears.com") by vger.kernel.org with ESMTP
	id S264920AbUELLHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:07:23 -0400
Date: Wed, 12 May 2004 13:06:54 +0200
From: Kiko Piris <kernel@pirispons.net>
To: Andrew Lau <netsnipe@users.sourceforge.net>
Cc: simon@thekelleys.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Atmel at76c50x PCMCIA 2.6.6 kernel panic
Message-ID: <20040512110654.GA13053@fpirisp.portsdebalears.com>
Mail-Followup-To: Andrew Lau <netsnipe@users.sourceforge.net>,
	simon@thekelleys.org.uk, linux-kernel@vger.kernel.org
References: <20040511134101.GA19530@espresso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511134101.GA19530@espresso>
User-Agent: Mutt
X-No-CC: Please respect my Mail-Followup-To header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2004 at 23:41, Andrew Lau wrote:

> My Atmel AT76C502AR_D 802.11b PCMCIA card was previously working fine
> under the 2.6.5 kernel via the atmel/atmel_cs modules. However, since
> upgrading to 2.6.6 I now get a kernel panic whenever I insert my card
[...]
> Call Trace:
>  [<c017cf6a>] sysfs_create_link+0x2a/0x13b
>  [<c01a672f>] kobject_hotplug+0x55/0x57
>  [<c020b792>] class_device_dev_link+0x30/0x34
>  [<c020ba59>] class_device_add+0xd9/0x110
>  [<d1cf55bc>] fw_register_class_device+0x10f/0x163 [firmware_class]
>  [<d1cf563c>] fw_setup_class_device+0x2c/0x111 [firmware_class]
>  [<d1cf5788>] request_firmware+0x67/0x160 [firmware_class]
>  [<d1d09917>] reset_atmel_card+0x65b/0x6b4 [atmel]
>  [<d1d059f6>] atmel_open+0xbf/0x1a5 [atmel]

I get the same oops with a 3com 3CRWE62092B pcmcia wireless card when
inserting it (with 2.6.6, 2.6.5 works fine).

It might be related to this thread: http://lkml.org/lkml/2004/4/23/4 .
I'm not really sure...

Please, let me know if I can provide any additional information to help.

This is the oops I get:

---8<---
NET: Registered protocol family 23
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: MAC address 00:04:75:ec:37:7d
eth1: Atmel at76c50x wireless. Version 0.96 simon@thekelleys.org.uk
eth1: 3com 3CRWE62092B index 0x01: Vcc 3.3, irq 3, io 0x0100-0x011f
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c016fe42
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c016fe42>]    Not tainted
EFLAGS: 00010246   (2.6.6) 
EIP is at object_path_length+0x1a/0x31
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: e99d0a24
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: e5d03d88
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 3065, threadinfo=e5d02000 task=e6d8f430)
Stack: 00000003 00000000 e99d0a24 e9940aa0 c016fed2 e99d0a24 e9940ab4 e9940aa0 
       c02053c6 c0335466 e6693ef4 e9940b00 e5bbed90 e9940b00 e9940aa0 c02393a6 
       e5bbed98 e99d0a24 c03358fd c023966d e5bbed90 e5bbedd8 e9940aec 00000000 
Call Trace:
 [<c016fed2>] sysfs_create_link+0x2a/0x13b
 [<c02053c6>] kobject_hotplug+0x55/0x57
 [<c02393a6>] class_device_dev_link+0x30/0x34
 [<c023966d>] class_device_add+0xd9/0x110
 [<e993f59f>] fw_register_class_device+0x10f/0x163 [firmware_class]
 [<e993f61f>] fw_setup_class_device+0x2c/0xe9 [firmware_class]
 [<e993f743>] request_firmware+0x67/0x160 [firmware_class]
 [<e9989856>] reset_atmel_card+0x65b/0x6b4 [atmel]
 [<e99859a6>] atmel_open+0xbf/0x1a5 [atmel]
 [<c0113fad>] __wake_up_locked+0x22/0x26
 [<c028c0d9>] dev_open+0xcc/0xfb
 [<c028d2cd>] dev_change_flags+0x51/0x120
 [<c02db18c>] devinet_ioctl+0x235/0x560
 [<c02854f6>] sock_ioctl+0x0/0x258
 [<c02dd2e7>] inet_ioctl+0x5e/0x9e
 [<c02855b6>] sock_ioctl+0xc0/0x258
 [<c0152c88>] sys_ioctl+0xb7/0x203
 [<c0103a77>] syscall_call+0x7/0xb

Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 
--->8---

-- 
Kiko
