Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJLWBV>; Sat, 12 Oct 2002 18:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJLWBV>; Sat, 12 Oct 2002 18:01:21 -0400
Received: from toq5-srv.bellnexxia.net ([209.226.175.27]:29429 "EHLO
	toq5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261365AbSJLWBT>; Sat, 12 Oct 2002 18:01:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.41+ shutdown problems
Date: Fri, 11 Oct 2002 08:40:37 -0400
User-Agent: KMail/1.4.3
References: <3DA683F4.944DFC11@digeo.com>
In-Reply-To: <3DA683F4.944DFC11@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210110840.37464.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All version of 2.5.41-mm and 2.5.41-bk are giving me an oops like the
following during shutdown:

Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces... done.
Deactivating swap... done.
Unmounting local filesystems... done.
raidtools2 init script failed; RAID drivers not available.
Rebooting...  printing eip:
c015e0fe
*pde = 00000000
Oops: 0002
isofs ide-cd af_packet gameport softdog matroxfb_base matroxfb_g450 matroxfb_DAC1064 g450_pll matroxfb_acc
el fbcon-cfb16 fbcon-cfb8 fbcon-cfb24 fbcon-cfb32 matroxfb_misc mga agpgart pppoe pppox ipchains msdos fat
 sd_mod floppy dummy bsd_comp ppp_generic slhc parport_pc lp parport ipip smbfs nls_cp850 nls_cp437 nfs lo
ckd sunrpc binfmt_aout autofs4 cdrom via-rhine mii tulip crc32 scsi_mod
CPU:    0
EIP:    0060:[<c015e0fe>]    Not tainted
EFLAGS: 00010246
EIP is at driverfs_remove_file+0x22/0x80
eax: 00000001   ebx: 00000000   ecx: 0000005c   edx: 00000001
esi: 0000005c   edi: c1796ef0   ebp: 00000001   esp: dcf25e18
ds: 0068   es: 0068   ss: 0068
Process reboot (pid: 30446, threadinfo=dcf24000 task=d0467920)
Stack: c0226736 0000007e c1796e50 00000000 c1796e00 c0196369 c1796ef0 c0226581
       c1796e50 c1796e50 c015ca35 c1796e50 c025d25c c1796e00 c1796e00 00000001
       c015cf93 c1796e00 c03701ec c01bce06 c1796e00 c03701ec 00000001 c01ba4d5
Call Trace:
 [<c0196369>] device_remove_file+0x21/0x2c
 [<c015ca35>] driverfs_remove_partitions+0x71/0x94
 [<c015cf93>] del_gendisk+0xb/0x3c
 [<c01bce06>] idedisk_cleanup+0x5e/0x70
 [<c01ba4d5>] ide_notify_reboot+0x8d/0xb8
 [<c011d76a>] notifier_call_chain+0x1e/0x38
 [<c011dc0e>] sys_reboot+0xd2/0x2a4
 [<c012435d>] do_no_page+0x219/0x288
 [<c012444c>] handle_mm_fault+0x80/0x120
 [<c01db98b>] sock_destroy_inode+0x13/0x70
 [<c014bdc2>] destroy_inode+0x3a/0x64
 [<c014ca1f>] generic_forget_inode+0xf7/0x100
 [<c014ca46>] generic_drop_inode+0x1e/0x24
 [<c014caad>] iput+0x61/0x68
 [<c014a5b6>] dput+0x1a/0x1b8
 [<c01393d6>] __fput+0xba/0xdc
 [<c013931b>] fput+0x13/0x14
 [<c0137c65>] filp_close+0x99/0xa4
 [<c0137cc8>] sys_close+0x58/0x80
 [<c0106ef7>] syscall_call+0x7/0xb

Code: ff 4b 5c 0f 88 a3 01 00 00 83 c4 08 ff 74 24 14 ff 77 04 e8
 /etc/rc6.d/S90reboot: line 11: 30446 Segmentation fault      reboot -d -f -i
Give root password for maintenance
(or type Control-D for normal startup):

Ideas?
Ed Tomlinson
