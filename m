Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSGRMMf>; Thu, 18 Jul 2002 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSGRMMf>; Thu, 18 Jul 2002 08:12:35 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:21007 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S318033AbSGRMMe>;
	Thu, 18 Jul 2002 08:12:34 -0400
Date: Thu, 18 Jul 2002 14:14:26 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: [PATCH] IDE TCQ
To: axboe@suse.de, linux-kernel@vger.kernel.org
Message-id: <3D36B122.E9D8A9C1@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Jens Axboe wrote: 
> On Mon, Apr 15 2002, Jens Axboe wrote: 
> > On Mon, Apr 15 2002, Aaron Tiensivu wrote: 
> > > Simple question but hopefully it has a simple answer.. is there a command 
> > > you can issue or flag you can look for from the output of hdparm to tell if 
> > > your hard drive is capable of TCQ before installing the patch? I have a few 
> > > IBM drives that I'm sure have TCQ abilities but I don't trust them as far as 
> > > I can throw them (being Hungarian and cursed) but I'd like to give TCQ a 
> > > whirl on my WD 120GB drives that should work OK, if they support TCQ.. 
> > > 
> > > Sorry if it's already been asked.. :) 
> > 
> > It has not been asked :-) 
> > 
> > You can run a IDENTIFY_DEVICE from user space with the task ioctls and 
> > look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If 
> > you give me the model identifier from the IBM drive, I can tell you if 
> > it has tcq or not... 
> > 
> > I'll write a small util to detect this tomorrow and send it to you + the 
> > list. 
> 
> Duh, you can of course just look at /proc/ide/ideX/hdY/identify and 
> parse that. The info above is still valid for that, of course :-) 

Recent versions of hdparm ( 4.x like shipped with recent redhat linux )
give a nice report about this :

hdparm -I /dev/hda  ( or maybe it is the -i option )

Interestingly , on my system it also says that both my ATAPI CD-ROMs
( one is a CD-RW :  Acer 1208A , the other is a CD-ROM : Teac CDR-532E-B
)
support ATA command overlap ( maybe queuing too, I don't recall right
now ).

Is overlapping supported in current TCQ code ? If not, will it be ?

It would be cool to access one drive in the seconds while the other
tries to
read a sector ( time from sending the read command, disc spinning up,
reading and delivering the sector can be up to 2 seconds ! )


Best regards,
david balazic
