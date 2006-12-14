Return-Path: <linux-kernel-owner+w=401wt.eu-S932764AbWLNUQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWLNUQl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWLNUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:16:41 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:2720 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932776AbWLNUQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:16:40 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc1
Date: Thu, 14 Dec 2006 20:16:55 +0000
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612142016.55286.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 19:57, Linus Torvalds wrote:
> On Thu, 14 Dec 2006, Alistair John Strachan wrote:
> > `hddtemp' has stopped working on 2.6.20-rc1:
>
> Hmm. Can you do the strace on a working kernel too? For example, is it
> that the 0x30d ioctl (which is HDIO_GET_IDENTITY) used to work? If it's a
> SATA device, and you _used_ to use the PATA drivers, some of the old
> IDE-only ioctl's simply don't work when used in native SATA
> configurations.

I've always been using sata_nv and libata. All the drives in question are SATA 
devices, no configuration change other than this kernel has taken place.

Indeed, the configs are very similar. Find the configs, straces on both 
kernels, and the hddtemp binary (AMD64, I'm afraid) here:

http://devzero.co.uk/~alistair/2.6.20-rc1-hddtemp/

> [ Side note: I consider that to be a mis-feature, but it's not a new
>   regression, it's always been that way: different block subsystems have
>   had their own "private" ioctl spaces.
>
>   We've been moving more and more towards a unified space, and we could
>   probably make scsi_ioctl.c emulate at least _some_ of the HDIO_xxx calls
>   too, and try to support all the block ioctl's on all block devices
>   rather than have some that work only on some certain class of hardware.
>
>   But we're not there yet, and in the meantime it will actually make a
>   difference whether you use your disks through the kernel SCSI layer
>   (SATA and /dev/sdX) or through the IDE layer (IDE and /dev/hdX) ]
>
> On the other hand, this _sounds_ very much like a bug that should have
> been fixed before 2.6.20-rc1, which affected SG_IO.
>
> If you can do a "git bisect" on this, that would help a lot.

I'll do that if nobody comes up with anything obvious.

> (Btw, where is "hddtemp" from, anyway? Doesn't seem to be part of the
> standard set of tools I have on any of my systems)

http://www.guzu.net/linux/hddtemp.php

I run this in monitor mode, and then use the gkrellm plugin to keep an eye on 
the disk temperatures. It's worked well for years, until now.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
