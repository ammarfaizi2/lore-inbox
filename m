Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTEZMtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 08:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTEZMtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 08:49:10 -0400
Received: from ws38.sron.nl ([131.211.41.138]:8368 "EHLO ws38.sron.nl")
	by vger.kernel.org with ESMTP id S264366AbTEZMtI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 08:49:08 -0400
Message-ID: <XFMail.20030526150219.R.M.van.Hees@sron.nl>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Mon, 26 May 2003 15:02:19 +0200 (CEST)
Organization: SRON
From: "Richard M. van Hees" <R.M.van.Hees@sron.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] tg3 crash during RAID5 hot-add (2.4.20 and 2.4.21-rc3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My 3COM996 NIC went repeatedly down during a hot-add of a disk to a software
RAID 5 configuration (4 HD on a RocketRAID 404, chipset: hpt374). I have tried
to recover my RAID system using the standard kernel source 2.4.20 & 2.4.21-rc2
(both with the buildin tg3 driver), and 2.4.21-rc3 (bcm5700-5.0.5 driver as
module). The NIC goes down after about 10 - 15 min, when someone tries to scp a
few large files (300 MB). My system is a P4 (2GHz), i850, Mem: 2 GB. System
software is installed on separate disk (not RAID system).

Thanks for any help...

Best regards, Richard van Hees

All I find in the kernel-log is:
May 26 12:14:56 sron0030 kernel: Broadcom Gigabit Ethernet Driver bcm5700 with
Broadcom NIC Extension (NICE) ver. 5.0.5 (09/24/02)
May 26 12:14:56 sron0030 kernel: PCI: Found IRQ 7 for device 02:0a.0
May 26 12:14:56 sron0030 kernel: eth0: 3Com 3C996 10/100/1000 Server NIC found
at mem feae0000, IRQ 7, node addr 0004763b5a20
May 26 12:14:56 sron0030 kernel: eth0: Broadcom BCM5401 Copper transceiver found
May 26 12:14:56 sron0030 kernel: eth0: Scatter-gather ON, 64-bit DMA ON, Tx
Checksum ON, Rx Checksum ON, 802.1Q VLAN ON
May 26 12:14:56 sron0030 kernel: bcm5700: eth0 NIC Link is UP, 1000 Mbps full
duplex
May 26 12:23:15 sron0030 kernel: md: trying to hot-add hdi1 to md0 ... 
May 26 12:23:15 sron0030 kernel: md: bind<hdi1,4>
May 26 12:23:15 sron0030 kernel: RAID5 conf printout:
May 26 12:23:15 sron0030 kernel:  --- rd:4 wd:3 fd:1
May 26 12:23:15 sron0030 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
May 26 12:23:15 sron0030 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
May 26 12:23:15 sron0030 kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev
00:00]
May 26 12:23:15 sron0030 kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
May 26 12:23:15 sron0030 kernel: RAID5 conf printout:
May 26 12:23:15 sron0030 kernel:  --- rd:4 wd:3 fd:1
May 26 12:23:15 sron0030 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
May 26 12:23:15 sron0030 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
May 26 12:23:15 sron0030 kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev
00:00]
May 26 12:23:15 sron0030 kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
May 26 12:23:15 sron0030 kernel: md: updating md0 RAID superblock on device
May 26 12:23:15 sron0030 kernel: md: hdi1 [events: 00000026]<6>(write) hdi1's
sb offset: 160079552
May 26 12:23:15 sron0030 kernel: md: hdk1 [events: 00000026]<6>(write) hdk1's
sb offset: 160079552
May 26 12:23:15 sron0030 kernel: md: hdg1 [events: 00000026]<6>(write) hdg1's
sb offset: 160079552
May 26 12:23:15 sron0030 kernel: md: hde1 [events: 00000026]<6>(write) hde1's
sb offset: 160079552
May 26 12:23:15 sron0030 kernel: md: recovery thread got woken up ...
May 26 12:23:15 sron0030 kernel: md0: resyncing spare disk hdi1 to replace
failed disk
May 26 12:23:15 sron0030 kernel: RAID5 conf printout:
May 26 12:23:15 sron0030 kernel:  --- rd:4 wd:3 fd:1
May 26 12:23:15 sron0030 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
May 26 12:23:15 sron0030 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
May 26 12:23:15 sron0030 kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev
00:00]
May 26 12:23:15 sron0030 kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
May 26 12:23:15 sron0030 kernel: RAID5 conf printout:
May 26 12:23:15 sron0030 kernel:  --- rd:4 wd:3 fd:1
May 26 12:23:15 sron0030 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
May 26 12:23:15 sron0030 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
May 26 12:23:15 sron0030 kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev
00:00]
May 26 12:23:15 sron0030 kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
May 26 12:23:15 sron0030 kernel: md: syncing RAID array md0
May 26 12:23:15 sron0030 kernel: md: minimum _guaranteed_ reconstruction speed:
100 KB/sec/disc.
May 26 12:23:15 sron0030 kernel: md: using maximum available idle IO bandwith
(but not more than 100000 KB/sec) for reconstruction.
May 26 12:23:15 sron0030 kernel: md: using 124k window, over a total of
160079552 blocks.
May 26 12:36:39 sron0030 kernel: nfs: server mars not responding, still trying
May 26 12:36:46 sron0030 kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 26 12:37:26 sron0030 kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 26 12:40:22 sron0030 kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 26 12:42:37 sron0030 kernel: RPC: sendmsg returned error 101
May 26 12:42:37 sron0030 kernel: nfs: RPC call returned error 101
May 26 12:42:37 sron0030 kernel: nfs_statfs: statfs error = 512



-- 
 e-mail:  Richard van Hees <R.M.van.Hees@sron.nl>
 date  :  26-May-2003 15:02:19
 phone :  +31-302535715
 fax   :  +31-302540860
 www   :  http://sron9864.sron.nl/~hees
