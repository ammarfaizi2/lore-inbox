Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRLDCsT>; Mon, 3 Dec 2001 21:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282274AbRLCXuM>; Mon, 3 Dec 2001 18:50:12 -0500
Received: from dialup051.ap01-wien.AT.KPNQwest.net ([193.154.184.51]:4135 "EHLO
	[193.154.184.51]") by vger.kernel.org with ESMTP id <S284835AbRLCRWU>;
	Mon, 3 Dec 2001 12:22:20 -0500
Date: Mon, 3 Dec 2001 18:22:16 +0100 (CET)
From: Markus Biermaier <mbier@eunet.at>
To: linux-kernel@vger.kernel.org
cc: mayfield+usb@sackheads.org
Subject: Problem with 'mount -t vfat' on PPC
Message-ID: <Pine.LNX.4.21.0112031818220.10327-100000@linuxpb.mboffice>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem, when mounting a DOS-File-System with "mount -t vfat":
Most (long) file/folder names are corrupted.

I actually mount a Compact Flash card via an USB card-reader.
My secondary device, an "Ericsson MC218", is equivalent to a "Psion MX5".
This PalmTop computer uses EPOC as os and I try to exchange files
via Compact Flash card (to get Linux running on the MC218...).

On the Linux-side every character in a name is replaced by a "?" (question-
mark), on the MC218 alle names appear empty.

I can exchange data CONTENT with no problems. I tried to USE files
transfered from Linux to the MC218. This worked fine.

When I use "mtools (1)" all works fine!

As I mailed with the maintainer of the card-driver he thinks, that the
driver is OK. He thinks, that mtools uses its own FAT-handling
and the problem is in the kernel...

I had sometimes problems with byte-ordering (big endianess) before when
I used relatively new modules...

My configuration:

Hardware:	Apple PowerBook G3 (bronze keyboard)
System:		SuSE Linux 7.1
Kernel:		Self compiled kernel 2.4.12

Reader:		DataFab DSCFSM-USB
		Dual Storage
		Compact Flash
		Smart Media
		USB

Card:		/dev/sda1
FileSystem:	FAT16, Linux


-------------------- [ BEGIN Snippet from /proc/bus/usb/devices ] --------------------
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=07c4 ProdID=a109 Rev=17.08
S:  Manufacturer=DataFab Systems Inc.
S:  Product=USB CF+SM
S:  SerialNumber=6D8BD3BC8B
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
-------------------- [ END   Snippet from /proc/bus/usb/devices ] --------------------


mount -t vfat
=============

-------------------- [ BEGIN mount -t vfat /dev/sda1 /mnt/flash ] --------------------
linuxpb:/home/mbier/CF-Reader # mount -t vfat /dev/sda1 /mnt/flash
linuxpb:/home/mbier/CF-Reader # dir /mnt/flash/
total 1872
drwxr-xr-x   4 root     root        16384 Jan  1  1970 .
drwxr-xr-x   5 root     root         4096 Dec  1 22:02 ..
-rwxr-xr-x   1 root     root      1856084 Dec  3 00:16 ?????????????????????????
drwxr-xr-x  99 root     root         4096 Dec  3 13:32 ???????????
-rwxr-xr-x   1 root     root        24927 Dec  3 14:16 arlo.zip
drwxr-xr-x  38 root     root         4096 Dec  3 15:20 ??????
-------------------- [ END   mount -t vfat /dev/sda1 /mnt/flash ] --------------------


mount -t vfat -o uni_xlate
==========================

-------------------- [ BEGIN mount -t vfat -o uni_xlate /dev/sda1 /mnt/flash ] --------------------
linuxpb:/home/mbier/CF-Reader # mount -t vfat -o uni_xlate /dev/sda1 /mnt/flash
linuxpb:/home/mbier/CF-Reader # dir /mnt/flash/
total 1872
drwxr-xr-x   4 root     root        16384 Jan  1  1970 .
drwxr-xr-x   5 root     root         4096 Dec  1 22:02 ..
-rwxr-xr-x   1 root     root      1856084 Dec  3 00:16 :4100:7200:6300:6800:6900:7600:2d00:5200:4500:5300:5400:4f00:5200:4500:2d00:3200:3000:3000:3100:2d00:3100:3200:2d00:3000:3200
drwxr-xr-x  99 root     root         4096 Dec  3 13:32 :4d00:6100:7200:6b00:7500:7300:5000:7200:6f00:6700:7300
-rwxr-xr-x   1 root     root        24927 Dec  3 14:16 arlo.zip
drwxr-xr-x  38 root     root         4096 Dec  3 15:20 :4200:6100:6300:6b00:7500:7000
-------------------- [ END   mount -t vfat -o uni_xlate /dev/sda1 /mnt/flash ] --------------------


mount -t msdos
==============

-------------------- [ BEGIN mount -t msdos /dev/sda1 /mnt/flash ] --------------------
linuxpb:/home/mbier/CF-Reader # mount -t msdos /dev/sda1 /mnt/flash
linuxpb:/home/mbier/CF-Reader # dir /mnt/flash/
total 1872
drwxr-xr-x   4 root     root        16384 Jan  1  1970 .
drwxr-xr-x   5 root     root         4096 Dec  1 22:02 ..
-rwxr-xr-x   1 root     root      1856084 Dec  3 00:16 archiv-r
drwxr-xr-x  99 root     root         4096 Dec  3 13:32 markuspr
-rwxr-xr-x   1 root     root        24927 Dec  3 14:16 arlo.zip
drwxr-xr-x  38 root     root         4096 Dec  3 15:20 backup
-------------------- [ END   mount -t msdos /dev/sda1 /mnt/flash ] --------------------


mtools
======

-------------------- [ BEGIN mtools ] --------------------
linuxpb:/home/mbier/CF-Reader # mdir d:
 Volume in drive D has no label
 Volume Serial Number is 7DB7-001F
Directory for D:/
 
archiv-r       1856084 12-03-2001   0:16  Archiv-RESTORE-2001-12-02
backup       <DIR>     12-03-2001  15:20  Backup
arlo     zip     24927 12-03-2001  14:16
markuspr     <DIR>     12-03-2001  13:32  MarkusProgs
        4 files           1 881 011 bytes
                          1 654 784 bytes free
-------------------- [ END   mtools ] --------------------

I would prefer to mount the CF-card as Linux file-system...

Kind regards

Markus Biermaier

----------------------------------------------------------------------
M. Biermaier                                       Tel: +43-2233-55932
Wiesengasse 15                                   Fax: +43-2233-55932-4
3011  Untertullnerbach                          E-Mail: mbier@EUnet.at
Austria / Europe               Web Site: http://www.mbier.co.at/mbier/

