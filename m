Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBQPQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBQPQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWBQPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:16:08 -0500
Received: from relay1.udl.es ([193.144.10.29]:62187 "EHLO relay1.udl.es")
	by vger.kernel.org with ESMTP id S1750779AbWBQPQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:16:05 -0500
Subject: kernel BUG at fs/locks.c:1932!
From: Fermin Molina <fermin@asic.udl.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 17 Feb 2006 16:15:59 +0100
Message-Id: <1140189359.22719.51.camel@viagra.udl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I run samba sharing NFS mounted shares from another machine. I'm getting
the following bugs in console (and in logs), when I stop samba (but not
always, I think it depends of stalled locks):

lockd: unexpected unlock status: 7
lockd: unexpected unlock status: 7
lockd: unexpected unlock status: 7
------------[ cut here ]------------
kernel BUG at fs/locks.c:1932!
invalid operand: 0000 [#1]
SMP
last sysfs file: /class/vc/vcsa5/dev
Modules linked in: nfsd exportfs parport_pc lp parport nfs lockd nfs_acl sunrpc
video button battery ac i2c_piix4 i2c_core eepro100 cpqphp e1000 e100 mii floppy ext3 jbd dm_mod cciss sd_mod scsi_mod
CPU:    5
EIP:    0060:[<c017f12f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15-1.1831_FC4smp)
EIP is at locks_remove_flock+0xc5/0xe8
eax: cbaccc78   ebx: d49d4828   ecx: f7fff180   edx: 00000000
esi: d972a980   edi: d49d4760   ebp: cbaccc78   esp: e993ef08
ds: 007b   es: 007b   ss: 0068
Process smbd (pid: 25624, threadinfo=e993e000 task=f7e5a000)

Stack: 00000000 00000000 00000000 00000000 00000000 d972a980 00006418 00000000
       00000000 00000000 00000000 00000000 00000000 d972a980 00000202 00000000
       00000000 ffffffff 7fffffff 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<c016a5fe>] __fput+0x9a/0x186     [<c0168e71>] filp_close+0x3e/0x62
 [<c0104035>] syscall_call+0x7/0xb
Code: c0 74 0d 3b 70 34 74 15 89 c3 8b 03 85 c0 75 f3 e8 82 ca 1a 00 83 c4 68 5b 5e 5f 5d c3 0f b6 50 38 f6 c2 02 75 11 80 e2 20 75 15 <0f> 0b 8c 07 df ad 34 c0 89 c3 eb d3 89 d8 e8 0f df ff ff eb bd
Continuing in 1 seconds.

------------------------

