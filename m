Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKCD4S>; Thu, 2 Nov 2000 22:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQKCD4J>; Thu, 2 Nov 2000 22:56:09 -0500
Received: from piff.student.his.se ([193.10.177.40]:22696 "EHLO
	piff.student.his.se") by vger.kernel.org with ESMTP
	id <S129026AbQKCDz6>; Thu, 2 Nov 2000 22:55:58 -0500
Date: Fri, 03 Nov 2000 04:54:41 +0100
From: Andreas Henriksson <gem@linux.nu>
Subject: Kernel 2.4 SCSI card problem?!
To: linux-kernel@vger.kernel.org
Message-id: <3A023701.C9F6D5F1@linux.nu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: sv, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ...

I'm having problem booting with kernel 2.4 because it doesn't find my
Quantum Atlas 10K drive connected to my Ultra160 SCSI card (Adaptec
29160N)...

It just probes some times and then decides to don't care if it can't
find the harddrive.... (and then I get a kernel panic because "I don't
have a root device"...)

I also have a SCSI-2 device (Plextor PlexWriter 8220) connected..... and
if I remove that device My harddrive is found, BUT...... it says
"scsi: unknown type 24" (or maybee it was 27 ... don't remember)... and
for the model and stuff there are just lots of weird characters....

Sorry I can't get you a bootlog .... but I'll try to visualize it with
the bootlog from Kernel 2.2(.17) which also has problems finding the
drive but doesn't give up that easy..... (I often get "Probably an
unrecoverable scsi bus or device hang" when I try to boot..... but after
a couple of tries it works)


Here is the 2.2 bootlog (just the scsi part):

<-- snip -->

(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
0/10/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
(scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 8.
  Vendor: PLEXTOR   Model: CD-R   PX-W8220T  Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
(scsi0:0:6:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 7, scsi0, channel 0, id 6,
lun 0 Test Unit Ready 00 00 00 00 00
SCSI host 0 abort (pid 7) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 7) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:6:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:6:0) Parity error during Data-In phase.
SCSI host 0 abort (pid 7) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 7) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:6:0) Synchronous at 160.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 8, scsi0, channel 0, id 6,
lun 0 Inquiry 00 00 00 ff 00
  Vendor: QUANTUM   Model: ATLAS 10K 9WLS    Rev: UCP0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
scsi : detected 2 SCSI generics 1 SCSI cdrom 1 SCSI disk total.
(scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 8.
sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.11
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17938986 [8759 MB]
[8.8 GB]
Partition check:
 sda: sda1 sda2 sda3 sda4
 hda: hda1
VFS: Mounted root (ext2 filesystem) readonly.

<-- snip -->


this is the regular case when it works...... Sometimes it probes at
80Mbyte/s much longer... and sometimes it finds the drive in 80Mbyte/s
mode (when this happens the drive is always found on the first try)....

Problem with 2.4 is that it only probes 80Mbyte/s some times and then
goes on without my finding my drive. (Only time it changes to 160Mbyte/s
is after a "scsi bus or device hang" .... but then nothing happens
anyway ... so ....)


I hope I supplied enough information ....
I've tried all possible things to get it to work but nothing seems to
help ....

If this isn't a kernel flaw and you think you know a solution to my
problem and have some time over, or need more information, feel free to
mail me at "andreas.henriksson@linux.se", If you feel like flaming me
please send those mails to "someone.else@plea.se"....



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
