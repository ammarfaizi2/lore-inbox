Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVGFTsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVGFTsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVGFTpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:63690 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262138AbVGFOaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:30:10 -0400
Date: Wed, 6 Jul 2005 10:30:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
 B Memory Key
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C334F9369@psexc03.nbnz.co.nz>
Message-ID: <Pine.LNX.4.44L0.0507061021500.5278-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Roberts-Thomson, James wrote:

> Alan,
>  
> > Try putting delays at various spots in sd_revalidate_disk: 
> > the beginning, the middle, and the end.
> 
> OK, the attached patch works for me when sd_mod was loaded with delay_use=1.
> 
> Now I'm quite prepared to be told that this is a really horrible and
> inapproprate hack (given that I am not a kernel developer, I don't really
> know the "correct" way to solve this problem); and I'll cheerfully admit
> that it doesn't really solve the problem cleanly as can be seen below:

It would have been better simply to call msleep, but never mind.

> Jul  6 14:44:52 pc196344 kernel: sd: waiting for device to get ready.
> Jul  6 14:44:53 pc196344 kernel: sda: Unit Not Ready, sense:
> Jul  6 14:44:53 pc196344 kernel: : Current: sense key: Unit Attention
> Jul  6 14:44:53 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed
> Jul  6 14:44:53 pc196344 kernel: sda : READ CAPACITY failed.
> Jul  6 14:44:53 pc196344 kernel: sda : status=1, message=00, host=0,
> driver=08
> Jul  6 14:44:53 pc196344 kernel: sd: Current: sense key: Unit Attention
> Jul  6 14:44:53 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed
> Jul  6 14:44:53 pc196344 kernel: sda: test WP failed, assume Write Enabled
> Jul  6 14:44:53 pc196344 kernel: sda: assuming drive cache: write through

> Jul  6 14:44:53 pc196344 kernel: sd: waiting for device to get ready.
> Jul  6 14:44:54 pc196344 kernel: sda: Unit Not Ready, sense:
> Jul  6 14:44:54 pc196344 kernel: : Current: sense key: Unit Attention
> Jul  6 14:44:54 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed
> Jul  6 14:44:54 pc196344 kernel: sda : READ CAPACITY failed.
> Jul  6 14:44:54 pc196344 kernel: sda : status=1, message=00, host=0,
> driver=08
> Jul  6 14:44:54 pc196344 kernel: sd: Current: sense key: Unit Attention
> Jul  6 14:44:54 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed
> Jul  6 14:44:54 pc196344 kernel: sda: test WP failed, assume Write Enabled
> Jul  6 14:44:54 pc196344 kernel: sda: assuming drive cache: write through

> Jul  6 14:44:54 pc196344 kernel: sd: waiting for device to get ready.
> Jul  6 14:44:55 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
> sectors (131 MB)
> Jul  6 14:44:55 pc196344 kernel: sda: Write Protect is off
> Jul  6 14:44:55 pc196344 kernel: sda: Mode Sense: 03 00 00 00
> Jul  6 14:44:55 pc196344 kernel: sda: assuming drive cache: write through
> Jul  6 14:44:55 pc196344 kernel:  /dev/scsi/host5/bus0/target0/lun0: p1
> Jul  6 14:44:55 pc196344 kernel: Attached scsi removable disk sda at scsi5,
> channel 0, id 0, lun 0
> 
> There are three delays from my patch in the above list,

Yes.  Why are there three instead of just one?  The sd_revalidate_disk 
routine should only be called once (although a bug in recent kernels 
causes it to be called twice).

>  and increasing the
> delay to 3 seconds didn't help, as I got three one-second delays.  

I don't understand.  Why didn't you get three three-second delays?

> However, if someone with the appropriate knowledge could transform my kludge
> into a proper fix, then I would be very happy.

Can you try adding delays before, after, and inbetween the calls to 
sd_read_capacity, sd_read_write_protect_flag, and sd_read_cache_type, all 
near the end of sd_revalidate_disk?

> Alan, thanks very much for your help - I really appreciate the quick
> responses you have given me.
> 
> Note that I now have the output from the USB Snoop tool under Windows if
> anyone wants it - please ask if needed to help solve the issue "correctly".

Can you make it available on a web or ftp site and post the URL for 
interested parties?

Alan Stern

