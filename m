Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSHMQdx>; Tue, 13 Aug 2002 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSHMQdx>; Tue, 13 Aug 2002 12:33:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57485 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318215AbSHMQdv>;
	Tue, 13 Aug 2002 12:33:51 -0400
Date: Tue, 13 Aug 2002 18:37:21 +0200
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020813163721.GD32470@suse.de>
References: <200208131621.g7DGLc202919@localhost.localdomain> <Pine.LNX.4.33L2.0208130922300.5175-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0208130922300.5175-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13 2002, Randy.Dunlap wrote:
> On Tue, 13 Aug 2002, James Bottomley wrote:
> 
> | rddunlap@osdl.org said:
> | > and that's precisely the wrong attitude IMO.
> |
> | I wasn't expressing an opinion, just stating what could and could not be done
> | in 2.4.
> 
> I guess that at least Jens and I (not trying to speak for Jens)
> see it as a style issue and somewhat as an education issue.
> At least we both used /IMO/i.

Right!

> | > I was glad to see that Marcelo asked about the hardcoded values. They
> | > hurt.
> |
> | Well, this is a rather big and particularly rancid can of worms.  If you look
> | a little further, you'll see that cdrom.h has its own definition of the
> | (effectively SCSI) struct request_sense that sr.c uses, yet the sense key is
> | defined in scsi/scsi.h.  Then you notice that cdrom.h also duplicates all of
> | the scsi commands with a GPCMD_ prefix.
> |
> | If you'd like to take this particular can of worms off somewhere, clean it out
> | and return it neatly labelled, I'd be more than grateful...just don't take the
> | lid off too close to me.
> 
> I'm not sure that it could ever get by Jens, but I'll take a look at it.

You make me sound like an old grump [1] :-)

I wouldn't mind unifying lots of the atapi and cdrom stuff. Most of the
stuff I took care off was atapi and scsi cdrom unification, but it could
be taken a step further.

GPCMD_ means general packet command, and signifies a command that is the
same for atapi and scsi.

Come to think of it, the reason why I didn't completey unify SCSI
request sense (eg) with cdrom stuff was that you quickly run into all
sorts of ugliness with the various scsi versions, atapi version,
reserved fields, added fields, etc. Something that looks good and should
be good, suddenly breaks cdrom model XYZ that used to work (perhaps by
chance) and still _ought_ to work.

But hey, knock yourself out :-)

[1] I'm not old

-- 
Jens Axboe

