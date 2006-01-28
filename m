Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWA1TbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWA1TbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWA1TbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:31:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750701AbWA1TbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:31:04 -0500
Date: Sat, 28 Jan 2006 20:27:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Ariel <askernel2615@dsgml.com>, Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060128192744.GJ9750@suse.de>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz> <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com> <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz> <20060123072556.GC15490@fifty-fifty.audible.transient.net> <20060123083347.GA12773@suse.de> <20060127112846.GA29829@fifty-fifty.audible.transient.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127112846.GA29829@fifty-fifty.audible.transient.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Jamie Heilman wrote:
> Jens Axboe wrote:
> > On Sun, Jan 22 2006, Jamie Heilman wrote:
> > > Ariel wrote:
> > > > ata_piix seems like it's in common for all, but this is not a lot of 
> > > > systems, so it could just be a coincidence and the problem caused by 
> > > > something that's not chipset specific.
> > > 
> > > Hmm.  I just moved my sata_sil stuff out of the way and rebooted:
> > > 
> > > $ uptime; grep scsi_cmd_cache /proc/slabinfo
> > >  23:22:16 up 4 min,  1 user,  load average: 0.00, 0.03, 0.00
> > > scsi_cmd_cache      1200   1200    384   10    1 : tunables   54   27   8 : slabdata    120    120      0
> > > 
> > > My other workstation also runs 2.6.15.1 but uses sata_nv and doesn't
> > > exhibit the problem.
> > 
> > The SATA low level driver is very unlikely to play a role in this. But
> > you are both using md (raid1 to be specific) on top of scsi, I'd say
> > that's the best clue. I'd very much doubt the nvidia module as well.
> 
> True, my sata_nv box doesn't use md.  OTOH, my machines running raid1
> on an LSI (MPT Fusion driver) SCSI controller don't have this leak.

Those SCSI LLD don't support ordered flush barriers, that's why.

-- 
Jens Axboe

