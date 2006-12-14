Return-Path: <linux-kernel-owner+w=401wt.eu-S1751080AbWLNT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWLNT6O (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWLNT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:58:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52709 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbWLNT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:58:13 -0500
Date: Thu, 14 Dec 2006 11:57:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Linux 2.6.20-rc1
In-Reply-To: <200612141930.19797.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612141930.19797.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Alistair John Strachan wrote:
> 
> `hddtemp' has stopped working on 2.6.20-rc1:

Hmm. Can you do the strace on a working kernel too? For example, is it 
that the 0x30d ioctl (which is HDIO_GET_IDENTITY) used to work? If it's a 
SATA device, and you _used_ to use the PATA drivers, some of the old 
IDE-only ioctl's simply don't work when used in native SATA 
configurations.

[ Side note: I consider that to be a mis-feature, but it's not a new 
  regression, it's always been that way: different block subsystems have 
  had their own "private" ioctl spaces.

  We've been moving more and more towards a unified space, and we could 
  probably make scsi_ioctl.c emulate at least _some_ of the HDIO_xxx calls 
  too, and try to support all the block ioctl's on all block devices 
  rather than have some that work only on some certain class of hardware. 

  But we're not there yet, and in the meantime it will actually make a 
  difference whether you use your disks through the kernel SCSI layer 
  (SATA and /dev/sdX) or through the IDE layer (IDE and /dev/hdX) ]

On the other hand, this _sounds_ very much like a bug that should have 
been fixed before 2.6.20-rc1, which affected SG_IO. 

If you can do a "git bisect" on this, that would help a lot.

(Btw, where is "hddtemp" from, anyway? Doesn't seem to be part of the 
standard set of tools I have on any of my systems)

		Linus
