Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWBHAVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWBHAVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWBHAVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:21:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030308AbWBHAVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:21:38 -0500
Date: Tue, 7 Feb 2006 16:23:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Dittmer <jdi@l4x.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. 
 Have a nice day...
Message-Id: <20060207162335.5304ae61.akpm@osdl.org>
In-Reply-To: <43E90573.8040305@l4x.org>
References: <43E90573.8040305@l4x.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <jdi@l4x.org> wrote:
>
> Debian 2.6.15-1-686-smp
> 
> $ umount /mnt/data
> Segmentation Fault
> 
> dmesg:
> 
> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> Unable to handle kernel NULL pointer dereference at virtual address 00000034

That was clever.

>  printing eip:
> f88c7e07
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: xfs rfcomm l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc  ipv6 deflate zlib_deflate twofish serpent aes blowfish des sha256
> sha1 crypto_n ull af_key raid5 xor dm_mod tun vfat fat loop lp usbmouse eeprom i2c_dev i2c_isa  i2c_core usbkbd usb_storage ehci_hcd button processor
> ac ide_cd cdrom e100 mii 3w_xxxx e1000 joydev piix serio_raw uhci_hcd generic parport_pc ide_core usbcore  parport pcspkr psmouse rtc ext3 jbd mbcache
> raid1 md_mod sd_mod aic79xx scsi_tr ansport_spi scsi_mod shpchp pci_hotplug evdev mousedev
> CPU:    2
> EIP:    0060:[<f88c7e07>]    Not tainted VLI
> EFLAGS: 00210282   (2.6.15-1-686-smp)
> EIP is at ext3_show_options+0x13/0xd5 [ext3]
> eax: 00000000   ebx: f7f1fe00   ecx: da82c540   edx: 00000000
> esi: da82c540   edi: da82c540   ebp: 00000400   esp: f7bcbf18
> ds: 007b   es: 007b   ss: 0068
> Process mv (pid: 4409, threadinfo=f7bca000 task=e9978a70)
> Stack: 00000000 dfd74c00 c01646cf da82c540 dfd74c00 da82c540 dfd74c00 00000143
>        c0167ffd da82c540 dfd74c00 00000000 da82c560 0000000a 00000000 00000009
>        00000000 00000400 e64cea80 40019000 00000000 c014ca9d e64cea80 40019000
> Call Trace:
>  [<c01646cf>] show_vfsmnt+0xcf/0xe6
>  [<c0167ffd>] seq_read+0x199/0x26a
>  [<c014ca9d>] vfs_read+0xa1/0x138

Have you any idea what `mv' was doing in ext3_show_options?  I can only
think that something was doing `mv /proc/mounts somewhere-else', which is
odd.

