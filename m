Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319007AbSHMRHE>; Tue, 13 Aug 2002 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319009AbSHMRHE>; Tue, 13 Aug 2002 13:07:04 -0400
Received: from host194.steeleye.com ([216.33.1.194]:56842 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S319007AbSHMRHD>; Tue, 13 Aug 2002 13:07:03 -0400
Message-Id: <200208131710.g7DHAof03116@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Tue, 13 Aug 2002 18:37:21 +0200." <20020813163721.GD32470@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 12:10:50 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
> I wouldn't mind unifying lots of the atapi and cdrom stuff. Most of
> the stuff I took care off was atapi and scsi cdrom unification, but it
> could be taken a step further. 

Yes, perhaps in conjunction with a rationalisation of command packet interface 
to struct request and the block queue that made no prejudgement of what 
actually the command was packetised for.  One modification I was thinking of 
would be simply to make struct_request.cmd a pointer rather than a char array. 
 That way, the prep functions can allocate it and fill it in with an arbitrary 
packet command to be interpreted by the downstream driver (it will also get us 
out of the command size limitation problem---of course, the SCSI committee 
would never consider another command size increase...)

> Come to think of it, the reason why I didn't completey unify SCSI
> request sense (eg) with cdrom stuff was that you quickly run into all
> sorts of ugliness with the various scsi versions, atapi version,
> reserved fields, added fields, etc. Something that looks good and
> should be good, suddenly breaks cdrom model XYZ that used to work
> (perhaps by chance) and still _ought_ to work. 

In fact, it would be a particularly deep and rancid can of worms?

> But hey, knock yourself out :-) 

Sure, by the time you've got a rational and unified interface that looks good, 
you'll probably have re-written big chunks of scsi and cdrom.  However, if you 
can come up with a good scheme for the sense codes, it would be nice (the ASC 
ASCQ code combinations are in a table that covers thirteen pages of close 
printed type in the SCSI spec---constants.c only has the more frequently used 
ones).

James


