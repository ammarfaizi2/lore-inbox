Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWCKUVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWCKUVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 15:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCKUVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 15:21:18 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:15263 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbWCKUVS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 15:21:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d4zDplxr56pWMoS19gCrxPG/fzbGXqTWXM3oIbUGbuyrYDq4wPcTwwjDBQ9H/j/LHuEiGuPrjwoCVCMqIsoK+WGwDkC0EYoyu/COeTFVnOtPfogdb/6jtuPpn9TVDaPu4cSo4lvonaV09Akj+LAdJyFhy1zNBsGryzYYNg4SttY=
Message-ID: <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
Date: Sat, 11 Mar 2006 15:21:16 -0500
From: "Bob Copeland" <email@bobcopeland.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Cc: paulus@samba.org, "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1142099765.3241.3.camel@x2.pipehead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
	 <1142018709.26063.5.camel@amdx2.microgate.com>
	 <20060311150908.GA4872@hash.localnet>
	 <1142099765.3241.3.camel@x2.pipehead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, Paul Fulghum <paulkf@microgate.com> wrote:
> OK, try this patch with CONFIG_DEBUG_SLAB on and post the
> debug output with the oops.
>
> I do see one problem with the cdc-acm driver (not setting
> acm->tty to NULL on the last close, where tty is released).
>
> Thanks,
> Paul

dmesg follows...

usb 1-2: new full speed USB device using uhci_hcd and address 6
usb 1-2: configuration #1 chosen from 1 choice
drivers/usb/class/cdc-acm.c: Ignoring extra header, type -3, length 4
cdc_acm 1-2:1.1: ttyACM0: USB ACM device
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver
for USB modems and ISDN adapters
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
acm_tty_open tty=cd254af8 acm=ce24eca0 acm->used=00000000
PPP BSD Compression module registered
PPP Deflate Compression module registered
usb 1-2: USB disconnect, address 6
acm_disconnect intf=ce99f720 acm=ce24eca0 usb_dev=ce24f4b8
acm_disconnect acm->used=1 acm->dev=ce24f4b8 acm->tty=cd254af8
acm_disconnect intf=cefb6760 acm=00000000 usb_dev=ce24f4b8
acm_tty_close tty=cd254af8 filp=ce96511c acm=ce24eca0
acm_tty_close acm->used=1 acm->dev=00000000
Unable to handle kernel paging request at virtual address 6b6b6bfb
 printing eip:
c0279db6
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async
crc_ccitt ppp_generic slhc cdc_acm i915 binfmt_misc parport_pc lp
parport video thermal processor fan button battery ac af_packet
nls_iso8859_1 nls_cp437 vfat fat dm_mod fuse evdev ide_cd i810 drm
sr_mod cdrom usb_storage pcmcia crc32 scsi_mod eth1394 8250_pci 8250
serial_core ipw2100 yenta_socket tg3 snd_intel8x0 snd_intel8x0m
ieee80211 ieee80211_crypt rsrc_nonstatic pcmcia_core snd_ac97_codec
snd_ac97_bus ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore intel_agp
agpgart unix
CPU:    0
EIP:    0060:[<c0279db6>]    Not tainted VLI
EFLAGS: 00210046   (2.6.16-rc5 #18)
EIP is at __mutex_lock_slowpath+0x70/0x286
eax: c6065e20   ebx: c6064000   ecx: 00000000   edx: 00000054
esi: 6b6b6bdb   edi: c64f7550   ebp: c017585e   esp: c6065e20
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 4237, threadinfo=c6064000 task=c64f7550)
Stack: <0>c6065e20 c6065e20 11111111 11111111 c6065e20 c6223534
cf609cc4 cf609ccc
       cf609c60 c017585e c6ae0ae4 cee17ccc 6b6b6b6b c6223534 cf609cc4 cf609ccc
       cf609c60 c01e749e cee17ccc c6ae0ae4 c6e2266c c029ecfc 00000000 c6ae0ae4
Call Trace:
 [<c017585e>] sysfs_hash_and_remove+0x34/0x10a
 [<c01e749e>] class_device_del+0xa0/0x11c
 [<c01e7525>] class_device_unregister+0xb/0x16
 [<d036320d>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
 [<d0363c14>] acm_tty_close+0xc5/0xd4 [cdc_acm]
 [<c01d6b4c>] release_dev+0x1a9/0x5b7
 [<c011e186>] __group_complete_signal+0x17c/0x20d
 [<c011edf1>] sys_kill+0xd8/0xe7
 [<c0146d9d>] __fput+0x74/0x132
 [<c01d7218>] tty_release+0x9/0xc
 [<c0146dc8>] __fput+0x9f/0x132
 [<c0144c06>] filp_close+0x4e/0x57
 [<c0145584>] sys_close+0x56/0x63
 [<c01029c9>] syscall_call+0x7/0xb
Code: fc cd 27 c0 85 d2 0f 44 c2 68 0f 4a 28 c0 c7 05 98 38 2c c0 00
00 00 00 a3 8c 23 2c c0 e8 fe c8 e9 ff e8 34 9d e8 ff 83 c4 10 fa <39>
76 20 74 49 83 3d 98 38 2c c0 00 74 40 8b 15 8c 23 2c c0 b8
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 [<c0116c69>] exit_mm+0x28/0xe8
 [<c011773a>] do_exit+0x17f/0x619
 [<c0103d85>] do_simd_coprocessor_error+0x0/0x14f
 [<c0111cf7>] do_page_fault+0x389/0x4c0
 [<c011196e>] do_page_fault+0x0/0x4c0
 [<c017585e>] sysfs_hash_and_remove+0x34/0x10a
 [<c010345f>] error_code+0x4f/0x54
 [<c017585e>] sysfs_hash_and_remove+0x34/0x10a
 [<c0279db6>] __mutex_lock_slowpath+0x70/0x286
 [<c017585e>] sysfs_hash_and_remove+0x34/0x10a
 [<c01e749e>] class_device_del+0xa0/0x11c
 [<c01e7525>] class_device_unregister+0xb/0x16
 [<d036320d>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
 [<d0363c14>] acm_tty_close+0xc5/0xd4 [cdc_acm]
 [<c01d6b4c>] release_dev+0x1a9/0x5b7
 [<c011e186>] __group_complete_signal+0x17c/0x20d
 [<c011edf1>] sys_kill+0xd8/0xe7
 [<c0146d9d>] __fput+0x74/0x132
 [<c01d7218>] tty_release+0x9/0xc
 [<c0146dc8>] __fput+0x9f/0x132
 [<c0144c06>] filp_close+0x4e/0x57
 [<c0145584>] sys_close+0x56/0x63
 [<c01029c9>] syscall_call+0x7/0xb
