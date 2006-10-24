Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWJXP4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWJXP4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWJXP4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:56:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:63236 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965164AbWJXP4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:56:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ts573PqIHY+y0B+mYdaIO/SJypV3NKr4rBlUb3+k8Azs4rkDxwrbwiAaHIFQAnRv2SuNHJQjclUtVWSdVsu1vG01V0/1eDtGlgol0WwkTyl23l7hBjRFAsIYJ+GmEkzkP3HiUGpVPBQ15lQ2f8GGU1Ch0lqxpq8qy938PvGUK2k=
Message-ID: <9f916e540610240856p263d5s7098e4e2edd0ed25@mail.gmail.com>
Date: Wed, 25 Oct 2006 01:56:37 +1000
From: "Michael Sallaway" <michael.sallaway@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops when doing disk heavy disk I/O
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Kernel Oopses when doing I/O to a disk (using dd).

[2.] Full description of the problem/report:
When writing to [any] disk (IDE or SCSI), the kernel will Oops after
short periods of time ranging from 30 seconds to 5-10 minutes.
Sometimes this is a complete crash (with "Aieee, killing interrupt
handler!"), sometimes it's just an oops but the system doesn't crash
comepletely (isn't very usable, though), and sometimes it just gives a
"general protection fault: 0000 [1] SMP".

It's worth mentioning that I've managed to set up the entire system
without incident -- a debian netinstall, downloading new packages,
changing things, etc. The only reason I discovered this was when
copying large amounts of data off another machine, and it died
reproducably after a few gigabytes of data. (I originally thought it
was an XFS issue, but had the same problem with EXT3, and all other
combinations I tried - I can now reproduce it by using dd if=/dev/zero
of=/dev/hda6.)

Ultimately, I've tried it with different (known good) devices and hard
drives. The only common things between all failures are the CPU
(Athlon 64 3200), Motherboard (Asus M2N-E), and RAM (2GB DDR2-533).
(Memtest x86 shows the memory to be fine.) As such, I'm suspecting
it's something to do with the motherboard -- It's using an x86_64
kernel (although it does the same with an i386), on an nforce 570
motherboard.

Other things I have tried:
- SATA, SCSI and IDE drives -- all do the same thing
- removing *all* drives and cards and devices -- it does it with a
single IDE drive connected and no PCI cards
- kernels 2.6.16, 18, 18.1, 19-rc3.
- the patch suggested in
http://marc.theaimsgroup.com/?l=linux-kernel&m=115545986619977&w=2
- booting with noapic and/or acpi=off (as suggested http://tinyurl.com/yn97woby)
- with and without md devices


[3.] Keywords (i.e., modules, networking, kernel):
kernel disk I/O nforce

[4.] Kernel version (from /proc/version):
Linux version 2.6.19-rc3 (root@barbossa) (gcc version 4.1.2 20061007
(prerelease) (Debian 4.1.1-16)) #1 SMP Tue Oct 24 22:23:07 EST 2006

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)
(as I understand it from Documentation/oops-tracing.txt, ksymoops
doesn't apply anymore? If that's not the case, I apologise -- could
someone tell me what I need to do with the below?)

Oct 25 00:23:11 barbossa kernel: Unable to handle kernel NULL pointer
dereference at 0000000000000000 RIP:
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8021a6c5>]
__block_write_full_page+0xa4/0x2df
Oct 25 00:23:11 barbossa kernel: PGD 2b93a067 PUD 7c7cc067 PMD 0
Oct 25 00:23:11 barbossa kernel: Oops: 0000 [1] SMP
Oct 25 00:23:11 barbossa kernel: CPU 0
Oct 25 00:23:11 barbossa kernel: Modules linked in:
Oct 25 00:23:11 barbossa kernel: Pid: 2442, comm: dd Not tainted 2.6.19-rc3 #1
Oct 25 00:23:11 barbossa kernel: RIP: 0010:[<ffffffff8021a6c5>]
[<ffffffff8021a6c5>] __block_write_full_page+0xa4/0x2df
Oct 25 00:23:11 barbossa kernel: RSP: 0018:ffff81003fa358f8  EFLAGS: 00010283
Oct 25 00:23:11 barbossa kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000002
Oct 25 00:23:11 barbossa kernel: RDX: 000000000000000a RSI:
000000000019eea9 RDI: ffff810037cc8440
Oct 25 00:23:11 barbossa kernel: RBP: ffff810001602550 R08:
ffff810037cc8440 R09: ffff81003fa35b48
Oct 25 00:23:11 barbossa kernel: R10: ffffffff802bee4c R11:
ffffffff80440b8b R12: ffff81001b3426e0
Oct 25 00:23:11 barbossa kernel: R13: 000000000067baa6 R14:
ffff810037cc8440 R15: 0000000001c42574
Oct 25 00:23:11 barbossa kernel: FS:  00002b64b70eb6d0(0000)
GS:ffffffff807d6000(0000) knlGS:0000000000000000
Oct 25 00:23:11 barbossa kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Oct 25 00:23:11 barbossa kernel: CR2: 0000000000000000 CR3:
000000007b6b7000 CR4: 00000000000006e0
Oct 25 00:23:11 barbossa kernel: Process dd (pid: 2442, threadinfo
ffff81003fa34000, task ffff810037e44140)
Oct 25 00:23:11 barbossa kernel: Stack:  ffff81003fa35b48
ffffffff802bee4c 0000040001602550 ffff810001602550
Oct 25 00:23:11 barbossa kernel:  ffff81003fa35b48 ffff810037cc8550
000000000000000b ffff81007efe9b08
Oct 25 00:23:11 barbossa kernel:  0000000000000000 ffffffff8029db1e
000000000000000e ffffffff802bdff3
Oct 25 00:23:11 barbossa kernel: Call Trace:
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802bee4c>] blkdev_get_block+0x0/0x46
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8029db1e>]
generic_writepages+0x18e/0x2d8
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802bdff3>] blkdev_writepage+0x0/0xf
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8025591f>] do_writepages+0x20/0x2d
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8022cf8c>]
__writeback_single_inode+0x1b4/0x38b
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8021f44f>]
sync_sb_inodes+0x1d1/0x2b5
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8024b3b7>]
writeback_inodes+0x82/0xd8
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8029de51>]
balance_dirty_pages_ratelimited_nr+0x115/0x1f6
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8020f4b1>]
generic_file_buffered_write+0x516/0x64b
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802295b6>] remove_suid+0x1/0x1c
Oct 25 00:23:11 barbossa kernel:  [<ffffffff80215018>]
__generic_file_aio_write_nolock+0x375/0x3e8
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802078bb>] unmap_vmas+0x372/0x716
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8029bdea>]
generic_file_aio_write_nolock+0x3a/0x86
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802166a9>] do_sync_write+0xc9/0x10c
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802899a3>]
autoremove_wake_function+0x0/0x2e
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8022c1e9>] __clear_user+0x12/0x50
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8048c584>] read_zero+0x1d1/0x23c
Oct 25 00:23:11 barbossa kernel:  [<ffffffff802153ee>] vfs_write+0xce/0x174
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8020afee>] fget_light+0x18/0x7c
Oct 25 00:23:11 barbossa kernel:  [<ffffffff80215d2f>] sys_write+0x45/0x6e
Oct 25 00:23:11 barbossa kernel:  [<ffffffff8025811e>] system_call+0x7e/0x83
Oct 25 00:23:11 barbossa kernel:
Oct 25 00:23:11 barbossa kernel:
Oct 25 00:23:11 barbossa kernel: Code: 8b 03 a8 20 75 6c 8b 03 a8 02
74 66 8b 44 24 14 48 39 43 20
Oct 25 00:23:11 barbossa kernel: RIP  [<ffffffff8021a6c5>]
__block_write_full_page+0xa4/0x2df
Oct 25 00:23:11 barbossa kernel:  RSP <ffff81003fa358f8>
Oct 25 00:23:11 barbossa kernel: CR2: 0000000000000000


[6.] A small shell script or example program which triggers the
problem (if possible)
dd if=/dev/zero of=/dev/hda6 bs=512K

(note that it will also happen without the bs argument, however
usually takes longer. It's not related to a particular point in the
disk, or anything, though, just seems to last longer.)


[7.] Environment

Please see the below output for more environment information -- I
didn't want to dump too much info in here. :-)

http://sallaway.org/lkml/output.txt

also, I've seen mention of this, but I'm not sure if it would be useful:

http://sallaway.org/lkml/System.map-2.6.19-rc3


Please let me know if you need any more info. This is my first bug
report, so apologies if this should have gone elsewhere. :-)

Cheers,
Michael
