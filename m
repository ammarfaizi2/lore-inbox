Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFAHhE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 03:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTFAHhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 03:37:04 -0400
Received: from pusa.informat.uv.es ([147.156.10.98]:1768 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S261568AbTFAHhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 03:37:01 -0400
Date: Sun, 1 Jun 2003 09:50:21 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030601075021.GA3042@pusa.informat.uv.es>
References: <20030530130230.GD813@suse.de> <878ysopmus.fsf@gitteundmarkus.de> <874r3cpmmv.fsf@gitteundmarkus.de> <20030530145845.GI813@suse.de> <87u1bcs789.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87u1bcs789.fsf@gitteundmarkus.de>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I tested 2.5.70 with scsi-ioctl-2 patch

It works fine until It has to read the last sectors.
I get the following messages from readcd, using different CD-Rs

agapito:~# readcd dev=/dev/hdc f=/dev/null
Read  speed:  8450 kB/s (CD  48x, DVD  6x).
Write speed:  7056 kB/s (CD  40x, DVD  5x).
Capacity: 353137 Blocks = 706274 kBytes = 689 MBytes = 723 prMB
Sectorsize: 2048 Bytes
Copy from SCSI (0,0,0) disk to file '/dev/null'
end:    353137
readcd: Success. read_g1: scsi sendcmd: no error
CDB:  28 00 00 05 63 5B 00 00 16 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 64 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x64 Qual 0x00 (illegal mode for this track) Fru 0x0
Sense flags: Blk 0 (not valid)
resid: 45056
cmd finished after 3.267s timeout 40s
readcd: Success. Cannot read source disk
readcd: Retrying from sector 353115.
.....................~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~
readcd: Success. Error on sector 353135 not corrected. Total of 1 errors.

Time total: 1094.406sec
Read 706230.00 kB at 645.3 kB/sec.

agapito:~# readcd dev=/dev/hdc f=/dev/null
Read  speed:  8450 kB/s (CD  48x, DVD  6x).
Write speed:  7056 kB/s (CD  40x, DVD  5x).
Capacity: 355841 Blocks = 711682 kBytes = 695 MBytes = 728 prMB
Sectorsize: 2048 Bytes
Copy from SCSI (0,0,0) disk to file '/dev/null'
end:    355841
readcd: Success. read_g1: scsi sendcmd: no error
CDB:  28 00 00 05 6D F0 00 00 11 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 64 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x64 Qual 0x00 (illegal mode for this track) Fru 0x0
Sense flags: Blk 0 (not valid)
resid: 34816
cmd finished after 2.965s timeout 40s
readcd: Success. Cannot read source disk
readcd: Retrying from sector 355824.
................~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~+~~~-~~~
readcd: Success. Error on sector 355839 not corrected. Total of 1 errors.

Time total: 1058.468sec
Read 711648.00 kB at 672.3 kB/sec.

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

dmesg shows several
hdc: confused, missing data
and then (sometimes)
cdrom_newpc_intr: 2048 residual after xfer
for each run of readcd

readcd version comes from

ulisses@agapito:~$ dpkg -l | grep cdrecord
ii  cdrecord       2.0+a14-1      A command line CD writing tool


the CDR/W recorder is not the best thing on this world...
agapito:~# cdrecord dev=/dev/hdc -checkdrive
Cdrecord 2.01a14 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'Polaroid'
Identifikation : 'BurnMAX48       '
Revision       : '482E'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R

Can I do anything else?

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
