Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQKTCdb>; Sun, 19 Nov 2000 21:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbQKTCdW>; Sun, 19 Nov 2000 21:33:22 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:39686 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S130147AbQKTCdF>; Sun, 19 Nov 2000 21:33:05 -0500
Message-ID: <3A188657.AD2C7BFE@cornils.net>
Date: Mon, 20 Nov 2000 03:03:03 +0100
From: Malte Cornils <malte@cornils.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-RAID i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: tmscsim driver on test11-pre7 stops working when starting X
Content-Type: multipart/mixed;
 boundary="------------5F457EA430A23C90874B5BEF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5F457EA430A23C90874B5BEF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------5F457EA430A23C90874B5BEF
Content-Type: text/plain; charset=us-ascii;
 name="bugrep.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bugrep.txt"

Hi,

my Dawicontrol 2974 SCSI-adapter fails with kernel 2.4.0-test10 
with pre-11 and reiserfs for kernel test-10 patched in:

--
Nov 20 01:30:23 wh36-b407 kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 08 c0 6c 00 00 f8 00 
Nov 20 01:30:23 wh36-b407 kernel: DC390: Abort command (pid 0, DCB c12c11c0, SRB 00000000)
Nov 20 01:30:23 wh36-b407 kernel: DC390: Status of last IRQ (DMA/SC/Int/IRQ): 0890cc20
Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: SCSI block:
Nov 20 01:30:23 wh36-b407 kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS Ctl1 Ctl2 Ctl3 Ctl4
Nov 20 01:30:23 wh36-b407 kernel: DC390:  000000   44   10   cc   00   80   17   48   18   04
Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: DMA engine:
Nov 20 01:30:23 wh36-b407 kernel: DC390: Cmd   STrCnt    SBusA    WrkBC    WrkAC Stat SBusCtrl
Nov 20 01:30:23 wh36-b407 kernel: DC390:  80 00001000 051a4000 00000000 051a5000   00 03080000
Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: PCI Status: 0200
Nov 20 01:30:23 wh36-b407 kernel: DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim
Nov 20 01:30:23 wh36-b407 kernel: DC390: Aborted pid 0 with status 0
Nov 20 01:30:23 wh36-b407 kernel: SCSI host 0 abort (pid 0) timed out - resetting
Nov 20 01:30:23 wh36-b407 kernel: SCSI bus is being reset for host 0 channel 0.
Nov 20 01:30:23 wh36-b407 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 25040000
Nov 20 01:30:23 wh36-b407 kernel:  I/O error: dev 08:02, sector 448928
Nov 20 01:30:27 wh36-b407 kernel: SysRq: Emergency Sync
Nov 20 01:30:27 wh36-b407 kernel: Syncing device 03:08 ... OK
Nov 20 01:30:27 wh36-b407 kernel: Syncing device 03:01 ... OK
Nov 20 01:30:29 wh36-b407 kernel: Syncing device 09:00 ... OK
Nov 20 01:30:29 wh36-b407 kernel: Done.
Nov 20 01:31:46 wh36-b407 kernel: Kernel logging (proc) stopped.
Nov 20 01:31:46 wh36-b407 kernel: Kernel log daemon terminating.
Nov 20 01:31:46 wh36-b407 exiting on signal 15
--

This happened on the second bootup with the new kernel, when kdm
was starting Xfree 4.0.1 from Debian woody.

