Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135455AbRDMJq2>; Fri, 13 Apr 2001 05:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135456AbRDMJqS>; Fri, 13 Apr 2001 05:46:18 -0400
Received: from ems.flashnet.it ([194.247.160.44]:18450 "EHLO relay.flashnet.it")
	by vger.kernel.org with ESMTP id <S135455AbRDMJqN>;
	Fri, 13 Apr 2001 05:46:13 -0400
Date: Fri, 13 Apr 2001 11:45:59 +0200
From: David Santinoli <u235@libero.it>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx: first mount always fails
Message-ID: <20010413114559.A1133@aidi.santinoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The first attempt at mounting a disc in my Traxdata CDR drive after boot always
fails. From the second on, everything works flawlessly.
Current setup is 2.2.18 kernel + 6.1.11-2.2.18 patch, but I've been experiencing
this behaviour since I bought the adapter (around 2.2.12 or so).
aic7xxx gets loaded as a module.
Here's some diagnostic info from the failed mount. If more is needed, please let
me know.
(of course, a disc _is_ present in the drive).

# modprobe aic7xxx

Apr 13 11:20:04 aidi kernel: ahc_pci:0:12:0: Host Adapter Bios disabled.  Using default SCSI device parameters 
Apr 13 11:20:04 aidi kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11 
Apr 13 11:20:04 aidi kernel:         <Adaptec 2902/04/10/15/20/30C SCSI adapter> 
Apr 13 11:20:04 aidi kernel:         aic7850: Single Channel A, SCSI Id=7, 3/255 SCBs 
Apr 13 11:20:04 aidi kernel:  
Apr 13 11:20:04 aidi kernel: scsi : 1 host. 
Apr 13 11:20:10 aidi kernel:   Vendor: Traxdata  Model: CDR4120           Rev: 5.0L 
Apr 13 11:20:10 aidi kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Apr 13 11:20:10 aidi kernel: (scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15) 


# mount /dev/sr0 /mnt/cd2

Apr 13 11:21:39 aidi kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0 
Apr 13 11:22:09 aidi kernel: scsi0:0:6:0: Attempting to queue an ABORT message 
Apr 13 11:22:09 aidi kernel: (scsi0:A:6:0): Queuing a recovery SCB 
Apr 13 11:22:09 aidi kernel: scsi0:0:6:0: Device is disconnected, re-queuing SCB 
Apr 13 11:22:09 aidi kernel: Recovery code sleeping 
Apr 13 11:22:09 aidi kernel: (scsi0:A:6:0): Abort Message Sent 
Apr 13 11:22:09 aidi kernel: (scsi0:A:6:0): SCB 3 - Abort Completed. 
Apr 13 11:22:09 aidi kernel: Recovery SCB completes 
Apr 13 11:22:09 aidi kernel: Recovery code awake 
Apr 13 11:22:09 aidi kernel: aic7xxx_abort returns 8194 
Apr 13 11:22:09 aidi kernel: scsi0:0:6:0: Attempting to queue a TARGET RESET message 
Apr 13 11:22:09 aidi kernel: scsi0:0:6:0: Command not found 
Apr 13 11:22:09 aidi kernel: aic7xxx_dev_reset returns 8194 
Apr 13 11:22:14 aidi kernel: sr0: CD-ROM not ready.  Make sure you have a disc in the drive. 
Apr 13 11:22:14 aidi kernel: CD-ROM I/O error: dev 0b:00, sector 64 
Apr 13 11:22:14 aidi kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=32 


# lspci -v

[snip]
00:0c.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at 9800 [disabled]
        Memory at de800000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
[snip]

Cheers,
 David
