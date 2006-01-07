Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752558AbWAGPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbWAGPrA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbWAGPq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:46:59 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:15335 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1752552AbWAGPq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:46:59 -0500
Date: Sat, 7 Jan 2006 16:44:50 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Adrian Bunk <bunk@stusta.de>
cc: Robert Jones <rowjones@cs.indiana.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.13.4 aacraid: Partitioning array makes adapter go "dead"
In-Reply-To: <20060107141933.GJ3774@stusta.de>
Message-ID: <Pine.LNX.4.60.0601071622210.18374@kepler.fjfi.cvut.cz>
References: <435BF66B.7040508@cs.indiana.edu> <20060107141933.GJ3774@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Adrian Bunk wrote:

> On Sun, Oct 23, 2005 at 03:45:31PM -0500, Robert Jones wrote:
> 
> >...
> > Here's some information regarding the machine I'm having the problem with:
> > 2-Way Dual-Core AMD Opteron 275's
> > 8GB Reg ECC
> > Tyan 2882-D (K8SD-Pro) motherboard (AMD-8000 series chipset)
> > 2 Seagate ST336754LC's, updated to latest firmware (0004)
> > Adaptec 2230S (updated to latest firmware, 8205)
> > 
> > The machine boots wonderfully with any kernel I have tried (2.6.9,
> > 2.6.12.9, 2.6.13.4, 2.6.14-rc5; all kernels are vanilla kernels) and
> > binds the array to /dev/sda, so long as the array is unpartitioned.
> > Here's what the kernel reports when booting:
> 
> Is this problem still present in kernel 2.6.15?

Correct me if I'm wrong, but I think this was a problem of setting 
AAC_MAX_32BIT_SGBCOUNT in aacraid.h low enough, so that the transfer 
chunks (for big transfers) are small enough for various disks to handle 
it. For me 512 was low enough to work. I see now it's at 256. But that was 
just a temporary workaround AFAIK, it should have been solved by the "new 
comm" technology making it into the mainline. Mark Haverkamp missed the 
14 day window for new patches for 2.6.14, however it is in the 2.6.15 
allready, so I guess this may be fixed by

commit 8e0c5ebde82b08f6d996e11983890fc4cc085fab
Author: Mark Haverkamp <markh@osdl.org>
Date:   Mon Oct 24 10:52:22 2005 -0700

    [SCSI] aacraid: Newer adapter communication iterface support

    Received from Mark Salyzyn.

    This patch adds the 'new comm' interface, which modern AAC based
    adapters that are less than a year old support in the name of much
    improved performance. These modern adapters support both the legacy and
    the 'new comm' interfaces.

    Signed-off-by: Mark Haverkamp <markh@osdl.org>
    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

But I may be mistaken, though. (The symptoms are but very simmilar to 
those I witnessed in the past.)

...
> > -----------
> > 
> > aacraid: Host adapter reset request. SCSI hang ?
> > aacraid: Host adapter appears dead
> > scsi: Device offlined - not ready after error recovery: host 0 channel 0
> > id 0 lun 0
> > sd 0:0:0:0: SCSI error: return code = 0x6000000
> > end_request: I/O error, dev sda, sector 63
> > Buffer I/O error on device sda1, logical block 0
> > scsi0 (0:0): rejecting I/O to offline device
> > Buffer I/O error on device sda1, logical block 0
> > scsi0 (0:0): rejecting I/O to offline device
> > Buffer I/O error on device sda1, logical block 64
> > scsi0 (0:0): rejecting I/O to offline device
> > Buffer I/O error on device sda1, logical block 64
> > 
> > -----------
> >...
> > Thanks,
> > Robert
> 
> cu
> Adrian

Martin
