Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbRDXVGK>; Tue, 24 Apr 2001 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDXVGB>; Tue, 24 Apr 2001 17:06:01 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:13452 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S132496AbRDXVFt>; Tue, 24 Apr 2001 17:05:49 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: dougg@torque.net, jgarzik@mandrakesoft.com
Subject: [PATCH] adding PCI bus information to SCSI layer
Date: Tue, 24 Apr 2001 16:02:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone for your input again.  I've made the changes suggested, and
would appreciate this being applied to Linus' and Alan's trees.  This is
necessary for solving the "what disk does BIOS think is my boot disk"
problem on IA-64, and I hope to extend it to IA-32 when BIOSs permit.

Jeff Garzik recommended the IOCTL return pci_dev::slot_name, so now it does,
and this simplifies the ioctl greatly.
Doug Gilbert recommended wrapping things in #ifdef's, so I created a new
CONFIG_SCSI_PCI_INFO define.

Patches against 2.4.4-pre6 are available at http://domsch.com/linux/scsi/.
linux-2.4.4-pre6-scsi-pci-info-010424.patch - Adds the IOCTL and
CONFIG_SCSI_PCI_INFO, and touches a bunch of SCSI drivers.
scsimon_243_1_pci-010424.patch - Changes scsimon Makefile and sm_test.c to
support this.
scsimon_243_1_pci_driver.patch - Changes scsimon.[ch] to support this.

When this goes in, I request the assistance of the SCSI driver maintainers.
I've changed quite a few drivers, but couldn't easily see how to change a
few others.  I am bcc'ing the maintainers of drivers I changed or need help
from.

Drivers that I changed:

3w-xxxx.c		
AM53C974.c		
advansys.c		
aic7xxx_old.c	
atp870u.c		
cpqfcTSinit.c	
dmx3191d.c
fdomain.c		
gdth.c		
ips.c			
ncr53c8xx.c		
qla1280.c		
qlogicfc.c		
qlogicisp.c		
sym53c8xx.c		
tmscsim.c		
megaraid.c		
53c7,8xx.c		
pci2000.c		
pci2220i.c		


Non-trivial drivers that I didn't change, but request their
maintainers do so:

BusLogic.c		
aic7xxx.c		
eata.c		
eata_dma.c		
eata_pio.c		
ini9100u.c		
inia100.c		


Drivers I didn't need to change (they're not PCI devices, best as I can
tell):
NCR53C9x.c
NCR53c406a.c
aha152x.c
aha1542.c
aha1740.c
esp.c
fd_mcs.c
ibmmca.c
ide-scsi.c
imm.c
in2000.c
mac53c94.c
mesh.c
ppa.c
qlogicfas.c
qlogicpti.c
sgiwd93.c
sim710.c
sym53c416.c
u14-34f.c
ultrastor.c
53c7xx.c
a2091.c
a3000.c
atari_scsi.c
dtc.c
fcal.c
g_NCR5380.c
gvp11.c
mac_scsi.c
mvme147.c
pas16.c
pluto.c
psi240i.c
seagate.c
sun3_scsi.c
t128.c
wd7000.c


Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux
