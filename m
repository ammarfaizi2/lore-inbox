Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVJYQ2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVJYQ2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJYQ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:28:38 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:54127 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932202AbVJYQ2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:28:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KAJzJld1kIQiPh8q9eAJivIWhywKOf4FMaQr9mnDXuFaSkHH3XOPVeVTjIWcdOjnL8KwmzXkM0ubL/78LgRUwWeVJvglB6erY4953lp4C3C0BAHHNQ0z+tM7kgHcxj7z9iQAbgcNuuoAK4sdiLg6rkrmUWEKhrOsPdZGUncA3h8=
Subject: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer()
From: Badari Pulavarty <pbadari@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 09:28:02 -0700
Message-Id: <1130257682.6831.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my EM64T machine, X gets killed every time due to
following GFP. Happens on mainline & -mm kernels.
Hasn't annoyed me enough to take a look on why ?

Known issue ?

Thanks,
Badari


general protection fault: 0000 [1] SMP
CPU 0
Modules linked in: radeon parport_pc lp parport autofs4 sunrpc dm_mirror
dm_mod ipv6 uhci_hcd ehci_hcd hw_random i2c_i801 i2c_core floppy
Pid: 3668, comm: X Not tainted 2.6.14-rc5 #6
RIP: 0010:[<ffffffff880f98a7>]
<ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311}
RSP: 0018:ffff81011c9edd68  EFLAGS: 00010203
RAX: ffff81011bf7c000 RBX: ffff81011d566c00 RCX: ffffc20000104e00
RDX: 0000000000000000 RSI: ffff81011cd6b580 RDI: 000ffffc20000104
RBP: ffff81011cd09000 R08: 0000000006524000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81011d566c00
R13: ffff81011c9eddb8 R14: ffffffff880fa000 R15: 0000000040786440
FS:  00002aaaaaacb920(0000) GS:ffffffff805b0800(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006fea48 CR3: 000000011c998000 CR4: 00000000000006e0
Process X (pid: 3668, threadinfo ffff81011c9ec000, task
ffff81011cc651c0)
Stack: ffff81011cd09000 0000000000000001 ffff81011cd09000
ffffffff880fad58
       0000000000009f60 ffffffff8016027f 0000000000704d40
000000000000002c
       ffff81011c827018 ffff81011c9ede08
Call Trace:<ffffffff880fad58>{:radeon:radeon_cp_init+3416}
<ffffffff8016027f>{generic_file_aio_write+143}
       <ffffffff880fa000>{:radeon:radeon_cp_init+0}
<ffffffff802736f5>{drm_ioctl+405}
       <ffffffff80197f34>{do_ioctl+116} <ffffffff80198212>{vfs_ioctl
+690}
       <ffffffff80183908>{vfs_write+344} <ffffffff801982aa>{sys_ioctl
+106}
       <ffffffff8010dc26>{system_call+126}

Code: 48 8b 14 f8 48 8b 83 30 01 00 00 48 8b 40 18 89 90 0c 07 00
RIP <ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311} RSP
<ffff81011c9edd68>
 <3>[drm:drm_release] *ERROR* Device busy: 1 0
