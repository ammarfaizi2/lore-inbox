Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbULVXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbULVXMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbULVXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:12:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4530 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262076AbULVXMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:12:08 -0500
Date: Thu, 23 Dec 2004 10:11:43 +1100
From: Nathan Scott <nathans@sgi.com>
To: Joerg Sommrey <jo@sommrey.de>, Christoph Hellwig <hch@infradead.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041223101143.A702917@wobbly.melbourne.sgi.com>
References: <20041221185754.GA28356@sommrey.de> <20041222182606.GA14733@infradead.org> <20041222195203.GA24857@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041222195203.GA24857@sommrey.de>; from jo@sommrey.de on Wed, Dec 22, 2004 at 08:52:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 08:52:03PM +0100, Joerg Sommrey wrote:
> On Wed, Dec 22, 2004 at 06:26:06PM +0000, Christoph Hellwig wrote:
> > On Tue, Dec 21, 2004 at 07:57:54PM +0100, Joerg Sommrey wrote:
> > > Hello,
> > > 
> > > last night my box died with a kernel oops.  There was a backup
> > > running at that time. The setup:
> > > - 2 SATA disks + 1 SCSI disk
> > > - SATA partitions build up md-raid-arrays (level 0 and 1)
> > > - md-raid-devices and SCSI partitions are physical volumes for dm
> > > - dm logical volumes are used for xfs filesystems
> > > - backup is done on dm-snapshots of those filesystems
> > 
> > Given the strange backtrace and this enormous stack of drivers I bet
> > you're seeing a stack overflow.  

Hmm, I'm not real sure of that Christoph - this was inside a
kernel thread (xfsbufd) where there is almost nothing on the
stack at the point we dove into driver land.  Looked like a
genuine bug to me.  There were plenty of calls on the trace,
but I think several of those were badly guessed by the stack
dump code.  And a couple of registers having a memory poison
pattern looked a bit suspect.

> Does this mean that this kind of stuff just doesn't work?  I was running
> a 4K-stack kernel with this "stack of drivers" for quiet some time without
> problems.  The problems started around 2.6.9-pre-something.  Converting
> to 8K-stacks didn't help.  Is this only xfs related?

Certainly wasn't XFS using stack in the initial oops, perhaps
the lower layers, but I'm a bit sceptical.  Almost certainly
this is a device mapper snapshot problem, the DM folks should
be able to analyse it further.

cheers.

-- 
Nathan
