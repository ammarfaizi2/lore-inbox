Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314338AbSDRM5f>; Thu, 18 Apr 2002 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSDRM5e>; Thu, 18 Apr 2002 08:57:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36616 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314338AbSDRM5e>;
	Thu, 18 Apr 2002 08:57:34 -0400
Date: Thu, 18 Apr 2002 14:57:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020418125707.GE2492@suse.de>
In-Reply-To: <20020416102510.GI17043@suse.de> <20020416200051.7ae38411.sebastian.droege@gmx.de> <20020416180914.GR1097@suse.de> <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418142636.10201a7f.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, Sebastian Droege wrote:
> On Thu, 18 Apr 2002 13:20:15 +0200
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> > Sebastian Droege wrote:
> > > On Wed, 17 Apr 2002 12:42:39 +0200
> > > Martin Dalecki <dalecki@evision-ventures.com> wrote:
> > > 
> > > 
> > >>>2.
> > >>>when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> > >>>hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) 
> > >>
> > >> > but the problem shows up only with hdc
> > >>
> > >>Duh oh... This is actually a good hint. I will look after
> > >>this.
> > >>
> > >>
> > >>>and maybe a third problem ;)
> > >>>in /proc/ide/ide0/hda/tcq there is written:
> > >>>DMA status: not running
> > >>
> > >>This is harmless it just shows that there was no DMA transfer in flight the
> > >>time you have cat-ed this file.
> > >>
> > >>
> > >>>but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
> > >>>
> > >>>I'll do some more testings later the day
> > >>
> > > Hi again,
> > > after some playing with hdparm I found something bad :(
> > > 
> > > ide_tcq_intr_timeout: timeout waiting for interrupt
> > > ide_tcq_intr_timeout: hwgroup not busy
> > > hda: invalidating pending queue
> > > ide_tcq_invalidate_queue: done
> > > 
> > > and then... nothing works anymore -> total lockup of the IDE system
> > > This happens only (?) when I put hdparm -qa1 -qA1 -qc1 -qd1 -qm16 -qu1 -qW1 /dev/hda (the same with hdb) in my bootscripts
> > > When I start hdparm later everything works fine first, but after a while (and when I'm under X) the IDE system is crashed
> > > 
> > > I have enabled following options:
> > > CONFIG_BLK_DEV_IDE_TCQ=y
> > > CONFIG_BLK_DEV_IDE_TCQ_FULL=y
> > > CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
> > > CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
> > > 
> > > I hope this helps somehow but I don't know what further informations I can provide
> > > 
> > > BTW: I think we should create devfs entries for ide-scsi devices (because hdparm doesn't take scdX ;) )
> > > 
> > > Bye
> > 
> > I don't know whatever you have already tryed the recend patches for 2.5.8.
> > The problem in place is presumably fixed there (tough there are still
> > problems with ide-cd remaining which I'm working on right now.)
> > 
> This problem exists also with your newest ide patches (I think 39 is the newest)
> And again: I don't see how ide-cd can cause this problem... I access my cdroms via scsi-emulation and ide-cd isn't compiled into the kernel

Try disabling the CONFIG_BLK_DEV_IDE_TCQ_FULL option.

-- 
Jens Axboe

