Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTIPTzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTIPTzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:55:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262497AbTIPTzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:55:17 -0400
Date: Tue, 16 Sep 2003 21:55:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030916195515.GC906@suse.de>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org> <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916194955.GC5987@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16 2003, Jeff Garzik wrote:
> On Mon, Sep 15, 2003 at 09:34:45AM +0200, Jens Axboe wrote:
> > On Sat, Sep 13 2003, Jeff Garzik wrote:
> > > Oh, and I'm pondering the best way to deliver out-of-bang ATA taskfiles
> > > and SCSI cdbs to a device.  (for the uninitiated, this is lower level
> > > than block devices / cdrom devices / etc.)
> > > 
> > >  ... AF_BLOCK is not out of the question ;-)
> > 
> > Eh... I wont comment on that. I think we are way into Garzik lala land
> > there :)
> > 
> > I'd prefer just keeping sg_io_hdr, but dumping sg. A fully fledged bsg
> > (block sg) implementation. That way programs continue to work like
> > before on ATAPI/SCSI, for ATA we can use it as a task file transport.
> 
> I don't propose dumping the ugly "submit cdb/taskfile" ioctls, but we do
> need to deprecate them.  The ioctls are awful for throughput, async
> queueing, and the like.  And of course in general, ioctls are evil :)
> 
> And we should deprecate them with a solution that aligns what with Linus
> described in Dec 2001 on lkml:  a chrdev where userland write(2)s cdbs
> and taskfiles, and read(2)s the results.  This is where my thinking
> picked up:  if we are creating a chrdev to send "packets" and receive
> responses to those packets............  <insert conclusion here>

== bsg, block sg. Did you read what I wrote? :). I started implementing
this and have something that barely works. You just bind a block device
to a /dev/sg* char device and use read/write on that. Aka sg.

I don't want ioctls command submission interfaces more than you do.

-- 
Jens Axboe

