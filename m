Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272235AbTHNJQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHNJQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:16:16 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:33294 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272235AbTHNJQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:16:14 -0400
Date: Thu, 14 Aug 2003 11:16:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host doesn't support LBA48
Message-ID: <20030814111612.A2568@pclin040.win.tue.nl>
References: <200308140324.45524.bzolnier@elka.pw.edu.pl> <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 14, 2003 at 09:53:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:53:28AM +0100, Alan Cox wrote:
> On Iau, 2003-08-14 at 02:24, Bartlomiej Zolnierkiewicz wrote:
> >  	hwif->rqsize			= old_hwif.rqsize;
> > -	hwif->addressing		= old_hwif.addressing;
> > +	hwif->no_lba48			= old_hwif.no_lba48;
> 
> This change is a bad idea. Its called "addressing" because that is what
> it is about (see SATA and ATA specs). In future SATA addressing becomes
> a 0,1,2 value because 48bits isnt enough, it may get more forms beyond
> that.
> 
> Might be worth defining ADDR_LBA48, ADDR_LBA28 etc to make it clearer,
> but really people shouldnt be randomly hacking IDE code without having
> read the specifications.

Bartlomiej chose "no_lba48" (I had "cannot_do_lba48"), but otherwise
the change is mine. I will contradict you that it is a bad idea -
indeed, it is an excellent idea.
(Indeed, I made the change just for making the code more readable,
but immediately afterwards, reading this more readable code,
I understood why people had been experiencing filesystem corruption.)

Your strange remarks about reading specs - no doubt everybody who
touches IDE code knows the specs.

I don't know whether you saw my first post - but just to be sure let
me repeat a bit. There are two things that both are called addressing.
One is drive->addressing, and it is the enum that it looks like you
are thinking of. The other is hwif->addressing, and it is a boolean.
If this is ever changed then we have to visit all occurrences, and
also that is easier with the new name.

Andries

