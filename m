Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWHVOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWHVOpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHVOpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:45:13 -0400
Received: from 81-179-62-49.dsl.pipex.com ([81.179.62.49]:38568 "EHLO
	jaguar.linux-grotto.org.uk") by vger.kernel.org with ESMTP
	id S932279AbWHVOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:45:11 -0400
Message-ID: <44EB1875.3020403@linux-grotto.org.uk>
Date: Tue, 22 Aug 2006 15:45:09 +0100
From: Johan Groth <johan.groth@linux-grotto.org.uk>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Scsi errors with Megaraid 300-8x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
ever since I upgraded my server from a dual Opteron 244 (mobo Tyan 2885) 
system to a dual dual-core Opteron 285 (mobo Tyan 2895) system, I'm 
getting read errors that freezes the system which leads to my disk based 
backup software stopped working (faubackup). I think it is faubackup 
that triggers the bug.

I get these errors in the log:
Aug 20 06:35:08 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:35:56 jaguar kernel: end_request: I/O error, dev sda, sector 
616924530
Aug 20 06:36:03 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:03 jaguar kernel: end_request: I/O error, dev sda, sector 
616924538
Aug 20 06:36:03 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:03 jaguar kernel: end_request: I/O error, dev sda, sector 
616924546
Aug 20 06:36:03 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:03 jaguar kernel: end_request: I/O error, dev sda, sector 
616924554
Aug 20 06:36:07 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:07 jaguar kernel: end_request: I/O error, dev sda, sector 
616924562
Aug 20 06:36:07 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:07 jaguar kernel: end_request: I/O error, dev sda, sector 
616924570
Aug 20 06:36:07 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:07 jaguar kernel: end_request: I/O error, dev sda, sector 
616924578
Aug 20 06:36:07 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 0x40001
Aug 20 06:36:07 jaguar kernel: end_request: I/O error, dev sda, sector 
616924538

The last sector is repeated until I reboot the machine. The only 
difference I've made to the raid configuration is that sdc is now 2x250 
MB instead of 4x120MB, but that array is the target not the source (sda).
The raid HW is an LSI Megaraid 300-8x with the following configuration:

Host: scsi0 Channel: 01 Id: 00 Lun: 00
   Vendor: MegaRAID Model: LD 0 RAID0  312G Rev: 814D
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 01 Id: 01 Lun: 00
   Vendor: MegaRAID Model: LD 1 RAID0  312G Rev: 814D
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 01 Id: 02 Lun: 00
   Vendor: MegaRAID Model: LD 2 RAID0  474G Rev: 814D
   Type:   Direct-Access                    ANSI SCSI revision: 02

I'm running debian sid stock kernel 2.6.17.

Other hw changes that may, may not affect the kernel:
CPU: dual core, hence the kernel sees 4 cpus, before 2.
Removed a sound card, a CS46xx card and am using internal sound instead.
Installed a DVB-T Freeview card (digital TV).
More RAM, 2GB instead 1.

Should mention that I used to use 2.6.16 on the old system, but I've 
checked in the kernel tree and no changes has been made to the megaraid 
drivers since April, I think.

Can anyone help me?
Please, CC me as I'm not subscribed.

Regards,
Johan
