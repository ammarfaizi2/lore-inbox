Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWCLFgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWCLFgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 00:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWCLFgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 00:36:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:32711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751426AbWCLFgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 00:36:24 -0500
Date: Sat, 11 Mar 2006 21:35:32 -0800
From: Greg KH <greg@kroah.com>
To: Bob Copeland <bcopeland@gmail.com>, linux-usb-devel@lists.sourceforge.net
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Message-ID: <20060312053532.GA23307@kroah.com>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:25:35AM -0500, Bob Copeland wrote:
> I searched the mailing list and saw a similar report but that was back
> in January and it looked to be resolved.  I get the following oops in
> pppd when I'm connected with my tethered cell phone and accidentally
> unplug the usb cable.  Happens every time.  I'm running Linus' git
> 0d514f040ac6629311974889d5b96bcf21c6461a (I think).

Previous versions of bugs with this driver were fixed in the past, but
unfortunatly, you are one of the lucky owners of a phone that causes
this problem :(

There is an open Novell bug for this issue, but the USB developers that
have tried to fix this in the past have had no luck at all (probably
because we don't have the device to test with).

What exact model of phone is this?

thanks,

greg k-h


(oops left below for linux-usb-devel people to see, for more details,
see the full lkml thread.)


> 
> PPP Deflate Compression module registered
> usb 1-2: USB disconnect, address 4
> Unable to handle kernel paging request at virtual address 6b6b6bfb
>  printing eip:
> c027a4f6
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async
> crc_ccitt ppp_generic slhc i915 binfmt_misc parport_pc lp parport
> video thermal processor fan button battery ac af_packet nls_iso8859_1
> nls_cp437 vfat fat dm_mod fuse evdev usb_storage ide_cd sr_mod
> scsi_mod cdrom i810 drm cdc_acm pcmcia crc32 eth1394 ipw2100 tg3
> ieee80211 ieee80211_crypt 8250_pci 8250 serial_core yenta_socket
> rsrc_nonstatic pcmcia_core ohci1394 ieee1394 snd_intel8x0 ehci_hcd
> snd_intel8x0m snd_ac97_codec uhci_hcd snd_ac97_bus usbcore intel_agp
> agpgart unix
> CPU:    0
> EIP:    0060:[<c027a4f6>]    Not tainted VLI
> EFLAGS: 00210046   (2.6.16-rc5 #16)
> EIP is at __mutex_lock_slowpath+0x70/0x286
> eax: cf549e20   ebx: cf548000   ecx: 00000000   edx: 00000054
> esi: 6b6b6bdb   edi: cea6f030   ebp: c017592e   esp: cf549e20
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 4076, threadinfo=cf548000 task=cea6f030)
> Stack: <0>cf549e20 cf549e20 11111111 11111111 cf549e20 cce32c60
> cf609cc4 cf609ccc
>        cf609c60 c017592e ccabf7a0 cce5466c 6b6b6b6b cce32c60 cf609cc4 cf609ccc
>        cf609c60 c01e756e cce5466c ccabf7a0 cd619aac c029fd21 00000000 ccabf7a0
> Call Trace:
>  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
>  [<c01e756e>] class_device_del+0xa0/0x11c
>  [<c01e75f5>] class_device_unregister+0xb/0x16
>  [<d01f81f3>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
>  [<d01f8baa>] acm_tty_close+0x9d/0xac [cdc_acm]
>  [<c01d6c1c>] release_dev+0x1a9/0x5b7
>  [<c01d7e37>] opost+0x1bb/0x1d3
>  [<c0146d9d>] __fput+0x74/0x132
>  [<c01d72e8>] tty_release+0x9/0xc
>  [<c0146dc8>] __fput+0x9f/0x132
>  [<c0144c06>] filp_close+0x4e/0x57
>  [<c0145584>] sys_close+0x56/0x63
>  [<c01029c9>] syscall_call+0x7/0xb
> Code: dc dd 27 c0 85 d2 0f 44 c2 68 ef 59 28 c0 c7 05 98 48 2c c0 00
> 00 00 00 a3 8c 33 2c c0 e8 be c1 e9 ff e8 f4 95 e8 ff 83 c4 10 fa <39>
> 76 20 74 49 83 3d 98 48 2c c0 00 74 40 8b 15 8c 33 2c c0 b8
>  <3>Debug: sleeping function called from invalid context at
> include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
>  [<c0116c69>] exit_mm+0x28/0xe8
>  [<c011773a>] do_exit+0x17f/0x619
>  [<c0103d85>] do_simd_coprocessor_error+0x0/0x14f
>  [<c0111cf7>] do_page_fault+0x389/0x4c0
>  [<c011196e>] do_page_fault+0x0/0x4c0
>  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
>  [<c010345f>] error_code+0x4f/0x54
>  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
>  [<c027a4f6>] __mutex_lock_slowpath+0x70/0x286
>  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
>  [<c01e756e>] class_device_del+0xa0/0x11c
>  [<c01e75f5>] class_device_unregister+0xb/0x16
>  [<d01f81f3>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
>  [<d01f8baa>] acm_tty_close+0x9d/0xac [cdc_acm]
>  [<c01d6c1c>] release_dev+0x1a9/0x5b7
>  [<c01d7e37>] opost+0x1bb/0x1d3
>  [<c0146d9d>] __fput+0x74/0x132
>  [<c01d72e8>] tty_release+0x9/0xc
>  [<c0146dc8>] __fput+0x9f/0x132
>  [<c0144c06>] filp_close+0x4e/0x57
>  [<c0145584>] sys_close+0x56/0x63
>  [<c01029c9>] syscall_call+0x7/0xb
> 
> -Bob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
