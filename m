Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135678AbRD2FWN>; Sun, 29 Apr 2001 01:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135679AbRD2FWD>; Sun, 29 Apr 2001 01:22:03 -0400
Received: from ingpat.ingenuity.com ([216.200.60.240]:1237 "EHLO
	iserver.ingenuity.com") by vger.kernel.org with ESMTP
	id <S135678AbRD2FVr>; Sun, 29 Apr 2001 01:21:47 -0400
Message-ID: <6C6D58C130D5D411ABF200A0C9E9216A1145B2@iserver.ingenuity.com>
From: Royans Tharakan <RTharakan@ingenuity.com>
To: "'Matthias Andree'" <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Date: Sat, 28 Apr 2001 22:20:46 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No problems here... with 2.4.3 
Here is the dump from dmesg.

regards,
Royans

-------------
SCSI subsystem driver Revision: 1.00
aacraid raid driver version, Apr 28 2001
percraid device detected
Device mapped to virtual address 0xf8806000
percraid:0 device initialization successful
percraid:0 AacHba_ClassDriverInit complete
scsi0 : percraid
  Vendor: DELL      Model: PERCRAID Mirror   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35544577 512-byte hdwr sectors (18199 MB)
sda: Write Protect is off
Partition check:
 sda: sda1 sda2 < sda5 sda6 >
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Wide Channel B, SCSI Id=7, 32/255 SCBs
-----------------
bash-2.04$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 993.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1979.18
-----------------

-----Original Message-----
From: Matthias Andree [mailto:matthias.andree@stud.uni-dortmund.de]
Sent: Saturday, April 28, 2001 11:22 AM
To: Linux-Kernel mailing list
Subject: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda


Hi,

I have several machines here, with either onboard aic7880 or with
AHA2940 (I don't recall) sitting on the PCI bus, which share the same
problem: they fail to detect the first disk (Id #0). The information
below is from lspci and /proc/scsi/scsi of Linux 2.2.19, in that order,
all Kernels have been compiled on a Duron/800 SuSE 7.0 Linux box
(running gcc 2.95.2).

Machine #1:

Pentium-II (Klamath)

00:09.0 SCSI storage controller: Adaptec AIC-7881U

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST34572W         Rev: 0718
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39140W         Rev: 1498
  Type:   Direct-Access                    ANSI SCSI revision: 02

Machine #2:

Pentium-II (Deschutes)

00:09.0 SCSI storage controller: Adaptec AIC-7881U

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST34572N         Rev: 0784
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-32160       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02

These have further devices (CD writer, CD-ROM drive), and these machines
are 100% in 2.2.19. With 2.4.3 and 2.4.4-pre8, I get this problem
(pencil & paper copy for Machine #2, DO NOT "grep"):

AIC 7XXX EISA/VLB/PCI SCSI HBA DRIVER 6.1.5
aic7880: wide Channel A, SCSI ID=7, 16/255 SCBs
scsi0: SCSI host adapter emulation for IDE devices
PCI: found IRQ 5 for dev 00:09.0
scsi1:0:0:0: Attempting to queue an abort message.
             Command found on device queue
aic7xxx_abort returns 8194

Then, the Kernel detects the SECOND SCSI disk and attaches it as sda
(Linux 2.2 would mount that as sdb), the first disk is "gone" (Linux 2.2
would mount that as sda).  Regretfully, my root partition is on the
FIRST SCSI disk, so the kernel panicks since it cannot mount /.

That's all I copied in a hurry, maybe it's sufficient to debug, if not,
I can try to grab a null modem cable and catch the full sequence; I'd be
glad if someone could mention the "canonical" aic7xxx LILO append
parameters for a full debug trace in that case.

Bottom line: I'm not buying Adaptec SCSI host adaptors ever again.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
