Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHaPmd>; Sat, 31 Aug 2002 11:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSHaPmd>; Sat, 31 Aug 2002 11:42:33 -0400
Received: from [62.67.222.139] ([62.67.222.139]:7396 "EHLO kermit")
	by vger.kernel.org with ESMTP id <S317603AbSHaPmb>;
	Sat, 31 Aug 2002 11:42:31 -0400
Date: Sat, 31 Aug 2002 17:46:05 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre5-ac1 still crashes with ide-scsi
Message-ID: <20020831154605.GA12161@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: konsti@ludenkalle.de (Konstantin Kletschke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I wanted to switch from 2.4.19-preX-acX because this release has had
Problems with the sound latency on my Computer. I thought it is my fault
or my hardware broken, but the Problem was reproduceable by doing

tar xzf linux-2.4.16.tar.gz ; cd linux
bzip2 -dc ../patch-2.4.17.bz2 | patch -p1
...

and so on. all the time all soundplayers with kernel or alsa drivers
crackled or paused (0.25s) playing.

This Problem occured even on console with no X and NVdriver (never been
loaded in session).

With 2.4.20-pre5-ac1 the Problem seems to have gone, I was not able to
reproduce it until know (runs 4 hours now, with reboots).

Otherwise, like in all ac kernels between 2.4.19-acX and 2.4.20-pre5-ac1
ide-scsi does not work. 

mount /cdrom

Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
(scsi1:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
sr2: scsi-1 drive
kernel BUG in header file at line 157
kernel BUG at panic.c:286!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0118cf7>]    Tainted: P
EFLAGS: 00010282
eax: 00000026   ebx: 00000000   ecx: 00000001   edx: ede6df7c
esi: 00000000   edi: 00001000   ebp: 00000000   esp: eb445d08
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 9170, stackpage=eb445000)
Stack: c0246f80 0000009d c01e10ae 0000009d 00000000 00000014 00000014 00000001
       efcfc000 c19e0000 c02f95b8 00000000 ec429240 c01e127c c02f9508 ec429240
       c19ff580 00000000 c02f9508 c02f9508 c02f95b8 ec429240 ec429240 c01e17a7
Call Trace:   [<c01e10ae>] [<c01e127c>] [<c01e17a7>] [<f0859c3c>] [<c01da223>]
 [<c01da39d>] [<c01daa70>] [<f085a65e>] [<f0842661>] [<f0848550>] [<f08482c0>]
 [<f0a02620>] [<f0849fac>] [<f0a02620>] [<c01cf9e0>] [<c011df7d>] [<c013ed51>]
 [<c012acd0>] [<c012b6ae>] [<c012ba50>] [<c012bb98>] [<c012ba50>] [<c0139a87>]
 [<c013a8a3>] [<c010726f>]

 Code: 0f 0b 1e 01 a9 47 24 c0 90 eb fe 90 90 90 90 90 90 90 90 90
 Segmentation fault
sexmachine:~# scsi : aborting command due to timeout : 
pid 48, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 00 00 00 00 00 02 00

sorry, the output is not well formatted, because the last two lines are
repeated print to the console and are editing vith vim impossible ;-)
After 20s the Computer hangs completely...

I use an Soyo Dragon Ultra with KT333, the IDE disks attached 
two the highpoint 372 controller and the cdroms attached two the via controller.

  Bus  0, device  15, function  0:
      RAID bus controller: Triones Technologies, Inc.
      HPT366/368/370/370A/372 (rev 5).            IRQ 12.
      Master Capable.  Latency=120.  Min Gnt=8.Max Lat=8.
		  
This is the cause I have to use the ac patches because the hpt372 is not
working with vanilla kernels...

The cpu is an XP1800+

Konsti

-- 
Kletschke & Uhlig GbR: 
http://www.ku-gbr.de
