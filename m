Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUH0T1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUH0T1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUH0T1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:27:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:57019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266684AbUH0TU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:20:28 -0400
X-Authenticated: #494916
Message-ID: <412F8996.4020300@gmx.de>
Date: Fri, 27 Aug 2004 21:20:54 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
Reply-To: peter.schaefer@gmx.de
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [libata - SII3112] 'Virtual' bad blocks?
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using an Epox EP-8HDA3+ Athlon64 Motherboard with
VIA K8T800 chipset as a file server running 24/7.

The box is running since 2.6.1 and was a long time rock
solid on 2.6.4. Problems with the VIA RHINE ethernet let
me switch to 2.6.7 and now 2.6.8.

The board has four on-board SATA ports, two provided by
the chipset and two provided by a Silicon Image 3112 chip.
I'm running a RAID5 array with three disks - two on the
chipset and one on the Silicon Image controller.

For the chipset ports the standard VIA IDE driver is used
(with SATA support). For the SI disk i'm using the libata
driver.

Unfortunately it's exactly this disk which give me headache
now (it started with 2.6.7) - see logs below.

I might add that those errors aren't really bad blocks -
after each occurence i made a full sector scan with
Western Digital's MS-DOS-based "Data Live Guard" which
revealed no errors. However, i had to plug the disk to
one of the VIA ports for the tests (otherwise the tool
didn't detect the disk).

Another thing to add is that i have activated CPU
frequency scaling with powernowd in about the same
timeframe (to use Cool&Quiet during times of no activity).
But i doubt that's the reason for this?!

Do i have to worry (and yes, i know that SATA is dirt
cheap crap)?

*Please CC me, because i'm not subscribed to the list*

Thanks and best regards,

   Peter

--- SNIP - This is with Kernel 2.6.7

Aug 17 15:00:12 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 03 00 00 38 00
Aug 17 15:00:12 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:12 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:12 bunny kernel: end_request: I/O error, dev sda, sector 4265987
Aug 17 15:00:13 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 04 00 00 37 00
Aug 17 15:00:13 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:13 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:13 bunny kernel: end_request: I/O error, dev sda, sector 4265988
Aug 17 15:00:15 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 05 00 00 36 00
Aug 17 15:00:15 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:15 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:15 bunny kernel: end_request: I/O error, dev sda, sector 4265989
Aug 17 15:00:16 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 06 00 00 35 00
Aug 17 15:00:16 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:16 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:16 bunny kernel: end_request: I/O error, dev sda, sector 4265990
Aug 17 15:00:18 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 07 00 00 34 00
Aug 17 15:00:18 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:18 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:18 bunny kernel: end_request: I/O error, dev sda, sector 4265991
Aug 17 15:00:19 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 08 00 00 33 00
Aug 17 15:00:19 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:19 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:19 bunny kernel: end_request: I/O error, dev sda, sector 4265992
Aug 17 15:00:20 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 09 00 00 32 00
Aug 17 15:00:20 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:20 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:20 bunny kernel: end_request: I/O error, dev sda, sector 4265993
Aug 17 15:00:22 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0a 00 00 31 00
Aug 17 15:00:22 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:22 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:22 bunny kernel: end_request: I/O error, dev sda, sector 4265994
Aug 17 15:00:24 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0b 00 00 30 00
Aug 17 15:00:24 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:24 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:24 bunny kernel: end_request: I/O error, dev sda, sector 4265995
Aug 17 15:00:25 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0c 00 00 2f 00
Aug 17 15:00:25 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:25 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:25 bunny kernel: end_request: I/O error, dev sda, sector 4265996
Aug 17 15:00:27 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0d 00 00 2e 00
Aug 17 15:00:27 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:27 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:27 bunny kernel: end_request: I/O error, dev sda, sector 4265997
Aug 17 15:00:29 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0e 00 00 2d 00
Aug 17 15:00:29 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:29 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:29 bunny kernel: end_request: I/O error, dev sda, sector 4265998
Aug 17 15:00:31 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 0f 00 00 2c 00
Aug 17 15:00:31 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:31 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:31 bunny kernel: end_request: I/O error, dev sda, sector 4265999
Aug 17 15:00:33 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 10 00 00 2b 00
Aug 17 15:00:33 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:33 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:33 bunny kernel: end_request: I/O error, dev sda, sector 4266000
Aug 17 15:00:35 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 11 00 00 2a 00
Aug 17 15:00:35 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:35 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:35 bunny kernel: end_request: I/O error, dev sda, sector 4266001
Aug 17 15:00:38 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 12 00 00 29 00
Aug 17 15:00:38 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:38 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:38 bunny kernel: end_request: I/O error, dev sda, sector 4266002
Aug 17 15:00:40 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 13 00 00 28 00
Aug 17 15:00:40 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:40 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:40 bunny kernel: end_request: I/O error, dev sda, sector 4266003
Aug 17 15:00:42 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 14 00 00 27 00
Aug 17 15:00:42 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:42 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:42 bunny kernel: end_request: I/O error, dev sda, sector 4266004
Aug 17 15:00:45 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 15 00 00 26 00
Aug 17 15:00:45 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:45 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:45 bunny kernel: end_request: I/O error, dev sda, sector 4266005
Aug 17 15:00:48 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 16 00 00 25 00
Aug 17 15:00:48 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:48 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:48 bunny kernel: end_request: I/O error, dev sda, sector 4266006
Aug 17 15:00:51 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 17 00 00 24 00
Aug 17 15:00:51 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:51 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:51 bunny kernel: end_request: I/O error, dev sda, sector 4266007
Aug 17 15:00:59 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 18 00 00 23 00
Aug 17 15:00:59 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:00:59 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:00:59 bunny kernel: end_request: I/O error, dev sda, sector 4266008
Aug 17 15:01:09 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 19 00 00 22 00
Aug 17 15:01:09 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:09 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:09 bunny kernel: end_request: I/O error, dev sda, sector 4266009
Aug 17 15:01:13 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1a 00 00 21 00
Aug 17 15:01:13 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:13 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:13 bunny kernel: end_request: I/O error, dev sda, sector 4266010
Aug 17 15:01:15 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1b 00 00 20 00
Aug 17 15:01:15 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:15 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:15 bunny kernel: end_request: I/O error, dev sda, sector 4266011
Aug 17 15:01:16 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1c 00 00 1f 00
Aug 17 15:01:16 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:16 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:16 bunny kernel: end_request: I/O error, dev sda, sector 4266012
Aug 17 15:01:18 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1d 00 00 1e 00
Aug 17 15:01:18 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:18 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:18 bunny kernel: end_request: I/O error, dev sda, sector 4266013
Aug 17 15:01:19 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1e 00 00 1d 00
Aug 17 15:01:19 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:19 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:19 bunny kernel: end_request: I/O error, dev sda, sector 4266014
Aug 17 15:01:20 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 1f 00 00 1c 00
Aug 17 15:01:20 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:20 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:20 bunny kernel: end_request: I/O error, dev sda, sector 4266015
Aug 17 15:01:22 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 20 00 00 1b 00
Aug 17 15:01:22 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:22 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:22 bunny kernel: end_request: I/O error, dev sda, sector 4266016
Aug 17 15:01:23 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 21 00 00 1a 00
Aug 17 15:01:23 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:23 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:23 bunny kernel: end_request: I/O error, dev sda, sector 4266017
Aug 17 15:01:24 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 22 00 00 19 00
Aug 17 15:01:24 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:24 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:24 bunny kernel: end_request: I/O error, dev sda, sector 4266018
Aug 17 15:01:26 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 23 00 00 18 00
Aug 17 15:01:26 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:26 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:26 bunny kernel: end_request: I/O error, dev sda, sector 4266019
Aug 17 15:01:27 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 24 00 00 17 00
Aug 17 15:01:27 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:27 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:27 bunny kernel: end_request: I/O error, dev sda, sector 4266020
Aug 17 15:01:28 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 25 00 00 16 00
Aug 17 15:01:28 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:28 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:28 bunny kernel: end_request: I/O error, dev sda, sector 4266021
Aug 17 15:01:30 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 26 00 00 15 00
Aug 17 15:01:30 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:30 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:30 bunny kernel: end_request: I/O error, dev sda, sector 4266022
Aug 17 15:01:31 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 27 00 00 14 00
Aug 17 15:01:31 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:31 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:31 bunny kernel: end_request: I/O error, dev sda, sector 4266023
Aug 17 15:01:32 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 28 00 00 13 00
Aug 17 15:01:32 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:32 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:32 bunny kernel: end_request: I/O error, dev sda, sector 4266024
Aug 17 15:01:34 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 29 00 00 12 00
Aug 17 15:01:34 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:34 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:34 bunny kernel: end_request: I/O error, dev sda, sector 4266025
Aug 17 15:01:35 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2a 00 00 11 00
Aug 17 15:01:35 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:35 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:35 bunny kernel: end_request: I/O error, dev sda, sector 4266026
Aug 17 15:01:37 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2b 00 00 10 00
Aug 17 15:01:37 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:37 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:37 bunny kernel: end_request: I/O error, dev sda, sector 4266027
Aug 17 15:01:38 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2c 00 00 0f 00
Aug 17 15:01:38 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:38 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:38 bunny kernel: end_request: I/O error, dev sda, sector 4266028
Aug 17 15:01:39 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2d 00 00 0e 00
Aug 17 15:01:39 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:39 bunny kernel: end_request: I/O error, dev sda, sector 4266029
Aug 17 15:01:41 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2e 00 00 0d 00
Aug 17 15:01:41 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:41 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:41 bunny kernel: end_request: I/O error, dev sda, sector 4266030
Aug 17 15:01:42 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 2f 00 00 0c 00
Aug 17 15:01:42 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:42 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:42 bunny kernel: end_request: I/O error, dev sda, sector 4266031
Aug 17 15:01:44 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 30 00 00 0b 00
Aug 17 15:01:44 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:44 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:44 bunny kernel: end_request: I/O error, dev sda, sector 4266032
Aug 17 15:01:45 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 31 00 00 0a 00
Aug 17 15:01:45 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:45 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:45 bunny kernel: end_request: I/O error, dev sda, sector 4266033
Aug 17 15:01:46 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 32 00 00 09 00
Aug 17 15:01:46 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:46 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:46 bunny kernel: end_request: I/O error, dev sda, sector 4266034
Aug 17 15:01:48 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 33 00 00 08 00
Aug 17 15:01:48 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:48 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:48 bunny kernel: end_request: I/O error, dev sda, sector 4266035
Aug 17 15:01:49 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 34 00 00 07 00
Aug 17 15:01:49 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:49 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:49 bunny kernel: end_request: I/O error, dev sda, sector 4266036
Aug 17 15:01:50 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 35 00 00 06 00
Aug 17 15:01:50 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:50 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:50 bunny kernel: end_request: I/O error, dev sda, sector 4266037
Aug 17 15:01:52 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 36 00 00 05 00
Aug 17 15:01:52 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:52 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:52 bunny kernel: end_request: I/O error, dev sda, sector 4266038
Aug 17 15:01:53 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 37 00 00 04 00
Aug 17 15:01:53 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:53 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:53 bunny kernel: end_request: I/O error, dev sda, sector 4266039
Aug 17 15:01:55 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 38 00 00 03 00
Aug 17 15:01:55 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:55 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:55 bunny kernel: end_request: I/O error, dev sda, sector 4266040
Aug 17 15:01:56 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 39 00 00 02 00
Aug 17 15:01:56 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:56 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:56 bunny kernel: end_request: I/O error, dev sda, sector 4266041
Aug 17 15:01:58 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 41 18 3a 00 00 01 00
Aug 17 15:01:58 bunny kernel: Current sda: sense key Medium Error
Aug 17 15:01:58 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 15:01:58 bunny kernel: end_request: I/O error, dev sda, sector 4266042

--- SNIP - This is with Kernel 2.6.8

Aug 19 08:47:18 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a3 00 00 08 00
Aug 19 08:47:18 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:18 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:18 bunny kernel: end_request: I/O error, dev sda, sector 14096547
Aug 19 08:47:19 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a4 00 00 07 00
Aug 19 08:47:19 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:19 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:19 bunny kernel: end_request: I/O error, dev sda, sector 14096548
Aug 19 08:47:21 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a5 00 00 06 00
Aug 19 08:47:21 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:21 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:21 bunny kernel: end_request: I/O error, dev sda, sector 14096549
Aug 19 08:47:22 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a6 00 00 05 00
Aug 19 08:47:39 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:39 bunny kernel: end_request: I/O error, dev sda, sector 14096550
Aug 19 08:47:39 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a7 00 00 04 00
Aug 19 08:47:39 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:39 bunny kernel: end_request: I/O error, dev sda, sector 14096551
Aug 19 08:47:39 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a8 00 00 03 00
Aug 19 08:47:39 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:39 bunny kernel: end_request: I/O error, dev sda, sector 14096552
Aug 19 08:47:39 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 a9 00 00 02 00
Aug 19 08:47:39 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:39 bunny kernel: end_request: I/O error, dev sda, sector 14096553
Aug 19 08:47:39 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 d7 18 aa 00 00 01 00
Aug 19 08:47:39 bunny kernel: Current sda: sense key Medium Error
Aug 19 08:47:39 bunny kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 19 08:47:39 bunny kernel: end_request: I/O error, dev sda, sector 14096554

--- SNIP - This is with Kernel 2.6.8 also

Aug 27 14:43:08 bunny kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Write (10) 00 00 90 fc ab 00 00 08 00
Aug 27 14:43:08 bunny kernel: Current sda: sense key Medium Error
Aug 27 14:43:08 bunny kernel: Additional sense: Write error - auto reallocation failed
Aug 27 14:43:08 bunny kernel: end_request: I/O error, dev sda, sector 9501867
Aug 27 14:43:08 bunny kernel: ATA: abnormal status 0xD8 on port 0xF98650C7
Aug 27 14:43:08 bunny last message repeated 2 times

--- SNIP - dmesg output

Aug 27 19:36:48 bunny syslogd 1.4.1#15: restart.
Aug 27 19:36:48 bunny kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Aug 27 19:36:48 bunny kernel: Cannot find map file.
Aug 27 19:36:48 bunny kernel: No module symbols loaded - kernel modules not enabled.
Aug 27 19:36:48 bunny kernel: essor.
Aug 27 19:36:48 bunny kernel: Using pmtmr for high-res timesource
Aug 27 19:36:48 bunny kernel: Console: colour VGA+ 80x25
Aug 27 19:36:48 bunny kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 27 19:36:48 bunny kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 27 19:36:48 bunny kernel: Memory: 1033744k/1048512k available (2077k kernel code, 13860k reserved, 963k data, 192k 
init, 131008k highmem)
Aug 27 19:36:48 bunny kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 27 19:36:48 bunny kernel: Calibrating delay loop... 3973.12 BogoMIPS
Aug 27 19:36:48 bunny kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 27 19:36:48 bunny kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 27 19:36:48 bunny kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Aug 27 19:36:48 bunny kernel: Intel machine check architecture supported.
Aug 27 19:36:48 bunny kernel: Intel machine check reporting enabled on CPU#0.
Aug 27 19:36:48 bunny kernel: CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Aug 27 19:36:48 bunny kernel: Enabling fast FPU save and restore... done.
Aug 27 19:36:48 bunny kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 27 19:36:48 bunny kernel: Checking 'hlt' instruction... OK.
Aug 27 19:36:48 bunny kernel: enabled ExtINT on CPU#0
Aug 27 19:36:48 bunny kernel: ESR value before enabling vector: 00000000
Aug 27 19:36:48 bunny kernel: ESR value after enabling vector: 00000000
Aug 27 19:36:48 bunny kernel: ENABLING IO-APIC IRQs
Aug 27 19:36:48 bunny kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 27 19:36:48 bunny kernel: Using local APIC timer interrupts.
Aug 27 19:36:48 bunny kernel: calibrating APIC timer ...
Aug 27 19:36:48 bunny kernel: ..... CPU clock speed is 2009.0632 MHz.
Aug 27 19:36:48 bunny kernel: ..... host bus clock speed is 200.0963 MHz.
Aug 27 19:36:48 bunny kernel: checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Aug 27 19:36:48 bunny kernel: Freeing initrd memory: 1252k freed
Aug 27 19:36:48 bunny kernel: NET: Registered protocol family 16
Aug 27 19:36:48 bunny kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb2f0, last bus=1
Aug 27 19:36:48 bunny kernel: PCI: Using configuration type 1
Aug 27 19:36:48 bunny kernel: mtrr: v2.0 (20020519)
Aug 27 19:36:48 bunny kernel: ACPI: Subsystem revision 20040326
Aug 27 19:36:48 bunny kernel: ACPI: Interpreter enabled
Aug 27 19:36:48 bunny kernel: ACPI: Using IOAPIC for interrupt routing
Aug 27 19:36:48 bunny kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 27 19:36:48 bunny kernel: PCI: Probing PCI hardware (bus 00)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 *12)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs *20)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
Aug 27 19:36:48 bunny kernel: SCSI subsystem initialized
Aug 27 19:36:48 bunny kernel: PCI: Using ACPI for IRQ routing
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
Aug 27 19:36:48 bunny kernel: ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 27 19:36:48 bunny kernel: testing the IO APIC.......................
Aug 27 19:36:48 bunny kernel: .................................... done.
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 27 19:36:48 bunny kernel: radeonfb: Retreived PLL infos from BIOS
Aug 27 19:36:48 bunny kernel: radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, System=150.00 MHz
Aug 27 19:36:48 bunny kernel: radeonfb: Monitor 1 type CRT found
Aug 27 19:36:48 bunny kernel: radeonfb: EDID probed
Aug 27 19:36:48 bunny kernel: radeonfb: Monitor 2 type no found
Aug 27 19:36:48 bunny kernel: EDID header doesn't match EDID v1 header, aborting
Aug 27 19:36:48 bunny kernel: EDID header doesn't match EDID v1 header, aborting
Aug 27 19:36:48 bunny kernel: radeonfb: ATI Radeon QY  SDR SGRAM 32 MB
Aug 27 19:36:48 bunny kernel: Machine check exception polling timer started.
Aug 27 19:36:48 bunny kernel: highmem bounce pool size: 64 pages
Aug 27 19:36:48 bunny kernel: VFS: Disk quotas dquot_6.5.1
Aug 27 19:36:48 bunny kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 27 19:36:48 bunny kernel: Initializing Cryptographic API
Aug 27 19:36:48 bunny kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 12 to 5
Aug 27 19:36:48 bunny kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 12 to 5
Aug 27 19:36:48 bunny kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
Aug 27 19:36:48 bunny kernel: PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 5
Aug 27 19:36:48 bunny kernel: Console: switching to colour frame buffer device 100x37
Aug 27 19:36:48 bunny kernel: Real Time Clock Driver v1.12
Aug 27 19:36:48 bunny kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 27 19:36:48 bunny kernel: agpgart: Detected AGP bridge 0
Aug 27 19:36:48 bunny kernel: agpgart: Maximum main memory to use for agp memory: 941M
Aug 27 19:36:48 bunny kernel: agpgart: AGP aperture is 128M @ 0xd8000000
Aug 27 19:36:48 bunny kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Aug 27 19:36:48 bunny kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 27 19:36:48 bunny kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 27 19:36:48 bunny kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Aug 27 19:36:48 bunny kernel: Using anticipatory io scheduler
Aug 27 19:36:48 bunny kernel: Floppy drive(s): fd0 is 1.44M
Aug 27 19:36:48 bunny kernel: FDC 0 is a post-1991 82077
Aug 27 19:36:48 bunny kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug 27 19:36:48 bunny kernel: PPP generic driver version 2.4.2
Aug 27 19:36:48 bunny kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 27 19:36:48 bunny kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 27 19:36:48 bunny kernel: VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
Aug 27 19:36:48 bunny kernel: VIA8237SATA: chipset revision 128
Aug 27 19:36:48 bunny kernel: VIA8237SATA: 100%% native mode on irq 20
Aug 27 19:36:48 bunny kernel:     ide2: BM-DMA at 0xdb00-0xdb07, BIOS settings: hde:DMA, hdf:pio
Aug 27 19:36:48 bunny kernel:     ide3: BM-DMA at 0xdb08-0xdb0f, BIOS settings: hdg:DMA, hdh:pio
Aug 27 19:36:48 bunny kernel: hde: WDC WD360GD-00FNA0, ATA DISK drive
Aug 27 19:36:48 bunny kernel: ide2 at 0xd700-0xd707,0xd802 on irq 20
Aug 27 19:36:48 bunny kernel: hdg: WDC WD360GD-00FNA0, ATA DISK drive
Aug 27 19:36:48 bunny kernel: ide3 at 0xd900-0xd907,0xda02 on irq 20
Aug 27 19:36:48 bunny kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
Aug 27 19:36:48 bunny kernel: VP_IDE: chipset revision 6
Aug 27 19:36:48 bunny kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 27 19:36:48 bunny kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Aug 27 19:36:48 bunny kernel:     ide0: BM-DMA at 0xdd00-0xdd07, BIOS settings: hda:DMA, hdb:pio
Aug 27 19:36:48 bunny kernel:     ide1: BM-DMA at 0xdd08-0xdd0f, BIOS settings: hdc:DMA, hdd:pio
Aug 27 19:36:48 bunny kernel: hda: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
Aug 27 19:36:48 bunny kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 27 19:36:48 bunny kernel: hde: max request size: 1024KiB
Aug 27 19:36:48 bunny kernel: hde: 72303840 sectors (37019 MB) w/8192KiB Cache, CHS=16383/255/63
Aug 27 19:36:48 bunny kernel:  hde: hde1 hde2
Aug 27 19:36:48 bunny kernel: hdg: max request size: 1024KiB
Aug 27 19:36:48 bunny kernel: hdg: 72303840 sectors (37019 MB) w/8192KiB Cache, CHS=16383/255/63
Aug 27 19:36:48 bunny kernel:  hdg: hdg1 hdg2
Aug 27 19:36:48 bunny kernel: hda: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Aug 27 19:36:48 bunny kernel: Uniform CD-ROM driver Revision: 3.20
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
Aug 27 19:36:48 bunny kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Aug 27 19:36:48 bunny kernel:         <Adaptec 2940 Ultra SCSI adapter>
Aug 27 19:36:48 bunny kernel:         aic7880: Single Channel A, SCSI Id=7, 16/253 SCBs
Aug 27 19:36:48 bunny kernel:
Aug 27 19:36:48 bunny kernel: (scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
Aug 27 19:36:48 bunny kernel:   Vendor: HP        Model: HP35480A          Rev: T603
Aug 27 19:36:48 bunny kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
Aug 27 19:36:48 bunny kernel: ata1: SATA max UDMA/100 cmd 0xF9865080 ctl 0xF986508A bmdma 0xF9865000 irq 18
Aug 27 19:36:48 bunny kernel: ata2: SATA max UDMA/100 cmd 0xF98650C0 ctl 0xF98650CA bmdma 0xF9865008 irq 18
Aug 27 19:36:48 bunny kernel: ata3: SATA max UDMA/100 cmd 0xF9865280 ctl 0xF986528A bmdma 0xF9865200 irq 18
Aug 27 19:36:48 bunny kernel: ata4: SATA max UDMA/100 cmd 0xF98652C0 ctl 0xF98652CA bmdma 0xF9865208 irq 18
Aug 27 19:36:48 bunny kernel: ata1: no device found (phy stat 00000000)
Aug 27 19:36:48 bunny kernel: scsi1 : sata_sil
Aug 27 19:36:48 bunny kernel: ata2: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
Aug 27 19:36:48 bunny kernel: ata2: dev 0 configured for UDMA/100
Aug 27 19:36:48 bunny kernel: scsi2 : sata_sil
Aug 27 19:36:48 bunny kernel: ata3: no device found (phy stat 00000000)
Aug 27 19:36:48 bunny kernel: scsi3 : sata_sil
Aug 27 19:36:48 bunny kernel: ata4: no device found (phy stat 00000000)
Aug 27 19:36:48 bunny kernel: scsi4 : sata_sil
Aug 27 19:36:48 bunny kernel:   Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
Aug 27 19:36:48 bunny kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 27 19:36:48 bunny kernel: st: Version 20040403, fixed bufsize 32768, s/g segs 256
Aug 27 19:36:48 bunny kernel: Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Aug 27 19:36:48 bunny kernel: st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Aug 27 19:36:48 bunny kernel: SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
Aug 27 19:36:48 bunny kernel: SCSI device sda: drive cache: write back
Aug 27 19:36:48 bunny kernel:  sda: sda1 sda2
Aug 27 19:36:48 bunny kernel: Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Aug 27 19:36:48 bunny kernel: Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 1
Aug 27 19:36:48 bunny kernel: Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
Aug 27 19:36:48 bunny kernel: mice: PS/2 mouse device common for all mice
Aug 27 19:36:48 bunny kernel: input: PC Speaker
Aug 27 19:36:48 bunny kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 27 19:36:48 bunny kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 27 19:36:48 bunny kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 27 19:36:48 bunny kernel: md: linear personality registered as nr 1
Aug 27 19:36:48 bunny kernel: md: raid0 personality registered as nr 2
Aug 27 19:36:48 bunny kernel: md: raid1 personality registered as nr 3
Aug 27 19:36:48 bunny kernel: md: raid5 personality registered as nr 4
Aug 27 19:36:48 bunny kernel: raid5: automatically using best checksumming function: pIII_sse
Aug 27 19:36:48 bunny kernel:    pIII_sse  :  6384.000 MB/sec
Aug 27 19:36:48 bunny kernel: raid5: using function: pIII_sse (6384.000 MB/sec)
Aug 27 19:36:48 bunny kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 27 19:36:48 bunny kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Aug 27 19:36:48 bunny kernel: NET: Registered protocol family 2
Aug 27 19:36:48 bunny kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Aug 27 19:36:48 bunny kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 27 19:36:48 bunny kernel: NET: Registered protocol family 1
Aug 27 19:36:48 bunny kernel: NET: Registered protocol family 17
Aug 27 19:36:48 bunny kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
Aug 27 19:36:48 bunny kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0xa (1300 mV)
Aug 27 19:36:48 bunny kernel: powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
Aug 27 19:36:48 bunny kernel: powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
Aug 27 19:36:48 bunny kernel: powernow-k8: cpu_init done, current fid 0xc, vid 0x2
Aug 27 19:36:48 bunny kernel: ACPI: (supports S0 S3 S4 S5)
Aug 27 19:36:48 bunny kernel: md: Autodetecting RAID arrays.
Aug 27 19:36:48 bunny kernel: md: autorun ...
Aug 27 19:36:48 bunny kernel: md: considering sda2 ...
Aug 27 19:36:48 bunny kernel: md:  adding sda2 ...
Aug 27 19:36:48 bunny kernel: md: sda1 has different UUID to sda2
Aug 27 19:36:48 bunny kernel: md:  adding hdg2 ...
Aug 27 19:36:48 bunny kernel: md: hdg1 has different UUID to sda2
Aug 27 19:36:48 bunny kernel: md:  adding hde2 ...
Aug 27 19:36:48 bunny kernel: md: hde1 has different UUID to sda2
Aug 27 19:36:48 bunny kernel: md: created md2
Aug 27 19:36:48 bunny kernel: md: bind<hde2>
Aug 27 19:36:48 bunny kernel: md: bind<hdg2>
Aug 27 19:36:48 bunny kernel: md: bind<sda2>
Aug 27 19:36:48 bunny kernel: md: running: <sda2><hdg2><hde2>
Aug 27 19:36:48 bunny kernel: md: kicking non-fresh sda2 from array!
Aug 27 19:36:48 bunny kernel: md: unbind<sda2>
Aug 27 19:36:48 bunny kernel: md: export_rdev(sda2)
Aug 27 19:36:48 bunny kernel: raid5: device hdg2 operational as raid disk 1
Aug 27 19:36:48 bunny kernel: raid5: device hde2 operational as raid disk 0
Aug 27 19:36:48 bunny kernel: raid5: allocated 3154kB for md2
Aug 27 19:36:48 bunny kernel: RAID5 conf printout:
Aug 27 19:36:48 bunny kernel:  --- rd:3 wd:2 fd:1
Aug 27 19:36:48 bunny kernel:  disk 0, o:1, dev:hde2
Aug 27 19:36:48 bunny kernel:  disk 1, o:1, dev:hdg2
Aug 27 19:36:48 bunny kernel: md: considering sda1 ...
Aug 27 19:36:48 bunny kernel: md:  adding sda1 ...
Aug 27 19:36:48 bunny kernel: md:  adding hdg1 ...
Aug 27 19:36:48 bunny kernel: md:  adding hde1 ...
Aug 27 19:36:48 bunny kernel: md: created md1
Aug 27 19:36:48 bunny kernel: md: bind<hde1>
Aug 27 19:36:48 bunny kernel: md: bind<hdg1>
Aug 27 19:36:48 bunny kernel: md: bind<sda1>
Aug 27 19:36:48 bunny kernel: md: running: <sda1><hdg1><hde1>
Aug 27 19:36:48 bunny kernel: raid1: raid set md1 active with 2 out of 2 mirrors
Aug 27 19:36:48 bunny kernel: md: ... autorun DONE.
Aug 27 19:36:48 bunny kernel: RAMDISK: cramfs filesystem found at block 0
Aug 27 19:36:48 bunny kernel: RAMDISK: Loading 1252 blocks [1 disk] into ram disk...done.
Aug 27 19:36:48 bunny kernel: VFS: Mounted root (cramfs filesystem) readonly.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 5 seconds
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 27 19:36:48 bunny kernel: Trying to move old root to /initrd ... okay
Aug 27 19:36:48 bunny kernel: Freeing unused kernel memory: 192k freed
Aug 27 19:36:48 bunny kernel: Adding 2097144k swap on /dev/vg00/swap.  Priority:1 extents:1
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-0, internal journal
Aug 27 19:36:48 bunny kernel: ACPI: Processor [CPU0] (supports C1)
Aug 27 19:36:48 bunny kernel: ACPI: Power Button (FF) [PWRF]
Aug 27 19:36:48 bunny kernel: ACPI: Thermal Zone [THRM] (39 C)
Aug 27 19:36:48 bunny kernel: ACPI: Fan [FAN] (on)
Aug 27 19:36:48 bunny kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
Aug 27 19:36:48 bunny kernel: eth0: VIA Rhine II at 0xe8186000, 00:04:61:fe:fe:fe, IRQ 23.
Aug 27 19:36:48 bunny kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 40a1.
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 27 19:36:48 bunny kernel: sk98lin: Network Device Driver v6.23
Aug 27 19:36:48 bunny kernel: (C)Copyright 1999-2004 Marvell(R).
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 27 19:36:48 bunny kernel: eth1: 3Com Gigabit LOM (3C940)
Aug 27 19:36:48 bunny kernel:       PrefPort:A  RlmtMode:Check Link State
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
Aug 27 19:36:48 bunny kernel: via82xx: Assuming DXS channels with 48k fixed sample rate.
Aug 27 19:36:48 bunny kernel:          Please try dxs_support=1 or dxs_support=4 option
Aug 27 19:36:48 bunny kernel:          and report if it works on your machine.
Aug 27 19:36:48 bunny kernel: ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-4, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-1, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-2, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-3, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-7, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-5, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: kjournald starting.  Commit interval 30 seconds
Aug 27 19:36:48 bunny kernel: EXT3 FS on dm-6, internal journal
Aug 27 19:36:48 bunny kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:36:48 bunny kernel: lp0: using parport0 (polling).
Aug 27 19:36:49 bunny kernel: ip_conntrack version 2.1 (8191 buckets, 65528 max) - 296 bytes per conntrack
Aug 27 19:36:49 bunny kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 27 19:38:08 bunny kernel: md: trying to hot-add unknown-block(8,2) to md2 ...
Aug 27 19:38:08 bunny kernel: md: bind<sda2>
Aug 27 19:38:08 bunny kernel: RAID5 conf printout:
Aug 27 19:38:08 bunny kernel:  --- rd:3 wd:2 fd:1
Aug 27 19:38:08 bunny kernel:  disk 0, o:1, dev:hde2
Aug 27 19:38:08 bunny kernel:  disk 1, o:1, dev:hdg2
Aug 27 19:38:08 bunny kernel:  disk 2, o:1, dev:sda2
Aug 27 19:38:08 bunny kernel: md: syncing RAID array md2
Aug 27 19:38:08 bunny kernel: md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
Aug 27 19:38:08 bunny kernel: md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for 
reconstruction.
Aug 27 19:38:08 bunny kernel: md: using 128k window, over a total of 36122048 blocks.

