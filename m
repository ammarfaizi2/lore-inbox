Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTINQMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 12:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbTINQMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 12:12:06 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:26895 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261188AbTINQMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 12:12:03 -0400
Date: Sun, 14 Sep 2003 18:12:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030914181201.E3371@pclin040.win.tue.nl>
References: <1063484193.1781.48.camel@mulgrave> <20030913212723.GA21426@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030913212723.GA21426@gtf.org>; from jgarzik@pobox.com on Sat, Sep 13, 2003 at 05:27:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 05:27:23PM -0400, Jeff Garzik wrote:

> IMO, we need to move users from a [probe-]order-based device and bus
> enumeration to some system based on unique ids.  I'm of the opinion
> that _both_ block devices and filesystems need some sort of GUID.
> Luckily, a lot of blkdevs/fs's are already there.
> 
> If you look at current usage out there, order isn't _terribly_ important
> given today's tools (such as LABEL=).  More important IMO is figuring
> out which spindle is your boot disk, and which is your root disk.
> Red Hat handles root disks by doing LABEL= from initrd.  But discovering
> the boot disk is still largely an unsolved problem AFAIK...

Such things are infinitely difficult.
Moreover, great care is needed - one has to define precisely what it
is this GUID is supposed to be an ID of.

(Is it the ZIP drive? Or is it the ZIP disk?
The 2.4 USB code is broken because it remembers a GUID and thinks that
identical GUID implies identical disk.)

I have a handful of CF/SM cardreaders.
Some of them have no form of ID. Others have an ID.

Then one can insert a CF or SM card into the reader.
Some of these cards have an ID. Some have not.

On the card one usually finds a FAT filesystem.
There may be a label. Or there may not be.

This describes a 3-level situation.
I have also 4-level situations, where the reader is filled with
one of four auxiliary adapters (each with an own ID) and the
adapter then get a CF/SM/SD/... card.

So, yes, we love IDs. And we can always provide them ourselves
as label or UUID or so in the filesystem.

But finding an unformatted unlabeled disk is difficult.

Andries

