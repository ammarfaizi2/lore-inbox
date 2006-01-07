Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWAGOTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWAGOTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWAGOTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:19:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28179 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030458AbWAGOTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:19:34 -0500
Date: Sat, 7 Jan 2006 15:19:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Jones <rowjones@cs.indiana.edu>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.13.4 aacraid: Partitioning array makes adapter go "dead"
Message-ID: <20060107141933.GJ3774@stusta.de>
References: <435BF66B.7040508@cs.indiana.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435BF66B.7040508@cs.indiana.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 03:45:31PM -0500, Robert Jones wrote:

>...
> Here's some information regarding the machine I'm having the problem with:
> 2-Way Dual-Core AMD Opteron 275's
> 8GB Reg ECC
> Tyan 2882-D (K8SD-Pro) motherboard (AMD-8000 series chipset)
> 2 Seagate ST336754LC's, updated to latest firmware (0004)
> Adaptec 2230S (updated to latest firmware, 8205)
> 
> The machine boots wonderfully with any kernel I have tried (2.6.9,
> 2.6.12.9, 2.6.13.4, 2.6.14-rc5; all kernels are vanilla kernels) and
> binds the array to /dev/sda, so long as the array is unpartitioned.
> Here's what the kernel reports when booting:

Is this problem still present in kernel 2.6.15?

> SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
> SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
>   sda: unknown partition table
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> 
> -----------
> 
> However, once I partition the array things begin to go wrong. While the
> partitioning succeeds, any point after this aacraid will state the
> controller is "dead". Here's what the kernel is telling me at this point:
> 
> -----------
> 
> SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
>   sda: sda1 sda2 sda3
> SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> sda: got wrong page
> sda: assuming drive cache: write through
>   sda: sda1 sda2 sda3
> 
> -----------
> 
> This looks fine too, however, when I reboot or try to access the array
> directly such as a mke2fs /dev/sda1, the kernel says this:
> 
> -----------
> 
> aacraid: Host adapter reset request. SCSI hang ?
> aacraid: Host adapter appears dead
> scsi: Device offlined - not ready after error recovery: host 0 channel 0
> id 0 lun 0
> sd 0:0:0:0: SCSI error: return code = 0x6000000
> end_request: I/O error, dev sda, sector 63
> Buffer I/O error on device sda1, logical block 0
> scsi0 (0:0): rejecting I/O to offline device
> Buffer I/O error on device sda1, logical block 0
> scsi0 (0:0): rejecting I/O to offline device
> Buffer I/O error on device sda1, logical block 64
> scsi0 (0:0): rejecting I/O to offline device
> Buffer I/O error on device sda1, logical block 64
> 
> -----------
> 
> The same machine will install Win2K w/ Adaptec's driver just fine, so I
> think the hardware is okay. I went ahead and pulled Adaptec's "official"
> aacraid implementation and replaced the "vanilla" implementation in
> 2.6.9 with it. Unfortunately, this did not seem to help.
> 
> Also, if I remove the partitions aacraid is happy again and will bind
> the array into /dev/sda as before. It's only after partitioning do
> things go bad.
>...
> Thanks,
> Robert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

