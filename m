Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWJ2Vl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWJ2Vl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWJ2Vl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:41:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:16098 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030342AbWJ2Vlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:41:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=VPx6INFi72yQI3C12OmPHmLajp5D85/BKB7+NqhnugQfgMdZ6sWXWi4EidPVJHRdYMNdGJmUH2EaJv9u4D0Km+w/jE7+vVQsnG7Lawxv9whe5zcq9SPk7vNnRMDDCIB2UqvkLc2st6ipUnWDkdPw+eKQxhgp84mZT67pqiSHMZ4=
Message-ID: <76366b180610291341y7342a968ycd244753ce9bbbb7@mail.gmail.com>
Date: Sun, 29 Oct 2006 16:41:54 -0500
From: "Andrew Paprocki" <andrew@ishiboo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 git kernel reporting bug in knodemgrd_0 during boot
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: f1e426baba6d9054
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded my dev box to the latest 2.6 source via git and this
is now printing out in dmesg upon every boot. Hardware is a standard
VIA EPIA-MII motherboard w/ nothing extra added. I can supply
additional info if anyone requests it. -Andrew

Probing IDE interface ide0...
hda: HITACHI_DK23DA-40, ATA DISK drive
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0040635000015f17]
------------[ cut here ]------------
Kernel BUG at [verbose debug info unavailable]
invalid opcode: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<b014932e>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19-rc3-g2da6dc28 #1)
EIP is at cache_alloc_refill+0x18e/0x400
eax: 00000000   ebx: 0000003c   ecx: 00000000   edx: 00000000
esi: bdfed770   edi: bdfed760   ebp: bdfea000   esp: bd2bbe00
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 174, ti=bd2ba000 task=bdfa8ab0 task.ti=bd2ba000)
Stack: 000200d2 000000d2 bdfef0c0 bdfee1e0 0000003c 00000000 00000001 b03a61ec
       000000d2 b03a61ec bdfa8ab0 00000246 00001fff 000000d2 00000163 b0149192
       be800000 b0143085 bd2bbe7c 00000002 ffffffff 00000001 000000d2 ffffffff
Call Trace:
 [<b0149192>] kmem_cache_alloc+0x22/0x30
 [<b0143085>] __get_vm_area_node+0x95/0x160
 [<b0143187>] get_vm_area_node+0x37/0x40
 [<b014370c>] __vmalloc_node+0x3c/0x60
 [<b014375f>] __vmalloc+0xf/0x20
 [<b0269ced>] csr1212_attach_keyval_to
_directory+0x1d/0x60
 [<b026a52c>] csr1212_parse_keyval+0x14c/0x200
 [<b026a9be>] _csr1212_read_keyval+0x3de/0x420
 [<b0268185>] nodemgr_probe_ne+0x205/0x390
 [<b0179561>] sysfs_add_file+0x61/0x70
 [<b0268c3c>] nodemgr_host_thread+0x82c/0x980
 [<b0268410>] nodemgr_host_thread+0x0/0x980
 [<b0125a4f>] kthread+0xaf/0xe0
 [<b01259a0>] kthread+0x0/0xe0
 [<b0103d47>] kernel_thread_helper+0x7/0x10
 =======================
Code: 04 89 37 83 7c 24 10 00 0f 8f 5a ff ff ff 8b 47 18 2b 45 00 89
47 18 83 7d 00 00 0f 85 61 02 00 00 f7 44 24 04 0e 80 f8 ff 74 02 <0f>
0b f7 44 24 04 00 20 00 00 0f 85 2d 02 00 00 8b 5c 24 04 81
EIP: [<b014932e>] cache_alloc_refill+0x18e/0x400 SS:ESP 0068:bd2bbe00
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
