Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVIKOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVIKOwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVIKOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:52:43 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:27613 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932320AbVIKOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:52:42 -0400
Message-ID: <432444B6.7070309@gentoo.org>
Date: Sun, 11 Sep 2005 15:52:38 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Peeters <kasper.peeters@aei.mpg.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: crash upon rmmod aic7xxx (pcmcia)
References: <17188.9683.311780.197075@sbox13.aei.mpg.de>
In-Reply-To: <17188.9683.311780.197075@sbox13.aei.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Peeters wrote:
> Since the early 2.6.x kernels, removing the aic7xxx module (either by
> doing a 'rmmod' by hand or by ejecting the pcmcia aic7xxx card) locks
> the system hard after about 2 seconds, leaving no trace in syslog. 
> Just checked with kernel 2.6.13 (and pcmcia-tools 3.2.8).

Try enabling magic sysrq and press Alt+sysrq+9 then Alt+SysRq+P when the 
freeze occurs, and write down the call trace which hopefully appears on the 
console.

On a sidenote, this might be related to a Gentoo bug that I'm working on 
getting full details of:

http://bugs.gentoo.org/show_bug.cgi?id=102636

> Upon insertion of the pcmcia card, this appears in syslog:
> 
> Sep 11 14:36:05 whiteroom2 kernel: PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
> Sep 11 14:36:05 whiteroom2 kernel: ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKA] -> GSI 11 (level, low
> ) -> IRQ 11
> Sep 11 14:36:05 whiteroom2 kernel: aic7xxx: PCI Device 3:0:0 failed memory mapped test.  Using PIO.
> Sep 11 14:36:05 whiteroom2 kernel: ahc_pci:3:0:0: Host Adapter Bios disabled.  Using default SCSI device pa
> rameters
> Sep 11 14:36:05 whiteroom2 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> Sep 11 14:36:05 whiteroom2 kernel:         <Adaptec 1480A Ultra SCSI adapter>
> Sep 11 14:36:05 whiteroom2 kernel:         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
> Sep 11 14:36:05 whiteroom2 kernel: 
> Sep 11 14:36:12 whiteroom2 kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
> Sep 11 14:36:12 whiteroom2 kernel: scsi0: Signaled a Target Abort
> Sep 11 14:36:21 whiteroom2 kernel:   Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
> Sep 11 14:36:21 whiteroom2 kernel:   Type:   CD-ROM                             ANSI SCSI revision: 04
> Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: asynchronous.
> Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Beginning Domain Validation
> Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Domain Validation skipping write tests
> Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
> Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Ending Domain Validation
> Sep 11 14:36:21 whiteroom2 kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> Sep 11 14:36:21 whiteroom2 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 5
> Sep 11 14:36:22 whiteroom2 scsi.agent[3014]: cdrom at /devices/pci0000:00/0000:00:1e.0/0000:02:0a.0/0000:03
> :00.0/host0/target0:0:4/0:0:4:0
