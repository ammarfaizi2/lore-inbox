Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265743AbRFXMHQ>; Sun, 24 Jun 2001 08:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbRFXMHG>; Sun, 24 Jun 2001 08:07:06 -0400
Received: from ACaen-101-2-1-162.abo.wanadoo.fr ([193.251.7.162]:21494 "EHLO
	serianet.com") by vger.kernel.org with ESMTP id <S265743AbRFXMGz>;
	Sun, 24 Jun 2001 08:06:55 -0400
X-Spam-Filter: check_local@serianet.com by digitalanswers.org
Date: Sun, 24 Jun 2001 14:06:47 +0200 (CEST)
From: Xavier ROCHE <roche@serianet.com>
To: linux-kernel@vger.kernel.org
Subject: bad block locks IDE on 2.2.18?
Message-ID: <Pine.LNX.4.10.10106241358510.21802-100000@gate.serianet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a bad drive, with many bad blocks, as many other people have.
But my problem is not bad blocks, but system crash when detecting one of
these bad blocks.

The drive is hdb(1), an ide 3.8gb disk. The kernel used is a regular
2.2.18 kernel. I didn't see any hints on the kernel ChangeLog, so
I'm posting here.

When I try to run "e2fsck -f -c -v /dev/hdb1" or even "badblocks -b 4096
-s /dev/hdb1 938448", I get many "end_request: I/O error" errors (this is
perfectly normal, ad the drive is really bad)

But unfortunalely, at approx. sector 7459480, the system just hangs
without any syslog message.
It seems that the bad block reached just crashed the IDE subsystem (!),
even if the kernel is still running (I can ping the machine, I can type
the ENTER key in the console with an echo, until I launch a systemcommand,
which hangs the console. All IDE I/O seems frozen.)

Jun 25 11:46:26 linux kernel: end_request: I/O error, dev 03:41 (hdb),
sector 7459440
Jun 25 11:46:26 linux kernel: hdb: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jun 25 11:46:29 linux kernel: hdb: read_intr: error=0x40 {
UncorrectableError }, LBAsect=7491696, sector=7459440
Jun 25 11:46:31 linux kernel: end_request: I/O error, dev 03:41 (hdb),
sector 7459440
Jun 25 11:46:32 linux kernel: hdb: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jun 25 11:46:32 linux kernel: hdb: read_intr: error=0x40 {
UncorrectableError }, LBAsect=7491736, sector=7459480
Jun 25 11:46:33 linux kernel: end_request: I/O error, dev 03:41 (hdb),
sector 7459480
Jun 25 11:46:38 linux kernel: hdb: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jun 25 11:46:39 linux kernel: hdb: read_intr: error=0x40 {
UncorrectableError }, LBAsect=7491736, sector=7459480

And of course, I have to reboot (power off/on)
Jun 25 11:59:42 linux syslogd 1.3-3: restart.

I know that the drive is bad, and can not be repaired, and I only use it
as "garbage store". 
But the strange thing here is that once the bad block has been reached on
this drive, the 3 other IDE drives are unreachable, "frozen"


Model: QUANTUM FIREBALL_TM3840A
Geometry: physical 7480/16/63, logical 935/128/63
Capacity: 7539840 (3.8Gb)
Details on settings:
bios_cyl                935             0               65535           rw
bios_head               128             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
file_readahead          124             0               2097151         rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
multcount               0               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw


-- 
Xavier Roche


