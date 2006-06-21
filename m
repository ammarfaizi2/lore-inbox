Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWFULml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWFULml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWFULmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:42:40 -0400
Received: from javad.com ([216.122.176.236]:9487 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751510AbWFULmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:42:39 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] moxa: do not ignore input
References: <200506021220.47138.vda@ilport.com.ua>
	<200506021554.07316.vda@ilport.com.ua>
	<20050602225805.GB9628@devserv.devel.redhat.com>
	<200506031601.21180.vda@ilport.com.ua> <87y7vrpwzr.fsf@javad.com>
	<1150890705.15275.58.camel@localhost.localdomain>
Date: Wed, 21 Jun 2006 15:41:31 +0400
In-Reply-To: <1150890705.15275.58.camel@localhost.localdomain> (Alan Cox's
	message of "Wed, 21 Jun 2006 12:51:44 +0100")
Message-ID: <87irmupwgk.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> Ar Maw, 2006-06-20 am 21:17 +0400, ysgrifennodd Sergei Organov:
>> This is on 2.6.14 kernel though, -- didn't try with more recent kernels
>> as I have other troubles with them on my hardware/distribution.
>> 
>> Not a big deal, but you've asked yourself ;)
>
> What does "dmesg" show for the Oops that caused the segfault ?

Didn't think to look at it before, but here it goes:

------------[ cut here ]------------
kernel BUG at drivers/char/mxser.c:998!
invalid operand: 0000 [#1]
SMP
Modules linked in: usbserial nls_iso8859_1 nls_cp437 vfat fat usb_storage nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc sr_mod sbp2 ide_generic ide_disk e1000 eth1394 usbhid ide_cd cdrom sk98lin snd_hda_intel snd_hda_codec skge ohci1394 ieee1394 snd_pcm_oss snd_mixer_oss piix i2c_i801 mxser i2c_core snd_pcm joydev snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore parport_pc parport serio_raw rtc floppy pcspkr ext3 jbd mbcache sd_mod generic ide_core ata_piix libata scsi_mod evdev mousedev psmouse
CPU:    0
EIP:    0060:[<f8f8d194>]    Tainted: P      VLI
EFLAGS: 00210246   (2.6.14-2-686-smp)
EIP is at mxser_close+0x224/0x2b0 [mxser]
eax: f8f8cf70   ebx: 00000000   ecx: 00000000   edx: d7603a80
esi: d7603a80   edi: c03088a6   ebp: e8639000   esp: c7165e14
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 9629, threadinfo=c7164000 task=ec3d2030)
Stack: c022a16e ffffffff d7603a80 00000000 e8639000 00000000 c03088a6 00000000
       c0229543 e8639000 d7603a80 00000000 c7165e74 00000000 c0336dcc 00000003
       00000000 00000009 00000000 00000003 00200292 e8639000 00000000 d2bd7424
Call Trace:
 [<c022a16e>] tty_fasync+0x6e/0x110
 [<c0229543>] release_dev+0x163/0x770
 [<c0228e79>] init_dev+0x2b9/0x5f0
 [<c01dae37>] kobject_get+0x17/0x20
 [<c0227557>] check_tty_count+0x47/0xb0
 [<c017160e>] cdev_get+0x1e/0xa0
 [<c0229cb7>] tty_open+0x167/0x310
 [<c017179a>] chrdev_open+0xba/0x1c0
 [<c0166082>] __dentry_open+0xd2/0x220
 [<c0166263>] filp_open+0x93/0xb0
 [<c0166382>] get_unused_fd+0xc2/0xf0
 [<c01664c5>] do_sys_open+0x55/0x100
 [<c0103115>] syscall_call+0x7/0xb
Code: b7 43 48 66 83 f8 ff 0f 85 9e fe ff ff e9 a5 fe ff ff 90 8d 74 26 00 8b 5c 24 10 8b 74 24 14 8b 7c 24 18 8b 6c 24 1c 83 c4 20 c3 <0f> 0b e6 03 bf 0c f9 f8 e9 02 fe ff ff 8b 4b 04 0f b6 43 4c 8d
