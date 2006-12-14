Return-Path: <linux-kernel-owner+w=401wt.eu-S932678AbWLNU1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWLNU1a (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWLNU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:27:30 -0500
Received: from brick.kernel.dk ([62.242.22.158]:29308 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932678AbWLNU13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:27:29 -0500
Date: Thu, 14 Dec 2006 21:28:54 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061214202854.GM5010@kernel.dk>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <200612142016.55286.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612142016.55286.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Alistair John Strachan wrote:
> On Thursday 14 December 2006 19:57, Linus Torvalds wrote:
> > On Thu, 14 Dec 2006, Alistair John Strachan wrote:
> > > `hddtemp' has stopped working on 2.6.20-rc1:
> >
> > Hmm. Can you do the strace on a working kernel too? For example, is it
> > that the 0x30d ioctl (which is HDIO_GET_IDENTITY) used to work? If it's a
> > SATA device, and you _used_ to use the PATA drivers, some of the old
> > IDE-only ioctl's simply don't work when used in native SATA
> > configurations.
> 
> I've always been using sata_nv and libata. All the drives in question are SATA 
> devices, no configuration change other than this kernel has taken place.
> 
> Indeed, the configs are very similar. Find the configs, straces on both 
> kernels, and the hddtemp binary (AMD64, I'm afraid) here:
> 
> http://devzero.co.uk/~alistair/2.6.20-rc1-hddtemp/

Looking at the strace, it would _seem_ that an SG_IO failure could very
well be the reason for the diverged paths. And that would indicate
another bug in that area, outside of what we already fixed for
2.6.20-rc1.

Is the hddtemp source not available?

> > If you can do a "git bisect" on this, that would help a lot.
> 
> I'll do that if nobody comes up with anything obvious.

If you can just test 2.6.19-git1, then we'll know if it's the SG_IO
patch again.

-- 
Jens Axboe

