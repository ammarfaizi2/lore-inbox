Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbWLNUGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWLNUGI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWLNUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:06:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49105 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622AbWLNUGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:06:06 -0500
Message-ID: <4581AEA0.3040708@garzik.org>
Date: Thu, 14 Dec 2006 15:05:52 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 14 Dec 2006, Alistair John Strachan wrote:
>> `hddtemp' has stopped working on 2.6.20-rc1:
> 
> Hmm. Can you do the strace on a working kernel too? For example, is it 
> that the 0x30d ioctl (which is HDIO_GET_IDENTITY) used to work? If it's a 
> SATA device, and you _used_ to use the PATA drivers, some of the old 
> IDE-only ioctl's simply don't work when used in native SATA 
> configurations.
> 
> [ Side note: I consider that to be a mis-feature, but it's not a new 
>   regression, it's always been that way: different block subsystems have 
>   had their own "private" ioctl spaces.
> 
>   We've been moving more and more towards a unified space, and we could 
>   probably make scsi_ioctl.c emulate at least _some_ of the HDIO_xxx calls 
>   too, and try to support all the block ioctl's on all block devices 
>   rather than have some that work only on some certain class of hardware. 

FWIW, libata generally follows a "implement it, if enough people care 
about it" policy for the old HDIO_xxx ioctls.

There are plenty of HDIO_xxx ioctl should that have died back in the 
days when people using the 'hd' driver rather than the newfangled IDE 
driver.

So this change sorta filters out a lot of those older ioctls.

hddtemp is open source and reasonably well known, so I would certainly 
like to support it, if its reasonable.  For ATA disks, obtaining the 
temperature sometimes requires vendor-specific or firmware-specific 
knowledge.  hddtemp centralizes all that info in a database.

	Jeff


