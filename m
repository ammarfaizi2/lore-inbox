Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315935AbSENR4J>; Tue, 14 May 2002 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315937AbSENR4I>; Tue, 14 May 2002 13:56:08 -0400
Received: from mail.netbeat.de ([62.208.140.19]:53266 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id <S315935AbSENRzk>;
	Tue, 14 May 2002 13:55:40 -0400
Date: Tue, 14 May 2002 19:55:33 +0200
From: Henning Schroeder <hgs@anna-strasse.de>
X-Mailer: The Bat! (v1.53d)
Reply-To: Henning Schroeder <hgs@anna-strasse.de>
Organization: =?ISO-8859-1?B?QW5uYXN0cmFzc2UgV/xyemJ1cmc=?=
X-Priority: 3 (Normal)
Message-ID: <379487051.20020514195533@anna-strasse.de>
To: linux-kernel@vger.kernel.org
Subject: IDE *data corruption* VIA VT8367
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I´m not quite sure whether this is a kernel issue, but I can´t think
of another evildoer :-)

ASUS A7V266-E Mainboard (VT8367 [KT266] Chipset, with VIA IDE and
Promise 20265 IDE Controller on board), 4x MAXTOR 6L020J1 (20GB
ATA-100) attached at the four ports (resulting in hda, hdc, hde, hdg).

Robin Miller´s Data Test Program (dt) from
http://www.bit-net.com/~rmiller/dt.html reports data errors on (and
only on) hdg when tests are run in parallel. This is especially nasty
because i plan to use the drives in a RAID-0 fashion which results in
data errors as well.

These combinations give errors: (hda hdc hde hdg), (hdc hde hdg)

These combinations run flawless: (hda hdc hde), (hde hdg), (hda hdc
hdg). I did not test more combinations because every test takes some
hours.

Attaching hdg as a slave drive to the first promise port (which gives
me hdf instead and the second promise port emtpy) makes the array run
fine, but performance drops to a figure comparable to a single drive.

There are no error logs whatsoever (except for the dt output). Without
RAID-array and without heavy IDE access, the machine runs stable.

Kernels tested: 2.4.18, 2.4.19pre8

Has anybody seen this before? Any info would be appreciated. I would
be happy to provide more information.

Diagnostics attached below.


------- output from dt (this is actually output from testing the raid
array) ----------------

Command Line:

    % dt.d/dt of=/data/test limit=1g min=512 max=32k align=rotate procs=15 log=dtlog runtime=12h 

        --> Date: June 2nd, Version: 14.10, Author: Robin T. Miller <--

[...]

dt (2150): Error number 1 occurred on Wed May  8 20:16:40 2002
dt (2150): Data compare error at byte 5116 in record number 36
dt (2150): Relative block number where the error occcured is 639 (offset 508)
dt (2150): Data expected = 0xde, data found = 0x33, byte count = 18432
dt (2150): The incorrect data starts at address 0x80b1688 (marked by asterisk '*')
dt (2150): Dumping Pattern Buffer (base = 0x80b1688, offset = 0, limit = 4 bytes):

0x80b1688 *de c6 de c6

dt (2150): The incorrect data starts at address 0x80b33ff (marked by asterisk '*')
dt (2150): Dumping Data Buffer (base = 0x80b2003, offset = 5116, limit = 64 bytes):

0x80b33df  de c6 de c6 de c6 de c6 de c6 de c6 de c6 de c6
0x80b33ef  de c6 de c6 de c6 de c6 de c6 de c6 de c6 de c6
0x80b33ff *33 33 33 33 de c6 de c6 de c6 de c6 de c6 de c6
0x80b340f  de c6 de c6 de c6 de c6 de c6 de c6 de c6 de c6


[...]

dt (2148): Error number 1 occurred on Wed May  8 20:16:42 2002
dt (2148): Data compare error at byte 2044 in record number 857
dt (2148): Relative block number where the error occcured is 27343 (offset 508)
dt (2148): Data expected = 0xff, data found = 0x26, byte count = 12800
dt (2148): The incorrect data starts at address 0x80b1688 (marked by asterisk '*')
dt (2148): Dumping Pattern Buffer (base = 0x80b1688, offset = 0, limit = 4 bytes):

0x80b1688 *ff 00 ff 00

dt (2148): The incorrect data starts at address 0x80b27fc (marked by asterisk '*')
dt (2148): Dumping Data Buffer (base = 0x80b2000, offset = 2044, limit = 64 bytes):

0x80b27dc  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x80b27ec  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x80b27fc *26 33 67 66 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x80b280c  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00

[...]

dt (2160): Error number 1 occurred on Wed May  8 20:16:46 2002
dt (2160): Data compare error at byte 24572 in record number 49
dt (2160): Relative block number where the error occcured is 1223 (offset 508)
dt (2160): Data expected = 0x39, data found = 0xff, byte count = 25088
dt (2160): The incorrect data starts at address 0x80b1688 (marked by asterisk '*')
dt (2160): Dumping Pattern Buffer (base = 0x80b1688, offset = 0, limit = 4 bytes):

0x80b1688 *39 9c c3 39

dt (2160): The incorrect data starts at address 0x80b7ffc (marked by asterisk '*')
dt (2160): Dumping Data Buffer (base = 0x80b2000, offset = 24572, limit = 64 bytes):

0x80b7fdc  39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39
0x80b7fec  39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39
0x80b7ffc *ff 00 ff 00 39 9c c3 39 39 9c c3 39 39 9c c3 39
0x80b800c  39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39


[.... ad nauseaum]

-------------- lspci output ------------

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
00:0c.0 VGA compatible unclassified device: S3 Inc. 86c864 [Vision 864 DRAM] vers 0
00:0e.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
00:0f.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)



-- 
Best regards,
 Henning                          mailto:hgs@anna-strasse.de