Feb 16 16:02:06 users kernel: ------------[ cut here ]------------
Feb 16 16:02:06 users kernel: kernel BUG at fs/locks.c:1932!
Feb 16 16:02:06 users kernel: invalid operand: 0000 [#1]
Feb 16 16:02:06 users kernel: SMP
Feb 16 16:02:06 users kernel: last sysfs file: /block/dm-2/dev
Feb 16 16:02:06 users kernel: Modules linked in: nfsd exportfs parport_pc lp parport nfs lockd nfs_acl sunrpc video button battery ac i2c_piix4 i2c_core eepro100 cpqphp e1000 e100 mii floppy ext3 jbd dm_mod cciss sd_mod scsi_mod
Feb 16 16:02:06 users kernel: CPU:    5
Feb 16 16:02:06 users kernel: EIP:    0060:[<c017f12f>]    Not tainted VLI
Feb 16 16:02:06 users kernel: EFLAGS: 00010246   (2.6.15-1.1831_FC4smp)
Feb 16 16:02:06 users kernel: EIP is at locks_remove_flock+0xc5/0xe8
Feb 16 16:02:06 users kernel: eax: f2553ee8   ebx: e6ab9238   ecx: 00b6c507   edx: 00000000
Feb 16 16:02:06 users kernel: esi: ed840180   edi: e6ab9170   ebp: f2553ee8   esp: f60a8f08
Feb 16 16:02:06 users kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 16:02:06 users kernel: Process smbd (pid: 4846, threadinfo=f60a8000 task=f7cbd550)
Feb 16 16:02:06 users kernel: Stack: 00000000 00000000 00000000 00000000 00000000 ed840180 000012ee 00000000
Feb 16 16:02:07 users kernel:        00000000 00000000 00000000 00000000 00000000 ed840180 00000202 00000000
Feb 16 16:02:07 users kernel:        00000000 ffffffff 7fffffff 00000000 00000000 00000000 00000000 00000000
Feb 16 16:02:07 users kernel: Call Trace:
Feb 16 16:02:08 users kernel:  [<c016a5fe>] __fput+0x9a/0x186     [<c0168e71>] filp_close+0x3e/0x62
Feb 16 16:02:08 users kernel:  [<c0104035>] syscall_call+0x7/0xb
Feb 16 16:02:08 users kernel: Code: c0 74 0d 3b 70 34 74 15 89 c3 8b 03 85 c0 75 f3 e8 82 ca 1a 00 83 c4 68 5b 5e 5f 5d c3 0f b6 50 38 f6 c2 02 75 11 80 e2 20 75 15 <0f> 0b 8c 07 df ad 34 c0 89 c3 eb d3 89 d8 e8 0f df ff ff eb bd
Feb 16 16:02:08 users kernel: Continuing in 120 seconds.

------------------------

Feb 17 10:00:02 users nmbd[11718]: [2006/02/17 10:00:02, 0] nmbd/nmbd.c:terminate(58)
Feb 17 10:00:02 users nmbd[11718]:   Got SIGTERM: going down...
Feb 17 10:00:09 users kernel:  ------------[ cut here ]------------
Feb 17 10:00:09 users kernel: kernel BUG at fs/locks.c:1932!
Feb 17 10:00:09 users kernel: invalid operand: 0000 [#2]
Feb 17 10:00:09 users kernel: SMP
Feb 17 10:00:09 users kernel: last sysfs file: /block/dm-2/dev
Feb 17 10:00:09 users kernel: Modules linked in: nfsd exportfs parport_pc lp parport nfs lockd nfs_acl sunrpc video button battery ac i2c_piix4 i2c_core eepro100 cpqphp e1000 e100 mii floppy ext3 jbd dm_mod cciss sd_mod scsi_mod
Feb 17 10:00:09 users kernel: CPU:    0
Feb 17 10:00:09 users kernel: EIP:    0060:[<c017f12f>]    Not tainted VLI
Feb 17 10:00:09 users kernel: EFLAGS: 00010246   (2.6.15-1.1831_FC4smp)
Feb 17 10:00:09 users kernel: EIP is at locks_remove_flock+0xc5/0xe8
Feb 17 10:00:09 users kernel: eax: e7399a08   ebx: ea8b6e18   ecx: f7fff180   edx: 00000000
Feb 17 10:00:09 users kernel: esi: f7dd3e80   edi: ea8b6d50   ebp: e7399a08   esp: cf7c0f08
Feb 17 10:00:09 users kernel: ds: 007b   es: 007b   ss: 0068
Feb 17 10:00:09 users kernel: Process smbd (pid: 11799, threadinfo=cf7c0000 task=f7de7550)
Feb 17 10:00:09 users kernel: Stack: 00000000 00000000 00000000 00000000 00000000 f7dd3e80 00002e17 00000000
Feb 17 10:00:09 users kernel:        00000000 00000000 00000000 00000000 00000000 f7dd3e80 00000202 00000000
Feb 17 10:00:09 users kernel:        00000000 ffffffff 7fffffff 00000000 00000000 00000000 00000000 00000000
Feb 17 10:00:09 users kernel: Call Trace:
Feb 17 10:00:09 users kernel:  [<c016a5fe>] __fput+0x9a/0x186     [<c0168e71>] filp_close+0x3e/0x62
Feb 17 10:00:09 users kernel:  [<c0104035>] syscall_call+0x7/0xb
Feb 17 10:00:10 users kernel: Code: c0 74 0d 3b 70 34 74 15 89 c3 8b 03 85 c0 75 f3 e8 82 ca 1a 00 83 c4 68 5b 5e 5f 5d c3 0f b6 50 38 f6 c2 02 75 11 80 e2 20 75 15 <0f> 0b 8c 07 df ad 34 c0 89 c3 eb d3 89 d8 e8 0f df ff ff eb bd
Feb 17 10:00:10 users kernel: Continuing in 120 seconds.

------------------------

Feb 17 14:00:02 users nmbd[20963]: [2006/02/17 14:00:02, 0] nmbd/nmbd.c:terminate(58)
Feb 17 14:00:02 users nmbd[20963]:   Got SIGTERM: going down...
Feb 17 14:00:09 users kernel: ------------[ cut here ]------------
Feb 17 14:00:09 users kernel: kernel BUG at fs/locks.c:1932!
Feb 17 14:00:09 users kernel: invalid operand: 0000 [#3]
Feb 17 14:00:09 users kernel: SMP
Feb 17 14:00:09 users kernel: last sysfs file: /block/dm-2/dev
Feb 17 14:00:09 users kernel: Modules linked in: nfsd exportfs parport_pc lp parport nfs lockd nfs_acl sunrpc video button battery ac i2c_piix4 i2c_core eepro100 cpqphp e1000 e100 mii floppy ext3 jbd dm_mod cciss sd_mod scsi_mod
Feb 17 14:00:09 users kernel: CPU:    0
Feb 17 14:00:09 users kernel: EIP:    0060:[<c017f12f>]    Not tainted VLI
Feb 17 14:00:09 users kernel: EFLAGS: 00010246   (2.6.15-1.1831_FC4smp)
Feb 17 14:00:09 users kernel: EIP is at locks_remove_flock+0xc5/0xe8
Feb 17 14:00:09 users kernel: eax: e23d3798   ebx: f7936530   ecx: f7fff180   edx: 00000000
Feb 17 14:00:09 users kernel: esi: f7f06580   edi: f7936468   ebp: e23d3798   esp: edf05f08
Feb 17 14:00:09 users kernel: ds: 007b   es: 007b   ss: 0068
Feb 17 14:00:10 users kernel: Process smbd (pid: 21685, threadinfo=edf05000 task=ddc28550)
Feb 17 14:00:10 users rpc.mountd: authenticated unmount request from RECTOR128.udl.net:699 for /usuaris/users (/usuaris/users)
Feb 17 14:00:10 users kernel: Stack: 00000000 00000000 00000000 00000000 00000000 f7f06580 000054b5 00000000
Feb 17 14:00:10 users kernel:        00000000 00000000 00000000 00000000 00000000 f7f06580 00000202 00000000
Feb 17 14:00:10 users kernel:        00000000 ffffffff 7fffffff 00000000 00000000 00000000 00000000 00000000
Feb 17 14:00:10 users kernel: Call Trace:
Feb 17 14:00:10 users kernel:  [<c016a5fe>] __fput+0x9a/0x186     [<c0168e71>] filp_close+0x3e/0x62
Feb 17 14:00:11 users kernel:  [<c0104035>] syscall_call+0x7/0xb
Feb 17 14:00:11 users kernel: Code: c0 74 0d 3b 70 34 74 15 89 c3 8b 03 85 c0 75 f3 e8 82 ca 1a 00 83 c4 68 5b 5e 5f 5d c3 0f b6 50 38 f6 c2 02 75 11 80 e2 20 75 15 <0f> 0b 8c 07 df ad 34 c0 89 c3 eb d3 89 d8 e8 0f df ff ff eb bd
Feb 17 14:00:11 users kernel: Continuing in 120 seconds.

------------------------

I think this is a problem with file locking in NFS code, and samba
triggers this bug. In fact, all samba locking over NFS works very, very
bad and samba shares gets stalled constantly.

I read this http://lkml.org/lkml/2005/12/21/334 but kernel I use have
this patch applied (I use kernel 2.6.15.3). The client with samba is a
i386 based machine with SMP (4 processors); the NFS server is a Solaris
7.

Thanks in advance,

-- 
Fermin Molina Ibarz
Tècnic sistemes - ASIC
Universitat de Lleida
Tel: +34 973 702151
GPG: 0x060F857A


