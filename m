Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSHRWQ1>; Sun, 18 Aug 2002 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSHRWQ1>; Sun, 18 Aug 2002 18:16:27 -0400
Received: from AMontsouris-108-1-18-117.abo.wanadoo.fr ([80.15.147.117]:17797
	"EHLO leloo") by vger.kernel.org with ESMTP id <S316434AbSHRWQ0>;
	Sun, 18 Aug 2002 18:16:26 -0400
Date: Mon, 19 Aug 2002 00:20:25 +0200
From: Edouard Gomez <ed.gomez@wanadoo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] ide-scsi in 2.4.20-pre2-ac3
Message-ID: <20020818222025.GA2981@leloo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been using successfully the  last 2.4.19-rcX-ac series but when i
switched to the last 2.4.20-pre2-ac3, i got problems with the ide-scsi
module. It was reseting all the time and i had to reboot.

Hardware :

[root@leloo] # hdparm -iv /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Input/output error
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument

 Model=SONY DVD-ROM DDU1211, FwRev=IYH1, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

[root@leloo] # cat /proc/cmdline 
quiet hdc=ide-scsi hdd=ide-scsi root=/dev/hda2 idebus=66

What happens :

When  using transcode to  access my  dvd drive  (hdc) for  an encoding
session, the  ide-scsi module tells me  that there's a  timeout and it
must reset  the bus.  When i  switch back to  a previous  2.4.19-rc ac
series kernel, all works fine.

Here's the log  when starting the transcode program :

Aug 17 21:31:30 leloo kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Aug 17 21:31:30 leloo kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Aug 17 21:31:30 leloo kernel: sr0: scsi3-mmc drive: 0x/40x cd/rw xa/form2 cdda tray
Aug 17 21:31:30 leloo kernel: Uniform CD-ROM driver Revision: 3.12
Aug 17 21:31:30 leloo kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Aug 17 21:31:30 leloo kernel: kernel BUG in header file at line 157
Aug 17 21:31:30 leloo kernel: kernel BUG at panic.c:286!
Aug 17 21:31:30 leloo kernel: invalid operand: 0000
Aug 17 21:31:30 leloo kernel: CPU:    0
Aug 17 21:31:30 leloo kernel: EIP:    0010:[<c01194c7>]    Tainted: P 
Aug 17 21:31:30 leloo kernel: EFLAGS: 00010282
Aug 17 21:31:30 leloo kernel: eax: 00000026   ebx: 00000000   ecx: 00000001   edx: c4d6e0a4
Aug 17 21:31:30 leloo kernel: esi: 00000000   edi: 00001000   ebp: 00000000   esp: c5289d08
Aug 17 21:31:30 leloo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 21:31:30 leloo kernel: Process tcprobe (pid: 5933, stackpage=c5289000)
Aug 17 21:31:30 leloo kernel: Stack: c01e8c60 0000009d c01894c1 0000009d 00000000 00000014 00000028 00000002 
Aug 17 21:31:30 leloo kernel: d7ec0000 d7ec3000 c0267180 00000000 d4fa2e00 c01896ac c02670d0 d4fa2e00 
Aug 17 21:31:30 leloo kernel: d7ec2180 00000000 c02670d0 c02670d0 c0267180 d4fa2e00 d4fa2e00 c0189bc7 
Aug 17 21:31:30 leloo kernel: Call Trace:    [<c01894c1>] [<c01896ac>] [<c0189bc7>] [<d8840c41>] [<c01858c1>]
Aug 17 21:31:30 leloo kernel: [<c0185a3b>] [<c0186100>] [<d8841661>] [<d8831642>] [<d88372a0>] [<d8837010>]
Aug 17 21:31:30 leloo kernel: [<d8838d4e>] [<d99e4720>] [<c017c4d6>] [<c011e7da>] [<c014039f>] [<c012bc5d>]
Aug 17 21:31:30 leloo kernel: [<c012c66e>] [<c012ca10>] [<c012cb58>] [<c012ca10>] [<c013bce3>] [<c01090bf>]
Aug 17 21:31:30 leloo kernel: 
Aug 17 21:31:30 leloo kernel: Code: 0f 0b 1e 01 99 86 1e c0 90 eb fe 8d b4 26 00 00 00 00 8d bc 
Aug 17 21:32:00 leloo kernel: scsi : aborting command due to timeout : pid 19, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 01 00 00 00 04 00 
Aug 17 21:32:00 leloo kernel: scsi : aborting command due to timeout : pid 20, scsi0, channel 0, id 0, lun 0 0x00 00 00 00 00 00 
Aug 17 21:32:30 leloo kernel: scsi : aborting command due to timeout : pid 19, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 01 00 00 00 04 00 
Aug 17 21:32:30 leloo kernel: SCSI host 0 abort (pid 19) timed out - resetting
Aug 17 21:32:30 leloo kernel: SCSI bus is being reset for host 0 channel 0.

Then the 4 last lines were repeated until the reboot. I'm sorry bit i had not System.map to map the call to symbol names

-- 
Edouard Gomez
