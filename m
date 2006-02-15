Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWBOVbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWBOVbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWBOVbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:31:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62386
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751295AbWBOVbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:31:35 -0500
From: Rob Landley <rob@landley.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 15 Feb 2006 16:31:27 -0500
User-Agent: KMail/1.8.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602151409.41523.rob@landley.net> <20060215195039.GS29938@csclub.uwaterloo.ca>
In-Reply-To: <20060215195039.GS29938@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151631.27964.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 2:50 pm, Lennart Sorensen wrote:
> > Or you could use raid and get complete redundancy rather than two paths
> > to the same single point of failure.  Your choice.
>
> How do you share a raid between two systems?  I know you probably can't
> make every redundant, but you can try. :)
>
> I would expect a raid of drives handled by different systems being a
> possible setup.  I remember systems setup that way with scsi in the
> past, although they had the major flaw that the raid had a single scsi
> bus connected to two machines at once.  If the bus went wrong you still
> lost everything.  With SAS that isn't a problem anymore.

In the previous six-drive thing, there was discussion about whether or not it 
made sense to do mirroring on top of raid 5 in one system, or have two 
separate systems each with a three drive raid 5 and the whole 
heartbeat/failover thing HP was so proud of at the time.  (Which if they're 
in the same room are still vulnerable to the same backhoe/flood...)

I don't remember what actually got implemented, it was years ago and I wasn't 
involved in the actual implementation...

> > If it uses a PHY then it's gig ethernet under the covers.  Each hop is a
> > point to point connection, but throwing switches in there isn't exactly a
> > new problem.  When demand arrives, I expect supply will catch up.
>
> So they are 1.5 and 3 Gbit ethernet?

More or less.  The driving factor is economies of scale in belting out 
millions of identical high speed transceivers, but I doubt anyone's using 
Intel part #82544 in hard drives:
http://www.intel.com/design/network/products/lan/controllers/82544.htm

No, they're using Intel part #31244:
http://www.intel.com/design/storage/serialata/gd31244.htm

Which is, of course, entirely different.

The general design of something that sends a gigabit signal over all the 
unshielded twisted pair already in people's walls was a hard problem.  But 
once it was solved it meant that you could use cheap unshielded cables for 
SATA too.  That lack of shielding seems to seriously freak out all the 
old-school electrical engineers, who keep predicting doom and gloom for data 
that goes over them:

http://www.ata-atapi.com/sata.htm

> Well I guess if you consider 
> anything that runs a serial stream at a certain speed to be gigabit.

Considering that USB 1.0 used a shielded cable, it seems unlikely that SATA 
_wouldn't_ unless they were leveraging PHY development that had as one of its 
initial design constraints "we have all this installed cat 5, it's not 
shielded, and you will use it". 

> Of  course gigabit ethernet on twisted pair runs much lower clock rates and
> uses 4 parallel streams.

Quoting from the above "doom and gloom" link:

> SATA uses a 7 wire interface. Three of the wires are ground signals. The
> other 4 are two pairs of differential signals - one pair in each direction.
...
> Today's hardware runs at 1.5GHz and should be at 3GHz soon. ATA commands,
> status and data are transmitted in packets on this interface.

Sound familiar?

> > I still don't see why drives are expected to be more reliable than
> > controllers.
>
> They are not, that is why you have raid.  But controllers can fail too,
> as can cables.  So you want two cables per drive and two controllers
> too.

And if you use SATA instead of SAS then for about the same price you can 
spring for two drives so you can mirror the data.

> > Only because the firmware doesn't support it.  (I.E. It's an intentional
> > lack of support.)
>
> Well maybe you can convince the sata controller makers to add whatever
> they are missing.

Why would they?  If you expect to be 90% of the market, the other 10% can go 
hang.

> Although then it would be an SAS controller I guess. 
> And sure I guess you could dumb down the firmware on the SAS drive, but
> why pay more for it to use it as SATA?

Why pay more for it at all?

> > I was under the impression that SATA came first and SAS surrounded it
> > with unnecessary extensions so they could charge more money.  But then
> > I've largely ignored SAS (as has everyone else I know outside of Dell),
> > so I can't claim to be an expert here...
>
> Looks like adaptec, LSI, buslogic, and a few others are taking SAS
> seriously.

Of course. They've been making egregious margins off of SCSI bigots for years 
(often for different interface electronics on the exact same drive), and 
would hate to see that profit center go away.

SATA is a brand new technology that obsoletes ATA.  It uses the same data 
protocol, but that's sort of like moving from Token Ring to Ethernet but 
still talking TCP/IP over it.  The ATA guys went "ok", and gracefully 
designated SATA as the successor to ATA.  And the SCSI bigots went "Ew, it's 
the successor to ATA, it can't _possibly_ be reliable, give us a SCSI version 
of this brand new technology".

The manufacturers did not go "Which part of 'brand new technology' did you not 
understand?  Do you want a SCSI version of DRAM while you're at it?  How 
about a SCSI monitor?"

The manufacturers did not go "Why are you still carrying forward biases formed 
back when Token Ring networking actually mattered?  That's like saying 
gigabit ethernet sucks because you dislike BNC connectors."

No, the manufactures went "You're offering to pay us twice as much for a 
trivial variant of the same technology?  Cool!  Yeah, the cheap stuff stucks, 
buy the premium version.  We'll throw in undercoating and bucket seats!"

> Even just having a standard for external connections is 
> something large raid setups require that SATA doesn't have.

*shrug*.  The spec allows SATA cables to be a meter long.  You run out of 
controllers and power connectors before you run out of space to put drives.

As for adding switches and longer cables in there, google brings up...

http://www.3ware.com/products/serial_ata.asp
http://www.addonics.com/products/host_controller/

And of course every time you search adeptec for "sata switch" they redirect 
you to pages on SAS, which is just their way of saying "Would you like fries 
with that?"  Upsell, gotta love it.  Push the high-margin stuff...

But we're getting deep enough into matters of opinion I think I'm going to 
tail off here...

> Len Sorensen

Rob
-- 
Never bet against the cheap plastic solution.
