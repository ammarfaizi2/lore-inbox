Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTAZQPB>; Sun, 26 Jan 2003 11:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTAZQPB>; Sun, 26 Jan 2003 11:15:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19106 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266958AbTAZQPA>;
	Sun, 26 Jan 2003 11:15:00 -0500
Date: Sun, 26 Jan 2003 17:23:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030126162348.GP889@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <b0qvta$fo6$1@forge.intermeta.de> <20030124092616.GH910@suse.de> <20030125142547.GB18989@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125142547.GB18989@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25 2003, Gregoire Favre wrote:
> On Fri, Jan 24, 2003 at 10:26:16AM +0100, Jens Axboe wrote:
> 
> > The interesting part is whether failed has a sense attached, and if so
> > what length.
> > > 
> > > >                cdrom_analyze_sense_data(drive, failed, sense);
> > 
> > To avoid confusion, I made the patch. Would have been easier to do in
> > the first place it seems :)
> > 
> > ===== drivers/ide/ide-cd.c 1.35 vs edited =====
> > --- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
> > +++ edited/drivers/ide/ide-cd.c	Fri Jan 24 10:25:53 2003
> > @@ -649,6 +649,8 @@
> >  		struct cdrom_info *info = drive->driver_data;
> >  		void *sense = &info->sense_data;
> >  		
> > +		if (failed && blk_pc_request(failed))
> > +			printk("%s: failed, sense %p, len=%d\n", __FUNCTION__, failed->sense, failed->sense_len);
> >  		if (failed && failed->sense)
> >  			sense = failed->sense;
> 
> Hello,
> 
> sorry I didn't understood that I was supposed to do this...
> I have recompiled with your patch, and here the result of dmesg:
> 
> cdrom_end_request: failed, sense ce68de20, len=0
> cdrom_end_request: failed, sense ce68de20, len=0

Thanks, this is the info I wanted. The sense info has not been read from
the drive, it seems.

-- 
Jens Axboe

