Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbULFXS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbULFXS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULFXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:17:36 -0500
Received: from main.gmane.org ([80.91.229.2]:47746 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261697AbULFXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:11:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: 2.6.10-rc[2|3] protection fault on /proc/devices
Date: Tue, 07 Dec 2004 00:11:11 +0100
Message-ID: <41B4E70F.8040306@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81.223.124.22
User-Agent: Mozilla Thunderbird 0.9 (X11/20041128)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.10-rc2 I am having problems accessing /proc/devices. On 
startup some init-skripts access this node and print out a protection 
fault. i am having this on pcmcia and swap startup. My system is an 
amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo. 
.config is the same as on 2.6.10-rc1 which works good. cat on 
/proc/devices gives the same problems. The kernel has just a patch for 
wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else 
is vanilla. Does anyone know of this issue and perhaps on how to solve this?

Regards

Georg Schild

> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda10, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda11, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> general protection fault: 0000 [1]
> CPU 0
> Modules linked in:
> Pid: 5693, comm: grep Not tainted 2.6.10-rc3
> RIP: 0010:[<ffffffff8028c5b5>] <ffffffff8028c5b5>{get_blkdev_list+85}
> RSP: 0018:000001001eec1e48  EFLAGS: 00010202
> RAX: 000000000000000c RBX: 6d736f2d636f7270 RCX: 0000000000000000
> RDX: ffffffff804332e2 RSI: fffffffffffffffe RDI: ffffffff804332e2
> RBP: 0000000000000048 R08: 00000000ffffffff R09: 0000000000000009
> R10: 00000000ffffffff R11: 0000000000000000 R12: 000001001f248139
> R13: 000000000000000b R14: 0000000000000c00 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805f71c0(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000002a95725f60 CR3: 0000000000101000 CR4: 00000000000006e0
> Process grep (pid: 5693, threadinfo 000001001eec0000, task 000001001e80f0b0)
> Stack: 0000000000000003 0000000000000139 000001001eec1ed8 000001001f248000
>        000001001eec1ed4 ffffffff80186903 000001001ec4be80 0000000000000000
>        000001001f248000 0000000000000c00
> Call Trace:<ffffffff80186903>{devices_read_proc+67} <ffffffff801841ba>{proc_file_read+234}
>        <ffffffff80158ac7>{vfs_read+199} <ffffffff80158d73>{sys_read+83}
>        <ffffffff8010e12a>{system_call+126}
> 
> Code: 8b 53 08 48 8d 4b 0c 48 63 fd 4c 01 e7 48 c7 c6 db 32 43 80
> RIP <ffffffff8028c5b5>{get_blkdev_list+85} RSP <000001001eec1e48>
>  <0>general protection fault: 0000 [2]
> CPU 0
> Modules linked in:
> Pid: 12088, comm: cardmgr Not tainted 2.6.10-rc3
> RIP: 0010:[<ffffffff8028c5b5>] <ffffffff8028c5b5>{get_blkdev_list+85}
> RSP: 0018:000001001ef97e48  EFLAGS: 00010202
> RAX: 000000000000000c RBX: 6d736f2d636f7270 RCX: 0000000000000000
> RDX: ffffffff804332e2 RSI: fffffffffffffffe RDI: ffffffff804332e2
> RBP: 0000000000000048 R08: 00000000ffffffff R09: 0000000000000009
> R10: 00000000ffffffff R11: 0000000000000000 R12: 000001001ea9f139
> R13: 000000000000000b R14: 0000000000000400 R15: 0000000000000000
> FS:  0000000000519ae0(0000) GS:ffffffff805f71c0(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000002a956cb5c0 CR3: 0000000000101000 CR4: 00000000000006e0
> Process cardmgr (pid: 12088, threadinfo 000001001ef96000, task 000001001f2ac910)
> Stack: 0000000000100073 0000000000000139 000001001ef97ed8 000001001ea9f000
>        000001001ef97ed4 ffffffff80186903 000001001e12f480 0000000000000000
>        000001001ea9f000 0000000000000400
> Call Trace:<ffffffff80186903>{devices_read_proc+67} <ffffffff801841ba>{proc_file_read+234}
>        <ffffffff80158ac7>{vfs_read+199} <ffffffff80158d73>{sys_read+83}
>        <ffffffff8010e12a>{system_call+126}
> 
> Code: 8b 53 08 48 8d 4b 0c 48 63 fd 4c 01 e7 48 c7 c6 db 32 43 80
> RIP <ffffffff8028c5b5>{get_blkdev_list+85} RSP <000001001ef97e48>
>  <6>tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is on for TX and on for RX.