mtrr: type mismatch for f0000000,1000000 old: write-back new: write-
combining
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-
combining
iounmap: bad address ffffc20000373000
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-
combining
general protection fault: 0000 [2] SMP
CPU 1
Modules linked in: radeon parport_pc lp parport autofs4 sunrpc dm_mirror
dm_mod ipv6 uhci_hcd ehci_hcd hw_random i2c_i801 i2c_core floppy
Pid: 3958, comm: X Not tainted 2.6.14-rc5 #6
RIP: 0010:[<ffffffff880f98a7>]
<ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311}
RSP: 0018:ffff81012610fd68  EFLAGS: 00010203
RAX: ffff81011bf7c000 RBX: ffff81011d566c00 RCX: ffffc20000104e00
RDX: 0000000000000000 RSI: ffff81011cd6b480 RDI: 000ffffc20000104
RBP: ffff81011cd09000 R08: 0000000006d2c000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81011d566c00
R13: ffff81012610fdb8 R14: ffffffff880fa000 R15: 0000000040786440
FS:  00002aaaaaacb920(0000) GS:ffffffff805b0880(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000471153 CR3: 0000000125fbd000 CR4: 00000000000006e0
Process X (pid: 3958, threadinfo ffff81012610e000, task
ffff810037d558c0)
Stack: ffff81011cd09000 0000000000000001 ffff81011cd09000
ffffffff880fad58
       0000000000009e6b ffffffff8016027f 0000000000704d40
000000000000002c
       0000000000000292 ffff81012610fe08
Call Trace:<ffffffff880fad58>{:radeon:radeon_cp_init+3416}
<ffffffff8016027f>{generic_file_aio_write+143}
       <ffffffff880fa000>{:radeon:radeon_cp_init+0}
<ffffffff802736f5>{drm_ioctl+405}
       <ffffffff80197f34>{do_ioctl+116} <ffffffff80198212>{vfs_ioctl
+690}
       <ffffffff80183908>{vfs_write+344} <ffffffff801982aa>{sys_ioctl
+106}
       <ffffffff8010dc26>{system_call+126}

Code: 48 8b 14 f8 48 8b 83 30 01 00 00 48 8b 40 18 89 90 0c 07 00
RIP <ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311} RSP
<ffff81012610fd68>
 <3>[drm:drm_release] *ERROR* Device busy: 1 0
mtrr: type mismatch for f0000000,1000000 old: write-back new: write-
combining
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-
combining
iounmap: bad address ffffc20000373000
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-
combining
general protection fault: 0000 [3] SMP
CPU 0
Modules linked in: radeon parport_pc lp parport autofs4 sunrpc dm_mirror
dm_mod ipv6 uhci_hcd ehci_hcd hw_random i2c_i801 i2c_core floppy
Pid: 4108, comm: X Not tainted 2.6.14-rc5 #6
RIP: 0010:[<ffffffff880f98a7>]
<ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311}
RSP: 0018:ffff810123e11d68  EFLAGS: 00010203
RAX: ffff81011bf7c000 RBX: ffff81011d566c00 RCX: ffffc20000104e00
RDX: 0000000000000000 RSI: ffff81011cd6b3c0 RDI: 000ffffc20000104
RBP: ffff81011cd09000 R08: 0000000007534000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81011d566c00
R13: ffff810123e11db8 R14: ffffffff880fa000 R15: 0000000040786440
FS:  00002aaaaaacb920(0000) GS:ffffffff805b0800(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000471153 CR3: 0000000126dbc000 CR4: 00000000000006e0
Process X (pid: 4108, threadinfo ffff810123e10000, task
ffff81011ca45880)
Stack: ffff81011cd09000 0000000000000001 ffff81011cd09000
ffffffff880fad58
       0000000000009e6b ffffffff8016027f 0000000000704d40
000000000000002c
       0000000000000292 ffff810123e11e08
Call Trace:<ffffffff880fad58>{:radeon:radeon_cp_init+3416}
<ffffffff8016027f>{generic_file_aio_write+143}
       <ffffffff880fa000>{:radeon:radeon_cp_init+0}
<ffffffff802736f5>{drm_ioctl+405}
       <ffffffff80197f34>{do_ioctl+116} <ffffffff80198212>{vfs_ioctl
+690}
       <ffffffff80183908>{vfs_write+344} <ffffffff801982aa>{sys_ioctl
+106}
       <ffffffff8010dc26>{system_call+126}

Code: 48 8b 14 f8 48 8b 83 30 01 00 00 48 8b 40 18 89 90 0c 07 00
RIP <ffffffff880f98a7>{:radeon:radeon_cp_init_ring_buffer+311} RSP
<ffff810123e11d68>
 <3>[drm:drm_release] *ERROR* Device busy: 1 0


