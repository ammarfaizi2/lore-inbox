Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDQMIx>; Tue, 17 Apr 2001 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDQMIn>; Tue, 17 Apr 2001 08:08:43 -0400
Received: from pop.gmx.net ([194.221.183.20]:2807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129164AbRDQMI1>;
	Tue, 17 Apr 2001 08:08:27 -0400
Message-ID: <3ADC33B4.E2ADF8AC@gmx.at>
Date: Tue, 17 Apr 2001 14:14:44 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <Pine.LNX.4.10.10104161350190.19043-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Wilfried,
> 
> Why a module?

The idea behind that was that, if it is a seperate module, then it would be easier to maintain for
me. I am a guy that always needs the newest and greatest, so I expected that I would have to port my
stuff to newer kernels frequently. (I started the HPT-RAID0 alone without much knowledge about the
kernel.)

> Why not have the detection and flags that hook the md driver for linux and
> use linux's software raid?

I could not use the disk striping, because of the raid0 code is not capable of processing a request
what would span more than one disk. You also have to shift the offset of all but the first disk by
10 sectors. So I created an own personality...

I also guess it would be a bit complicated if we want to create a raid10. Is this done by putting a
raid1 over raid0 devices? We would have to find a way to map the sectors according to the IDE-RAID
spec of the controller over several raid levels.
An ataraid personality would be easier and more flexible then.

regards,
Wilfried

> 
> Cheers,
> 
> On Mon, 16 Apr 2001, Wilfried Weissmann wrote:
> 
> > Arjan van de Ven wrote:
> > >
> > > In article <3AD6B422.EEC092F0@ftel.co.uk> you wrote:
> > > > Andre Hedrick wrote:
> > >
> > > > However as far as I can see everyone who has a FastTrak which is "stuck"
> > > > in RAID mode[1] would be happy if it worked as a normal IDE controller
> > > > in Linux, which is (usually?) not the case - eg on the MSI board where
> > > > only the first channel is seen.
> > >
> > > I have a patch to work around that. However the better solution would be to
> > > have a native driver for the raid; I plan to start working on that next
> > > week...
> >
> > I am doing the same for the HighPoint-Tech 370 (talking about the RAID driver). Disk-striping is
> > working so far. My code is based on the kernel patches for MDs from Neil Brown. I created an own
> > RAID-personality for the module.
> > When I looked at the FreeBSD implementation I had the idea of making a "supermodule" which could
> > contain serveral IDE-RAID drivers (e.g.: Proise FastTrack + HPT370). There would be a super
> > personality for ATA-RAID and several low-level drivers for the individual controllers.
> >
> > Interrested? Ideas? Hints, Tips, ...? Wanna team up? <8)
> >
> > >
> > > Greetings,
> > >   Arjan van de Ven
> >
> > regards,
> > Wilfried
> >
> > PS: An uppercase THANX goes to Nail Brown!

^Nail^Neil

> 
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
