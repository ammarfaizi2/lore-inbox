Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUKOTSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUKOTSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUKOTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:18:55 -0500
Received: from mail.aknet.ru ([217.67.122.194]:13066 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261351AbUKOTSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:18:51 -0500
Message-ID: <41990138.7080008@aknet.ru>
Date: Mon, 15 Nov 2004 22:19:20 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5 (and ide-cd)
Content-Type: multipart/mixed;
 boundary="------------030007080001060601020107"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007080001060601020107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

There seem to be the grave bug in that
kernel. When either process is trying
to access the cdrom, it gets stuck in
the kernel forever. Even "eject" locks
up. This started to happen somewhere
around -mm4 I think. Specifying
"pci=routeirq" makes the kernel to
deadlock at boot, right after detecting
the cdrom. Sometimes there are the
"ide1: lost interrupt" messages on console.
Attached are the different bits of info
I found usefull for that report. It
includes the Alt-PrtSc-t trace and the
random info about my cdrom.
Any suggestions on getting this fixed?
This one is really severe I suppose.

--------------030007080001060601020107
Content-Type: text/plain;
 name="trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trace"

Nov 15 14:21:38 stas kernel: eject         D C046C148  2500  3426   3363                     (NOTLB)
Nov 15 14:21:38 stas kernel: db4c8cc4 00000086 c046c0b8 c046c148 db4c8dd0 db4c8ca4 c0290e9c c0290c90 
Nov 15 14:21:38 stas kernel:        00001388 dfce797c c046c0b8 df778028 c046c148 00000000 db4c8cb4 c1405f60 
Nov 15 14:21:38 stas kernel:        00068a1b 5a045780 000f420a df9a3c10 db4c8d48 db4c8d44 db4c8000 db4c8d18 
Nov 15 14:21:38 stas kernel: Call Trace:
Nov 15 14:21:38 stas kernel:  [<c031cee4>] wait_for_completion+0x94/0x100
Nov 15 14:21:38 stas kernel:  [<c0285698>] ide_do_drive_cmd+0x118/0x150
Nov 15 14:21:38 stas kernel:  [<c0291b44>] cdrom_queue_packet_command+0x44/0xb0
Nov 15 14:21:38 stas kernel:  [<c02926a4>] cdrom_check_status+0x74/0x90
Nov 15 14:21:39 stas kernel:  [<c029359d>] ide_cdrom_check_media_change_real+0x1d/0x40
Nov 15 14:21:39 stas kernel:  [<c029616a>] media_changed+0x5a/0x90
Nov 15 14:21:39 stas kernel:  [<c016a902>] check_disk_change+0x32/0x80
Nov 15 14:21:39 stas kernel:  [<c02956db>] cdrom_open+0x6b/0x100
Nov 15 14:21:39 stas kernel:  [<c02944fd>] idecd_open+0x5d/0x80
Nov 15 14:21:39 stas kernel:  [<c016aad8>] do_open+0xe8/0x370
Nov 15 14:21:39 stas kernel:  [<c016ae18>] blkdev_open+0x28/0x60
Nov 15 14:21:39 stas kernel:  [<c0161a66>] dentry_open+0x156/0x280
Nov 15 14:21:39 stas kernel:  [<c016190d>] filp_open+0x4d/0x50
Nov 15 14:21:39 stas kernel:  [<c0161d4c>] sys_open+0x3c/0xa0
Nov 15 14:21:39 stas kernel:  [<c0105175>] sysenter_past_esp+0x52/0x71

--------------030007080001060601020107
Content-Type: text/plain;
 name="driver"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driver"

ide-cdrom version 4.61

--------------030007080001060601020107
Content-Type: text/plain;
 name="model"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="model"

ASUS CD-S500/A

--------------030007080001060601020107
Content-Type: text/plain;
 name="piix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piix"


Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no 
UDMA enabled:   yes              no              yes               no 
UDMA enabled:   5                X               2                 X
UDMA
DMA
PIO

--------------030007080001060601020107--
