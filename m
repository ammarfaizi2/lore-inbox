Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSIOEN6>; Sun, 15 Sep 2002 00:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSIOEN6>; Sun, 15 Sep 2002 00:13:58 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:24480 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317742AbSIOEN4>;
	Sun, 15 Sep 2002 00:13:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>
Subject: Re: [2.5] DAC960
Date: Sun, 15 Sep 2002 06:21:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <20020910062030.GL8719@suse.de>
In-Reply-To: <20020910062030.GL8719@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qQum-0001qO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 08:20, Jens Axboe wrote:
> On Tue, Sep 10 2002, Samium Gromoff wrote:
> >       Hello folks, i`m looking at the DAC960 driver and i have
> > realised its implemented at the block layer, bypassing SCSI.
> > 
> >    So given i have some motivation to have a working 2.5 DAC960
> > driver (i have one, being my only controller)
> > i`m kinda pondering the matter.
> > 
> >    Questions:
> >        1. Whether we need the thing to be ported to SCSI
> > layer, as opposed to leaving it being a generic block device? (i suppose yes)
> 
> No

A somewhat curt reply, it could be seen as a brush-off.  I believe the
whole story goes something like this: the scsi system is a festering
sore on the whole and eventually needs to be rationalized.  But until
that happens, we should basically just keep nursing along the various
drivers that should be using a generic interface, until there really
is a generic interface around worth putting in the effort to port to.

Linus indicated at the Kernel Summit that he'd like to see a
cleaned-up scsi midlayer used as framework for *all* disk IO,
including IDE.  Obviously, what with IDE transitions and whatnot, we
are far from being ready to attempt that, so see "nursing along"
above.  There's no longer any chance that a generic disk midlayer is
going to happen in this cycle, as far as I can see.  Still, anybody
who is interested would do well by studing the issues, and fixing
broken drivers certainly qualifies as a way to come up to speed.

> >        2. Which 2.5 SCSI driver should i use as a start of learning?
> 
> Don't bother

Ah, a little harsh.  I'd say: study the DAC960 driver, study the
scsi midlayer, and study the new bio interface.  That's what I'm
doing.

> >        3. Whether the SCSI driver API would change during 2.5?
> 
> Possibly
> 
> The DAC960 mainly needs updating to the pci dma api, and to be adjusted
> for the bio changes. Please coordinate with Daniel Philips (and check
> the list archives, we had a talk about this very driver some weeks ago),
> since he's working on making it work in 2.5 again as well.

Yep, starting with reconfiguring the datacentre over here, so I can
run a serial cable from my wife's machine to the to the closet the
machine with the DAC960 is in, because I'll be dammed if I'm going
to do this without kgdb.  Then the serial traffic goes from her
machine over the wireless network to my laptop in the living room,
where I hack in relative comfort.  While she surfs and emails.  Try
that with Windows :-)

That part took a long time because it certain aging RPM distribution
needed to be replaced by a shiny new Debian Sid, and it had to be
done without taking the machine offline, except to reboot.  All I
could wish for now is power cycle over the net, and this will be
civilized.

I suppose my serious work on this will start on Monday.

-- 
Daniel
