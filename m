Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUGNOZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUGNOZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUGNOXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:23:11 -0400
Received: from tristate.vision.ee ([194.204.30.144]:45450 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S267423AbUGNOW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:22:26 -0400
Message-ID: <40F541AE.5010902@vision.ee>
Date: Wed, 14 Jul 2004 17:22:38 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com>
In-Reply-To: <20040713122805.GZ21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

More violations found.

This time during NFS umount/mount. Since (u)mounting is not always
the operation that is only done at boot-time (at least in my case), I 
thought I report.

umount /nfs/dir
16ms non-preemptible critical section violated 2 ms preempt threshold 
starting at truncate_inode_pages+0x9d/0x280 and ending at 
generic_shutdown_super+0xd0/0x190
 [<c0153340>] generic_shutdown_super+0xd0/0x190
 [<c0117d30>] dec_preempt_count+0x110/0x120
 [<c0153340>] generic_shutdown_super+0xd0/0x190
 [<c0117c70>] dec_preempt_count+0x50/0x120
 [<c0153cf9>] kill_anon_super+0x9/0x40
 [<f935884c>] nfs_kill_super+0xc/0x20 [nfs]
 [<c015317c>] deactivate_super+0x6c/0x90
 [<c016809b>] sys_umount+0x3b/0x90
 [<c0164a85>] destroy_inode+0x35/0x40
 [<c014e645>] __fput+0xb5/0x120
 [<c0168107>] sys_oldumount+0x17/0x20
 [<c0103ee1>] sysenter_past_esp+0x52/0x71

mount /nfs/dir
nfs warning: mount version older than kernel
15ms non-preemptible critical section violated 2 ms preempt threshold 
starting at sys_mount+0x78/0x110 and ending at schedule+0x237/0x480
 [<c0279677>] schedule+0x237/0x480
 [<c0117d30>] dec_preempt_count+0x110/0x120
 [<c0279677>] schedule+0x237/0x480
 [<c0127c21>] worker_thread+0x1d1/0x240
 [<c0127c72>] worker_thread+0x222/0x240
 [<c01166f8>] activate_task+0x68/0x80
 [<c0219800>] fb_flashcursor+0x0/0x80
 [<c0116d60>] default_wake_function+0x0/0x10
 [<c0279677>] schedule+0x237/0x480
 [<c0116d60>] default_wake_function+0x0/0x10
 [<c0127a50>] worker_thread+0x0/0x240
 [<c012b2c4>] kthread+0x94/0xa0
 [<c012b230>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

umount /nfs/dir
19ms non-preemptible critical section violated 2 ms preempt threshold 
starting at generic_shutdown_super+0x69/0x190 and ending at 
generic_shutdown_super+0xd0/0x190
 [<c0153340>] generic_shutdown_super+0xd0/0x190
 [<c0117d30>] dec_preempt_count+0x110/0x120
 [<c0153340>] generic_shutdown_super+0xd0/0x190
 [<c0117c70>] dec_preempt_count+0x50/0x120
 [<c0153cf9>] kill_anon_super+0x9/0x40
 [<f935884c>] nfs_kill_super+0xc/0x20 [nfs]
 [<c015317c>] deactivate_super+0x6c/0x90
 [<c016809b>] sys_umount+0x3b/0x90
 [<c0164a85>] destroy_inode+0x35/0x40
 [<c014e645>] __fput+0xb5/0x120
 [<c0168107>] sys_oldumount+0x17/0x20
 [<c0103ee1>] sysenter_past_esp+0x52/0x71

Lenar