the tmscsim driver is initialized with:
--
Nov 20 01:29:34 wh36-b407 kernel: SCSI subsystem driver Revision: 1.00
Nov 20 01:29:34 wh36-b407 kernel: DC390_init: No EEPROM found!
Nov 20 01:29:34 wh36-b407 kernel: DC390_init: Trying default EEPROM settings:
Nov 20 01:29:34 wh36-b407 kernel: DC390: Used defaults: AdaptID=7, SpeedIdx=1 (8.0 MHz), DevMode=0x1f, AdaptMode=0x0f, TaggedCmnds=3 (16)
Nov 20 01:29:34 wh36-b407 kernel: Bad boy: tmscsim (at 0xc02bf732) called us without a dev_id!
Nov 20 01:29:34 wh36-b407 kernel: DC390: 1 adapters found
Nov 20 01:29:34 wh36-b407 kernel: scsi0 : Tekram DC390/AM53C974 V2.0d 1998/12/25
Nov 20 01:29:34 wh36-b407 kernel: DC390: Target 0: Sync transfer 8.0 MHz, Offset 15
Nov 20 01:29:34 wh36-b407 kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S61A
Nov 20 01:29:34 wh36-b407 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov 20 01:29:34 wh36-b407 kernel: DC390: Target 5: Sync transfer 8.0 MHz, Offset 15
Nov 20 01:29:34 wh36-b407 kernel:   Vendor: RICOH     Model: MP6200S           Rev: 2.40
Nov 20 01:29:34 wh36-b407 kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov 20 01:29:34 wh36-b407 kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Nov 20 01:29:34 wh36-b407 kernel: SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
Nov 20 01:29:34 wh36-b407 kernel:  sda: sda1 sda2 sda3 sda4
Nov 20 01:29:34 wh36-b407 kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Nov 20 01:29:34 wh36-b407 kernel: sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
Nov 20 01:29:34 wh36-b407 kernel: Uniform CD-ROM driver Revision: 3.11
--

I noted there's a new version of the driver on the maintainer's (Kurt
Garloff) homepage, but last time I tested it and reported an oops with
2.4.test-something he didn't reply at all (that's not an offense, it's
understandable with the amount of work he's doing for KDE2 etc).

So should I
a) try with his patch again; my oops report for that is attached below
b) wait you can make of this bugreport
c) provide any further info/testing?

BTW, 2.2.17 with the stock tmscsim works fine everytime; with that kernel
(and no other changes) the system is excessively stable :)

CU, Yours Malte #8-)

PS: Please cc me, I'm usually watching the lists I report bugs to, but LKML
is a bit... excessive; I'll monitor the list from time to time, but can't
guarantee timely responses...

System specs: AMD K6-2 333 on a TX430-based Mainboard, not overclocked;
additional cards are:
ISA 
	- CL Soundblaster 16 PnP ISA
	- NE2k-clone
PCI
	- Dawicontrol 2974 Fast-SCSI, based on AMD53... chip
	- ATI Rage Pro LT PCI 8 MB
	- Hauppauge WinTV Theatre (bttv878)

now the bug report with Garloff's new driver (I was using a scanner
in addition, but the kernel oopses in the disk support, so it's probably
the same problem)
--cut!--
Hi,

> I'm interested in this report. I know about the IRQ registration with a
> missing devid, but that's the only real issue. Another minor thing is that
> the driver does not wait for the INQUIRY data before trying to do sync
> negotiation with a device. That shouldn't be a problem but for some SCSI-1
> devices, it apparently is.

