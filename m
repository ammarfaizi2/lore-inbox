Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265268AbRF0UZg>; Wed, 27 Jun 2001 16:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0UZ0>; Wed, 27 Jun 2001 16:25:26 -0400
Received: from umail.unify.com ([204.163.170.2]:41891 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S265180AbRF0UZR>;
	Wed, 27 Jun 2001 16:25:17 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C326@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Oops at boot with 2.4.5
Date: Wed, 27 Jun 2001 13:25:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I use an initrd, sometimes when warm-booting I get an "Unable to handle
kernel NULL pointer dereference"  OOPS just after the "Trying to unmount old
root ..." message. I ran gdb on vmlinux and got the following stack trace:

0xc0180516 <rd_ioctl+118>:      mov    0x10(%eax),%eax
0xc0137c37 <ioctl_by_bdev+135>: mov    %edi,0xc(%ebx)
0xc01861a0 <start_request+384>: add    $0xc,%esp
0xc01864d3 <ide_do_request+659>:        mov    %eax,%ebx
0xc0112949 <schedule+617>:      pop    %ebp
0xc0132be1 <__refile_buffer+97>:        pop    %ecx
0xc018047a <rd_make_request+266>:       xor    %eax,%eax
0xc01347eb <try_to_free_buffers+267>:   mov    $0x1,%eax
0xc0133062 <block_flushpage+114>:       test   %eax,%eax
0xc0123905 <truncate_list_pages+357>:   mov    $0x1,%eax
0xc01431af <destroy_inode+47>:  pop    %eax
0xc01447b0 <iput+320>:  pop    %ecx
0xc0137e46 <blkdev_put+118>:    add    $0xc,%esp
0xc0135edc <kill_super+236>:    add    $0xc,%esp
0xc0105000 <do_linuxrc>:        push   %edi
0xc0117ba3 <sys_waitpid+19>:    add    $0x10,%esp
0xc0105000 <do_linuxrc>:        push   %edi
0xc01051e8 <prepare_namespace+264>:     pop    %edx
0xc010520e <init+14>:   call   0xc0111a60 <free_initmem>
0xc0105000 <do_linuxrc>:        push   %edi
0xc01056c6 <kernel_thread+38>:  mov    $0x1,%eax
0xc0105200 <init>:      push   %ebp

A reset at this point usually (but not always) succeeds in booting, and once
the machine succeeds in booting it is completely stable (for my admittedly
low load).

Hardware is an Athlon Tbird 900MHz (not overclocked) on an MSI K7T Turbo-R
motherboard. I've worked around this by building my SCSI driver into the
kernel and removing the need for an initrd.

Kernel is official 2.4.5 built with Athlon optimizations.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Zathras is used to being beast of burden to other peoples needs. Very sad
life. Probably have very sad death, but at least there is symmetry.
 



