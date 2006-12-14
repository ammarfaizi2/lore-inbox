Return-Path: <linux-kernel-owner+w=401wt.eu-S1751872AbWLNTaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWLNTaJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWLNTaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:30:08 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:3415 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751872AbWLNTaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:30:07 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc1
Date: Thu, 14 Dec 2006 19:30:19 +0000
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141930.19797.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

`hddtemp' has stopped working on 2.6.20-rc1:

[root] 19:25 [~] hddtemp /dev/sda /dev/sdb /dev/sdc /dev/sdd
/dev/sda: ATA WDC WD2500KS-00M: S.M.A.R.T. not available
/dev/sdb: ATA WDC WD2500KS-00M: S.M.A.R.T. not available
/dev/sdc: ATA Maxtor 6B200M0: S.M.A.R.T. not available
/dev/sdd: ATA Maxtor 6B200M0: S.M.A.R.T. not available

Stracing the binary reveals:

open("/dev/sdd", O_RDONLY|O_NONBLOCK)   = 3
ioctl(3, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a0636c) = 0
ioctl(3, SG_IO, 0x7fffe8a06020)         = 0
ioctl(3, SG_IO, 0x7fffe8a06040)         = 0
ioctl(3, 0x30d, 0x506b80)               = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(3, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a06384) = 0
ioctl(3, SG_IO, 0x7fffe8a06240)         = 0
open("/dev/sdc", O_RDONLY|O_NONBLOCK)   = 4
ioctl(4, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a0636c) = 0
ioctl(4, SG_IO, 0x7fffe8a06020)         = 0
ioctl(4, SG_IO, 0x7fffe8a06040)         = 0
ioctl(4, 0x30d, 0x506b80)               = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(4, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a06384) = 0
ioctl(4, SG_IO, 0x7fffe8a06240)         = 0
open("/dev/sdb", O_RDONLY|O_NONBLOCK)   = 5
ioctl(5, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a0636c) = 0
ioctl(5, SG_IO, 0x7fffe8a06020)         = 0
ioctl(5, SG_IO, 0x7fffe8a06040)         = 0
ioctl(5, 0x30d, 0x506b80)               = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(5, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a06384) = 0
ioctl(5, SG_IO, 0x7fffe8a06240)         = 0
open("/dev/sda", O_RDONLY|O_NONBLOCK)   = 6
ioctl(6, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a0636c) = 0
ioctl(6, SG_IO, 0x7fffe8a06020)         = 0
ioctl(6, SG_IO, 0x7fffe8a06040)         = 0
ioctl(6, 0x30d, 0x506b80)               = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(6, SCSI_IOCTL_GET_BUS_NUMBER, 0x7fffe8a06384) = 0
ioctl(6, SG_IO, 0x7fffe8a06240)         = 0
ioctl(6, SG_IO, 0x7fffe8a05d20)         = 0

Is there a known workaround for this?

SMART is enabled in the BIOS and it's available in 2.6.19.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
