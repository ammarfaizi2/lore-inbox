Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756298AbWKRNhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298AbWKRNhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbWKRNhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:37:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:56570 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1756298AbWKRNg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:36:59 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
Date: Sat, 18 Nov 2006 14:36:43 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181436.43607.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During my I/O load test, after about half an hour of heavy I/O on three SATAII 
disks the system suddenly hung for about 3 seconds. After that I checked 
dmesg and found the following error output:

[ 4574.193809] ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 
0x1501000 status 0x400
[ 4574.193826] ata2: CPB 0: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193835] ata2: CPB 1: ctl_flags 0x1f, resp_flags 0x2
[ 4574.193843] ata2: CPB 2: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193851] ata2: CPB 3: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193859] ata2: CPB 4: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193867] ata2: CPB 5: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193876] ata2: CPB 6: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193885] ata2: CPB 7: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193893] ata2: CPB 8: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193901] ata2: CPB 9: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193909] ata2: CPB 10: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193917] ata2: CPB 11: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193926] ata2: CPB 12: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193934] ata2: CPB 13: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193942] ata2: CPB 14: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193950] ata2: CPB 15: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193958] ata2: CPB 16: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193966] ata2: CPB 17: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193974] ata2: CPB 18: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193983] ata2: CPB 19: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193991] ata2: CPB 20: ctl_flags 0x1f, resp_flags 0x1
[ 4574.193999] ata2: CPB 21: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194007] ata2: CPB 22: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194047] ata2: CPB 23: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194087] ata2: CPB 24: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194127] ata2: CPB 25: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194167] ata2: CPB 26: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194207] ata2: CPB 27: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194247] ata2: CPB 28: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194287] ata2: CPB 29: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194326] ata2: CPB 30: ctl_flags 0x1f, resp_flags 0x1
[ 4574.194366] ata2: Resetting port
[ 4574.194411] ata2.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 
frozen
[ 4574.194453] ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
[ 4574.497608] ata2: soft resetting port
[ 4574.649516] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 4574.676949] ata2.00: configured for UDMA/133
[ 4574.676975] ata2: EH complete
[ 4574.676187] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[ 4574.677182] sdb: Write Protect is off
[ 4574.677187] sdb: Mode Sense: 00 3a 00 00
[ 4574.679180] SCSI device sdb: drive cache: write back

The system continues to run without further problems so far.

-Christian
