Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSHPKNZ>; Fri, 16 Aug 2002 06:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSHPKNZ>; Fri, 16 Aug 2002 06:13:25 -0400
Received: from rzcomm5.rz.tu-bs.de ([134.169.9.40]:18437 "EHLO
	rzcomm5.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id <S318283AbSHPKNY>; Fri, 16 Aug 2002 06:13:24 -0400
Date: Fri, 16 Aug 2002 12:17:19 +0200
From: Torsten Wolf <t.wolf@tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18/9 problem with support for via82cxxx
Message-ID: <20020816121719.A3287@b147.apm.etc.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: TU Braunschweig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my system runs on an Epox 8KHA+ Via KT266A (VT8366/A + VT8233) with 4
IDE devices: hda, hdb and hdc are harddrives, hdd is a Teac CD-W512E.
All devices are at least UDMA2 capable and DMA is turned on via hdparm.
Writing to a CD works fine with cdrecord and ide-scsi-emulation. But
whenever I access hdc, cdrecord stops with

[...]
Track 01:   0 of 630 MB written.cdrecord: Input/output error. write_g1:
scsi sendcmd: no error
CDB:  2A 00 00 00 01 36 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.029s timeout 40s

write track data: error after 634880 bytes
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00

and

hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command

in /var/log/messages. This happens under 2.4.18 and 2.4.19 if
CONFIG_BLK_DEV_VIA82CXXX is set. Without support for the chipset
everything works fine and transfer rates of 30MB/s to/from hdc while
burning with nearly no load are possible. Why does the support for the
chipset make so much problems?

Regards,
Torsten
