Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJPTdd>; Wed, 16 Oct 2002 15:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSJPTdd>; Wed, 16 Oct 2002 15:33:33 -0400
Received: from mail.3ware.com ([205.253.146.92]:31762 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S261187AbSJPTdc>; Wed, 16 Oct 2002 15:33:32 -0400
Message-ID: <A1964EDB64C8094DA12D2271C04B812672C79B@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: 2.5.43 aic7xxx segfault sd_synchronize_cache() called after SHT->
	release()
Date: Wed, 16 Oct 2002 12:41:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think sd_synchronize_cache() is getting called after SHT->release()
function,
which couldn't possibly be right.  This causes adaptec, 3ware, etc, to
segfault
on rmmod.

See below for adaptec segfault output:

aic7xxx
CPU:    1
EIP:    0060:[<c025918b>]    Not tainted
EFLAGS: 00010202
EIP is at put_device+0x7b/0xa0
eax: 00000000   ebx: c8997028   ecx: 00000001   edx: c0465470
esi: c12f4174   edi: c8997000   ebp: 00000000   esp: c5b81ee4
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 1085, threadinfo=c5b80000 task=c5d4a800)
Stack: c8997028 c0481e20 c02d0f3a c8997028 c8997028 c0481f3c c8997028
c0481f4c
       00000000 c66fe1e8 00000286 c798aa00 c0481e20 c12f4000 c13b5000
c02be9aa
       c12f4000 c5b81f30 00000002 00030002 00000002 08072009 c042399f
08071fff
Call Trace:
 [<c02d0f3a>] sg_detach+0x20a/0x240
 [<c02be9aa>] scsi_unregister_host+0x26a/0x5f0
 [<c01418d8>] __alloc_pages+0x88/0x270
 [<c892f12a>] exit_this_scsi_driver+0xa/0xc [aic7xxx]
 [<c893a740>] driver_template+0x0/0x70 [aic7xxx]
 [<c012029e>] free_module+0x1e/0x140
 [<c011f3db>] sys_delete_module+0x1db/0x4c0
 [<c010787f>] syscall_call+0x7/0xb

Code: 0f 0b 0d 01 86 69 3d c0 8b 83 d4 00 00 00 85 c0 74 04 53 ff
 Segmentation fault
[root@localhost boot]#

--
Adam Radford
Software Engineer
3ware, Inc.
