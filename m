Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUHISm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUHISm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUHISm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:42:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4536 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266830AbUHISjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:39:22 -0400
Date: Mon, 9 Aug 2004 20:38:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Kern Alexander <alexander.kern@siemens.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'alex.kern@gmx.de'" <alex.kern@gmx.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devic es
Message-ID: <20040809183857.GD28302@suse.de>
References: <DB51EBFA5812D611B6200002A528BC270379BF72@khes002a.khe1.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB51EBFA5812D611B6200002A528BC270379BF72@khes002a.khe1.siemens.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(if you don't cc me, I don't see your mail. it's been 4 days now. always
cc on linux-kernel, it's the etiquette!)

On Thu, Aug 05 2004, Kern Alexander wrote:
> Jens Axboe wrote:
> 
> > On Thu, Aug 05 2004, Joerg Schilling wrote:
> > 
> >>>From: Jens Axboe <axboe@suse.de>
> >>
> >>>ATA method is misnamed, it's really SG_IO that is used. And you want to
> >>>use that regardless of the device type, SCSI or ATAPI. There's no such
> >>>thing as an ATA burner, and there's no need to differentiate between
> >>>SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
> >>>forget browsing /proc/ide and other hacks.
> >>
> >>I am sorry but as Linux already has 6 different interfaces for sending 
> >>Generic SCSI commands and thus, we are running out of names.
> >>
> >>Let me give you an advise: consolidate Linux so that is does only need
> >>/dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
> >>unneeded interfaces.
> > 
> > 
> > That's been the general direction for quite some time, just that SG_IO
> > is the preferred method since that works all around. You were the one
> > that merged support for the CDROM_SEND_PACKET interface, which has
> > _never_ been advertised as a way to burn CDs in Linux. I'd suggest you
> > remove that.
> > 
> Silly, as I suggested a patch to Joerg, it was the uniquely ability to
> burn without ide-scsi. And known you, it simply works, it let me to
> scan for burners(what SG_IO cannot), it works in 2.4.X and 2.6.X.

Yes it simply works, as long as it works...

> Make SG_IO better and CDROM_SEND_PACKET will die, without your
> suggestions.

SG_IO is perfect as is, what problems are you referring to?

> P.S. I'm know that CDROM_SEND_PACKET has a overhead, by me it's 4%. I
> can live with it.

In 2.6, there is basically zero extra overhead with CDROM_SEND_PACKET,
since it's just a small wrapper on top of SG_IO (see scsi_ioctl.c if you
are curious), so you cannot measure a performance difference between the
two there.

In 2.4 it's orders of magnitude slower, since it will not use
CDROM_SEND_PACKET and it puts unnecessary strain on the memory allocator
to larger chunks of physically contigous memory. Note that you will not
see interrupt handler load if you are only doing casual performance
monitoring.

-- 
Jens Axboe

