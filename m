Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTEAGHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTEAGHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:07:30 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:53764 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262633AbTEAGH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:07:27 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [BUG] 2.5.68-mm2 and list.h
References: <20030423012046.0535e4fd.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 May 2003 08:19:48 +0200
In-Reply-To: <20030423012046.0535e4fd.akpm@digeo.com>
Message-ID: <873cjznq7v.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:
>
> [SNIP]
>

Caught this one on boot:

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.1
drivers/usb/core/usb.c: registered new driver hci_usb
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
- ------------[ cut here ]------------
kernel BUG at include/linux/list.h:140!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011acc2>]    Not tainted VLI
EFLAGS: 00010083
EIP is at remove_wait_queue+0x66/0x70
eax: ec937d94   ebx: ec936000   ecx: ec937da0   edx: ec797d28
esi: 00000286   edi: ec937d94   ebp: ec937d58   esp: ec937d50
ds: 007b   es: 007b   ss: 0068
Process logger (pid: 3942, threadinfo=ec936000 task=edede700)
Stack: ec797d28 ec936000 ec937dc0 c019e462 c02fff00 00000002 c0117b14 ec797d24
       effb1600 00000000 edede700 c0119716 00000000 00000000 00000000 ec937ee7
       ecaa5df0 00000000 edede700 c0119716 ec797d28 ec797d28 ec937ee7 0026c8ca
Call Trace:
 [<c019e462>] devfs_d_revalidate_wait+0x181/0x18d
 [<c0117b14>] do_page_fault+0x0/0x4bf
 [<c0119716>] default_wake_function+0x0/0x12
 [<c0119716>] default_wake_function+0x0/0x12
 [<c015add3>] do_lookup+0x5c/0x98
 [<c015b2c6>] link_path_walk+0x4b7/0x8fd
 [<c01350cd>] file_read_actor+0x0/0x11f
 [<c01350cd>] file_read_actor+0x0/0x11f
 [<c029d529>] unix_find_other+0x2e/0x158
 [<c029dac4>] unix_dgram_connect+0xfb/0x1a5
 [<c024a9ec>] sys_connect+0xa9/0xb1
 [<c024953d>] sock_map_fd+0x118/0x12e
 [<c024a586>] sys_socket+0x3a/0x56
 [<c024b50f>] sys_socketcall+0xb2/0x262
 [<c015ef49>] do_fcntl+0xd8/0x1a4
 [<c015f0fa>] sys_fcntl64+0x6f/0xab
 [<c010ae57>] syscall_call+0x7/0xb
                                                                                                                                                                                                                                    
Code: 43 08 83 e0 08 75 0b 8b 1c 24 8b 74 24 04 89 ec 5d c3 8b 1c 24 8b 74 24 04 89 ec 5d e9 0e ea ff ff 0f 0b 8d 00 12 42 2b c0 eb c9 <0f> 0b 8c 00 12 42 2b c0 eb b7 55 89 e5 83 ec 0c 89 1c 24 89 74
 <6>note: logger[3942] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c01196c1>] schedule+0x3f1/0x3f6
 [<c013f9f6>] unmap_page_range+0x41/0x67
 [<c013fbd1>] unmap_vmas+0x1b5/0x216
 [<c01437da>] exit_mmap+0x7a/0x18d
 [<c010b920>] do_invalid_op+0x0/0xb7
 [<c011b0f2>] mmput+0x67/0xcf
 [<c011ee19>] do_exit+0x159/0x485
 [<c010b920>] do_invalid_op+0x0/0xb7
 [<c010b611>] do_divide_error+0x0/0xde
 [<c010b9d5>] do_invalid_op+0xb5/0xb7
 [<c011acc2>] remove_wait_queue+0x66/0x70
 [<c0117d92>] do_page_fault+0x27e/0x4bf
 [<c010b001>] error_code+0x2d/0x38
 [<c011acc2>] remove_wait_queue+0x66/0x70
 [<c019e462>] devfs_d_revalidate_wait+0x181/0x18d
 [<c0117b14>] do_page_fault+0x0/0x4bf
 [<c0119716>] default_wake_function+0x0/0x12
 [<c0119716>] default_wake_function+0x0/0x12
 [<c015add3>] do_lookup+0x5c/0x98
 [<c015b2c6>] link_path_walk+0x4b7/0x8fd
 [<c01350cd>] file_read_actor+0x0/0x11f
 [<c01350cd>] file_read_actor+0x0/0x11f
 [<c029d529>] unix_find_other+0x2e/0x158
 [<c029dac4>] unix_dgram_connect+0xfb/0x1a5
 [<c024a9ec>] sys_connect+0xa9/0xb1
 [<c024953d>] sock_map_fd+0x118/0x12e
 [<c024a586>] sys_socket+0x3a/0x56
 [<c024b50f>] sys_socketcall+0xb2/0x262
 [<c015ef49>] do_fcntl+0xd8/0x1a4
 [<c015f0fa>] sys_fcntl64+0x6f/0xab
 [<c010ae57>] syscall_call+0x7/0xb

and with modular USB I also get this along for free, right after:

usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -110
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -75
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -75
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -110
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -75
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -110
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -75
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -110
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -110
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -75
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110

.config is attached.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+sLyBCQ1pa+gRoggRAqPjAJoDxrfbRyPlEzUU0V14WzPhSmPXaQCfThba
/nN9EqynPWOUo+F3T8P6uBE=
=C+e/
-----END PGP SIGNATURE-----
