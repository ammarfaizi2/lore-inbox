Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbRD1SWm>; Sat, 28 Apr 2001 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135589AbRD1SWc>; Sat, 28 Apr 2001 14:22:32 -0400
Received: from p3EE3C9BA.dip.t-dialin.net ([62.227.201.186]:34308 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135588AbRD1SW3>; Sat, 28 Apr 2001 14:22:29 -0400
Date: Sat, 28 Apr 2001 20:22:25 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010428202225.D11994@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
