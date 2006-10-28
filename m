Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752225AbWJ1OQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbWJ1OQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbWJ1OQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:16:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:56418 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1752133AbWJ1OQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:16:56 -0400
Date: Sat, 28 Oct 2006 16:16:49 +0200 (MEST)
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: cd media poll stuck in D state, arch bug?
Message-ID: <20061028141650.GA20025@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The stacktrace below happens on 2.6.16 and 2.6.18.1.
I see it on IBM p630 with BLK_DEV_SL82C105 and on iBook1 and PowerBook
pismo BLK_DEV_IDE_PMAC. I think it happens when one actually
changes CD during an installation.

This command does never timeout. Why does the kernel not recover and
return -ETIMEDOUT to the app?
Unfortunately I dont have a testcase to trigger it reliable.


hald-addon-st D 000000000fe9b824  9456  3488   3409          4155 (NOTLB)
Call Trace:
[C0000000FDB3AD20] [C0000000FDB3ADD0] 0xc0000000fdb3add0 (unreliable)
[C0000000FDB3AEF0] [C00000000000F4FC] .__switch_to+0x12c/0x150
[C0000000FDB3AF80] [C000000000372AF8] .schedule+0xce8/0xe48
[C0000000FDB3B090] [C000000000372DF4] .wait_for_completion+0xe8/0x16c
[C0000000FDB3B180] [C00000000027ADEC] .ide_do_drive_cmd+0x120/0x19c
[C0000000FDB3B260] [D000000000316268] .cdrom_queue_packet_command+0x68/0x13c [ide_cd]
[C0000000FDB3B340] [D000000000316624] .cdrom_check_status+0x80/0xa0 [ide_cd]
[C0000000FDB3B500] [D000000000316678] .ide_cdrom_check_media_change_real+0x34/0x64 [ide_cd]
[C0000000FDB3B580] [D00000000032B0C4] .media_changed+0x80/0xdc [cdrom]
[C0000000FDB3B610] [D000000000316C34] .idecd_media_changed+0x18/0x2c [ide_cd]
[C0000000FDB3B690] [C0000000000D2270] .check_disk_change+0x54/0xec
[C0000000FDB3B720] [D000000000330BD0] .cdrom_open+0xb14/0xb80 [cdrom]
[C0000000FDB3B940] [D000000000316E80] .idecd_open+0x128/0x19c [ide_cd]
[C0000000FDB3B9E0] [C0000000000D2B2C] .do_open+0x3a0/0x5c4
[C0000000FDB3BAA0] [C0000000000D3018] .blkdev_open+0x38/0x88
[C0000000FDB3BB30] [C0000000000C4800] .__dentry_open+0x160/0x300
[C0000000FDB3BBE0] [C0000000000C4B14] .do_filp_open+0x50/0x70
[C0000000FDB3BD00] [C0000000000C4BA8] .do_sys_open+0x74/0x12c
[C0000000FDB3BDB0] [C000000000101568] .compat_sys_open+0x24/0x38
[C0000000FDB3BE30] [C00000000000871C] syscall_exit+0x0/0x40
