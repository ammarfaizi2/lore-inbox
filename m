Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318952AbSICVss>; Tue, 3 Sep 2002 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSICVsk>; Tue, 3 Sep 2002 17:48:40 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:37360
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318952AbSICVsZ>; Tue, 3 Sep 2002 17:48:25 -0400
Subject: Re: aic7xxx sets CDR offline, how to reset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <200209032132.g83LWdD09043@localhost.localdomain>
References: <200209032132.g83LWdD09043@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 22:54:38 +0100
Message-Id: <1031090078.21439.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 22:32, James Bottomley wrote:
> I think the block layer, which already knows about the barrier ordering, is 
> the appropriate place for this.  If you think the scsi error handler is a 
> hairy wart now, just watch it grow into a stonking great carbuncle as I try to 
> introduce it to the concept of command queue ordering and appropriate recovery.

Point taken

> I agree with your reasoning.  However, errors occur infrequently enough (I 
> hope) so that its just not worth the extra code complexity to make the error 
> handler look for that case.

When you ar ehandling CD-ROM problems then they can be quite a lot. Not
helped by the fact some ancient CD's seem to like to take a long walk in
the park when told to reset.

> cancellation implementations, it's potentially full of holes.  The only uses 
> it might have---like oops I didn't mean to fixate that CD, give it back to me 
> now---aren't clearly defined in the SPEC to produce the desired effect (stop 
> the fixation so the drive door can be opened).

Yes but does windows assume it. There are two specs 8)

> The pain of coming back from a reset (and I grant, it isn't trivial) is well 
> known and well implemented in SCSI.  It also, from error handlings point of 
> view, sets the device back to a known point in the state model.
> 

Resetting the bus is antisocial to say the least. We had lots of hangs
with the old eh handler that went away when the new one didnt keep
resetting the bus. If we do reset the bus then we have to handle "Sorry
can't reset the bus" (we have cards that can't or won't) as well as
being conservative about timings, making sure we don't reset the bus
during the seconds while a device rattles back into online state and so
on.