What should happen then? If I turn my scanner on and boot via 2.2.17
and e2
tmscim driver, the scanner isn't found on bootup but with an extra
"echo 0 0 6 0 > /proc..." (like that, don't remember exactly) it is
found.

When I leave the scanner on in 2.4.0.test9-pre1 and e2 (but also
with the
original SCSI driver version from 2.4.0.test9-pre1) the kernel spits
out lots of
"Detected scsi generic sg3432423 at scsi0, channel0, id6, lun0, type
6"
but with the sg-number always incrementing. I have not found out
when it stops yet :(

The scanner BTW is a Microtek Scanmaker II, which had the "scanner
bug" in earlier
versions of the driver in conjunction with SANE, but under 2.2.17
and the newest
e2 driver, this is all gone and everything works perfectly.

I resumed further testing without the scanner turned on then, could
work for a while but then (I was in xfwm (my "desktop environment")
and was starting the latest mozilla nightly from the scsi disk, and
since it appeared not to start up, I wanted to start a
gnome-terminal to invoke "top" to see whether the processor is still
being used; the shell prompt in the new gnome-terminal never
appeared) I saw some tiny lines on the top of the screen (TFT) and
the system was frozen (well, SysRq-Key still got me out there).

The next boot, while in the fsck-Phase for the SCSI drive (SysRq
didn't work *that* well obviously :)) I got the oops. There were
some lines scrolling by which I unfortunately couldn't write down
fast enough, but I did copy the oops:

Oops: 0000
CPU: 0
EIP: 0010:[<c0186b60>]
EFLAGS: 00010097
eax: 00000001 ebx: c12aa1e0 ecx: 00000000 edx: 4600a6c0
esi: 00000000 edi: c12a4078 ebp: c12aa1e0 esp: c0243ed0
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:0, stack page = c0243000)
Stack: c12a400 c12a4078 c13f9800 c13f9800 0105161b c018509f c12a4078
c13f9800
       0000000 00000000 c12a4000 c019181d c13f9800 00000002 c13f9800
00000282
       0000000 c0243fa4 00000000 c0190e38 c13f9800 00000002 c0206400
00000000
Call Trace: 
[<c018509f>][<c019181d>][<c0190e38>][<c0206400>][<c0190de0>][<c011c362>][<c010e629>]
[<c011967f>][<c01195b7>][<c01194c0>][<c010b9a2>][<c0108a00>][<ffffe000>][<c010a6c0>]//
[<c0108a00>]
[<ffffe000>][<c0108a23>][<c0108a87>][<c0105000>][<c0100192>]
Code: 8b 31 8b 51 08 8b 47 24 89 01 89 4f 24 3b 54 24 1c 75 0d c7
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing
DC390: Target 0: Sync transfer 8.0Mhz, Offset 15
SCSI disk error: host 0 channel 0 id 0 lun 0 return code = 8000000
[valid=0] Info fld=0x0, current sd08:05: sense key Aborted Command
I/O error: dev 08:05, sector 624442
--------snip (my fingers hurt now :))--------

OK and attached the /var/log/messages (relevant lines and a few
more).

on a running 2.4.0-test9-pre1 kernel, /proc/scsi/scsi looks like
this:
---------snip---------
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S61A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-20TS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: RICOH    Model: MP6200S          Rev: 2.40
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-103  Rev: 1.15
  Type:   CD-ROM                           ANSI SCSI revision: 02
--------snip!---------

Also, the oops occured when I was sharing interrupts (but this is
PCI, so there should be no problems, right?). BTW, the "fsck
generates an oops at a certain position" might indicate a bad hard
disk or something, but the system runs just great under the same
driver in 2.2.17; termination is also correct, however it's a
Fast-SCSI system and I only have a passive terminator on my
scanner-side bus end. Still, the whole chain just works in 2.2.17,
as I said.

> Unfortunately, I did not have much time lately, otherwise, I'd already
done
> it.

I just fear that Linus might avoid large patches for the now
imminent 2.4... :-?

Thanks for your help!


Sep 21 20:31:54 wh36-b407 modprobe: modprobe: Can't locate module net-pf-10
Sep 21 20:32:26 wh36-b407 kernel: scsi : aborting command due to timeout :
pid 0,
scsi0, channel 0, id 0, lun 0 Read (10) 00 00 7c 65 c6 00 00 38 00 
Sep 21 20:32:26 wh36-b407 kernel: DC390: Abort command (pid 0, Device 00-00)
Sep 21 20:32:26 wh36-b407 kernel: DC390: Status of last IRQ
(DMA/SC/Int/IRQ): 0890cc20
Sep 21 20:32:26 wh36-b407 kernel: DC390: Registr dump: SCSI block:
Sep 21 20:32:26 wh36-b407 kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS
Ctl1 Ctl2
Ctl3 Ctl4
Sep 21 20:32:26 wh36-b407 kernel: DC390:  000000   44   10   cc   00   80
17   48
18   04
Sep 21 20:32:26 wh36-b407 kernel: DC390: Register dump: DMA engine:
Sep 21 20:32:26 wh36-b407 kernel: DC390: Cmd   STrCnt    SBusA    WrkBC
WrkAC Stat
SBusCtrl
Sep 21 20:32:26 wh36-b407 kernel: DC390:  00 00000400 03d3b000 00000000
03d3b400   00
03080000
Sep 21 20:32:26 wh36-b407 kernel: DC390: Register dump: PCI Status: 0200
Sep 21 20:32:26 wh36-b407 kernel: DC390: In case of driver trouble read
linux/drivers/scsi/README.tmscsim
Sep 21 20:32:26 wh36-b407 kernel: DC390: Aborted pid 0 with status 0
Sep 21 20:32:27 wh36-b407 kernel: SCSI disk error : host 0 channel 0 id 0
lun 0 return
code = 27010000
Sep 21 20:32:27 wh36-b407 kernel:  I/O error: dev 08:05, sector 3915802
Sep 21 21:16:02 wh36-b407 syslogd 1.3-3: restart.

--------------5F457EA430A23C90874B5BEF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
