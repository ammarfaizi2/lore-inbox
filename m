Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbULNSOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbULNSOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULNSNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:13:48 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:47598 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261604AbULNSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:10:53 -0500
Message-ID: <41BF2C89.9000800@mtg-marinetechnik.de>
Date: Tue, 14 Dec 2004 19:10:17 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Feedback <feedback@suse.de>,
       Hubert Mantel <mantel@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: kernel BUG at fs/lockd/host.c:275!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This is a SuSE 9.2 system + all available updates.
Kernel is SuSE's kernel-smp-2.6.8-24.5.
System is dual Pentium III (Coppermine) 1.0 Ghz, 1.0 GB RAM.

I found the following "kernel bug" at fs/lockd/host.c:275! already 3 times in /var/log/messages.
It appeared always while rebooting the system.
Using NFS + autofs4 (still being a pain ... SuSE: Wouldn't it be better to update to autofs-4.1.3 ???)


Dec 10 17:38:52 jupiter xinetd[4055]: Exiting...
Dec 10 17:38:52 jupiter kernel: nfsd: last server has exited
Dec 10 17:38:52 jupiter kernel: nfsd: unexporting all filesystems
Dec 10 17:38:53 jupiter rpc.mountd: Caught signal 15, un-registering and exiting.
Dec 10 17:38:53 jupiter kernel: lockd: host still in use after nlmsvc_free_host_resources!------------[ cut here ]------------
Dec 10 17:38:53 jupiter kernel: kernel BUG at fs/lockd/host.c:275!
Dec 10 17:38:53 jupiter kernel: invalid operand: 0000 [#1]
Dec 10 17:38:53 jupiter kernel: SMP
Dec 10 17:38:53 jupiter kernel: Modules linked in: autofs4 nfsd exportfs speedstep_lib freq_table processor af_packet ipv6 edd joydev sg st sr_mod ide
Dec 10 17:38:53 jupiter kernel: CPU:    0
Dec 10 17:38:53 jupiter kernel: EIP:    0060:[<c01cc403>]    Not tainted VLI
Dec 10 17:38:53 jupiter kernel: EFLAGS: 00010286   (2.6.8-24.5-smp SL92_BRANCH-20041117111006)
Dec 10 17:38:53 jupiter kernel: EIP is at nlm_release_host+0x23/0x50
Dec 10 17:38:53 jupiter kernel: eax: ffffffff   ebx: f61de360   ecx: f61c1fc8   edx: 00000296
Dec 10 17:38:53 jupiter kernel: esi: f61c0000   edi: cdfe5c00   ebp: cde09d60   esp: f61c1fb4
Dec 10 17:38:53 jupiter kernel: ds: 007b   es: 007b   ss: 0068
Dec 10 17:38:53 jupiter kernel: Process lockd (pid: 3856, threadinfo=f61c0000 task=f7a56270)
Dec 10 17:38:53 jupiter kernel: Stack: c0123c17 c0369cf8 f61de360 c01cfb28 c0369cf8 00000000 c01ccb9f c037bcee
Dec 10 17:38:53 jupiter kernel:        00000000 fffe518e 00000000 c01cc940 00000000 00000000 00000000 c01052b9
Dec 10 17:38:53 jupiter kernel:        cdfe5c00 00000000 00000000
Dec 10 17:38:53 jupiter kernel: Call Trace:
Dec 10 17:38:53 jupiter kernel:  [<c0123c17>] printk+0x17/0x20
Dec 10 17:38:53 jupiter kernel:  [<c01cfb28>] nlmsvc_invalidate_all+0x38/0x46
Dec 10 17:38:53 jupiter kernel:  [<c01ccb9f>] lockd+0x25f/0x280
Dec 10 17:38:53 jupiter kernel:  [<c01cc940>] lockd+0x0/0x280
Dec 10 17:38:53 jupiter kernel:  [<c01052b9>] kernel_thread_helper+0x5/0xc
Dec 10 17:38:53 jupiter kernel: Code: 04 e8 22 78 f5 ff eb c3 53 83 ec 08 85 c0 89 c3 74 14 80 3d 7c ad 4b c0 00 78 1a f0 ff 4b 50 8b 43 50 85 c0 78 0
Dec 10 17:38:54 jupiter kernel:  <4>lockd_down: lockd failed to exit, clearing pid
Dec 10 17:38:54 jupiter automount[7135]: expired /net/diablo
Dec 10 17:38:54 jupiter automount[10246]: shutting down, path = /net
Dec 10 17:38:56 jupiter ypbind[3781]: Unknown signal: 0
Dec 10 17:38:56 jupiter sshd[3800]: Received signal 15; terminating.



Dec 14 09:41:45 jupiter xinetd[4052]: Exiting...
Dec 14 09:41:45 jupiter kernel: nfsd: last server has exited
Dec 14 09:41:45 jupiter kernel: nfsd: unexporting all filesystems
Dec 14 09:41:45 jupiter rpc.mountd: Caught signal 15, un-registering and exiting.
Dec 14 09:41:46 jupiter kernel: lockd: host still in use after nlmsvc_free_host_resources!------------[ cut here ]------------
Dec 14 09:41:46 jupiter kernel: kernel BUG at fs/lockd/host.c:275!
Dec 14 09:41:46 jupiter kernel: invalid operand: 0000 [#1]
Dec 14 09:41:46 jupiter kernel: SMP
Dec 14 09:41:46 jupiter kernel: Modules linked in: nfsd exportfs autofs4 af_packet edd joydev sg e100 mii st sr_mod dl2k ide_cd cdrom ohci_hcd subfs s
Dec 14 09:41:46 jupiter kernel: CPU:    0
Dec 14 09:41:46 jupiter kernel: EIP:    0060:[<c01cc403>]    Not tainted VLI
Dec 14 09:41:46 jupiter kernel: EFLAGS: 00010286   (2.6.8-24.5-smp SL92_BRANCH-20041117111006)
Dec 14 09:41:46 jupiter kernel: EIP is at nlm_release_host+0x23/0x50
Dec 14 09:41:46 jupiter kernel: eax: ffffffff   ebx: f7b6e960   ecx: f60c9fc8   edx: 00000296
Dec 14 09:41:46 jupiter kernel: esi: f60c8000   edi: c19f7400   ebp: cde06e20   esp: f60c9fb4
Dec 14 09:41:46 jupiter kernel: ds: 007b   es: 007b   ss: 0068
Dec 14 09:41:46 jupiter kernel: Process lockd (pid: 3921, threadinfo=f60c8000 task=f7a76cb0)
Dec 14 09:41:46 jupiter kernel: Stack: c0123c17 c0369cf8 f7b6e960 c01cfb28 c0369cf8 00000000 c01ccb9f c037bcee
Dec 14 09:41:46 jupiter kernel:        00000000 fffd7adb 00000000 c01cc940 00000000 00000000 00000000 c01052b9
Dec 14 09:41:46 jupiter kernel:        c19f7400 00000000 00000000
Dec 14 09:41:46 jupiter kernel: Call Trace:
Dec 14 09:41:46 jupiter kernel:  [<c0123c17>] printk+0x17/0x20
Dec 14 09:41:46 jupiter kernel:  [<c01cfb28>] nlmsvc_invalidate_all+0x38/0x46
Dec 14 09:41:46 jupiter kernel:  [<c01ccb9f>] lockd+0x25f/0x280
Dec 14 09:41:46 jupiter kernel:  [<c01cc940>] lockd+0x0/0x280
Dec 14 09:41:46 jupiter kernel:  [<c01052b9>] kernel_thread_helper+0x5/0xc
Dec 14 09:41:46 jupiter kernel: Code: 04 e8 22 78 f5 ff eb c3 53 83 ec 08 85 c0 89 c3 74 14 80 3d 7c ad 4b c0 00 78 1a f0 ff 4b 50 8b 43 50 85 c0 78 0
Dec 14 09:41:47 jupiter kernel:  <4>lockd_down: lockd failed to exit, clearing pid
Dec 14 09:41:47 jupiter automount[29802]: expired /net/diablo
Dec 14 09:41:47 jupiter automount[3894]: shutting down, path = /net
Dec 14 09:41:48 jupiter ypbind[3778]: Unknown signal: 0
Dec 14 09:41:48 jupiter sshd[3795]: Received signal 15; terminating.
Dec 14 09:41:55 jupiter kernel: Kernel logging (proc) stopped.
Dec 14 09:41:55 jupiter kernel: Kernel log daemon terminating.


Dec 14 18:32:22 jupiter init: Switching to runlevel: 6
Dec 14 18:32:23 jupiter kernel: bootsplash: status on console 0 changed to on
Dec 14 18:32:23 jupiter xinetd[4061]: Exiting...
Dec 14 18:32:24 jupiter kernel: lockd: host still in use after nlmsvc_free_host_resources!------------[ cut here ]------------
Dec 14 18:32:24 jupiter kernel: kernel BUG at fs/lockd/host.c:275!
Dec 14 18:32:24 jupiter kernel: invalid operand: 0000 [#1]
Dec 14 18:32:24 jupiter kernel: SMP
Dec 14 18:32:24 jupiter kernel: Modules linked in: vfat fat udf nfsd exportfs autofs4 af_packet edd e100 dl2k mii joydev sg st sr_mod ide_cd cdrom sub
Dec 14 18:32:24 jupiter kernel: CPU:    0
Dec 14 18:32:24 jupiter kernel: EIP:    0060:[<c01cc403>]    Not tainted VLI
Dec 14 18:32:24 jupiter kernel: EFLAGS: 00010286   (2.6.8-24.5-smp SL92_BRANCH-20041117111006)
Dec 14 18:32:24 jupiter kernel: EIP is at nlm_release_host+0x23/0x50
Dec 14 18:32:24 jupiter kernel: eax: ffffffff   ebx: c1aec2e0   ecx: f5393fc8   edx: 00000296
Dec 14 18:32:24 jupiter kernel: esi: f5392000   edi: cde2a800   ebp: cde09120   esp: f5393fb4
Dec 14 18:32:24 jupiter kernel: ds: 007b   es: 007b   ss: 0068
Dec 14 18:32:24 jupiter kernel: Process lockd (pid: 3926, threadinfo=f5392000 task=f77f8710)
Dec 14 18:32:24 jupiter kernel: Stack: c0123c17 c0369cf8 c1aec2e0 c01cfb28 c0369cf8 00000000 c01ccb9f c037bcee
Dec 14 18:32:24 jupiter automount[3901]: attempting to mount entry /net/*
Dec 14 18:32:24 jupiter kernel:        00000000 fffdab6d 00000000 c01cc940 00000000 00000000 00000000 c01052b9
Dec 14 18:32:24 jupiter kernel:        cde2a800 00000000 00000000
Dec 14 18:32:24 jupiter kernel: Call Trace:
Dec 14 18:32:24 jupiter kernel:  [<c0123c17>] printk+0x17/0x20
Dec 14 18:32:24 jupiter kernel:  [<c01cfb28>] nlmsvc_invalidate_all+0x38/0x46
Dec 14 18:32:24 jupiter kernel:  [<c01ccb9f>] lockd+0x25f/0x280
Dec 14 18:32:24 jupiter kernel:  [<c01cc940>] lockd+0x0/0x280
Dec 14 18:32:24 jupiter kernel:  [<c01052b9>] kernel_thread_helper+0x5/0xc
Dec 14 18:32:24 jupiter kernel: Code: 04 e8 22 78 f5 ff eb c3 53 83 ec 08 85 c0 89 c3 74 14 80 3d 7c ad 4b c0 00 78 1a f0 ff 4b 50 8b 43 50 85 c0 78 0
Dec 14 18:32:24 jupiter automount[21002]: >> /usr/lib/autofs/showmount: only one hostname is allowed
Dec 14 18:32:24 jupiter automount[21002]: lookup(program): lookup for * failed
Dec 14 18:32:25 jupiter kernel:  <4>lockd_down: lockd failed to exit, clearing pid
Dec 14 18:32:25 jupiter kernel: nfsd: last server has exited
Dec 14 18:32:25 jupiter kernel: nfsd: unexporting all filesystems
Dec 14 18:32:25 jupiter rpc.mountd: Caught signal 15, un-registering and exiting.
Dec 14 18:32:26 jupiter automount[3901]: shutting down, path = /net
Dec 14 18:32:27 jupiter sshd[3799]: Received signal 15; terminating.
Dec 14 18:32:27 jupiter ypbind[3777]: Unknown signal: 0
Dec 14 18:32:27 jupiter kernel: Kernel logging (proc) stopped.
Dec 14 18:32:27 jupiter kernel: Kernel log daemon terminating.


Many thanks, Richard

-- 
Richard Ems

MTG Marinetechnik GmbH
Wandsbeker Königstr. 62
22041 Hamburg
Telefon: +49 40 65803 312
TeleFax: +49 40 65803 392
mail: richard.ems@mtg-marinetechnik.de

