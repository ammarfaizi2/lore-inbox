Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSL0NL0>; Fri, 27 Dec 2002 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSL0NL0>; Fri, 27 Dec 2002 08:11:26 -0500
Received: from m3.azalea.se ([217.75.96.207]:39105 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S264936AbSL0NLZ>;
	Fri, 27 Dec 2002 08:11:25 -0500
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
From: Mikael Olenfalk <mikael@netgineers.se>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021226123710.GA2442@iapetus.localdomain>
References: <1040815160.533.6.camel@devcon-x>
	 <20021225115820.GB7348@louise.pinerecords.com>
	 <20021226123710.GA2442@iapetus.localdomain>
Content-Type: text/plain
Organization: Netgineers
Message-Id: <1040994876.518.13.camel@devcon-x>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Dec 2002 14:14:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-26 at 13:37, Frank van Maarseveen wrote:
> On Wed, Dec 25, 2002 at 12:58:20PM +0100, Tomas Szepe wrote:
> > > For some funny reason, a 2.4.20 kernel refuses to set the DMA-level on
> > > the new disks (all connected to a UDMA5-capable Ultra100 TX2 controller)
> > > to UDMA5,4,3 and settles it for UDMA2, which is the highest possibility
> > > for the OLD onboard-controller (but NOT for the promise card).
> > 
> > You need to boot 2.4.19 and 2.4.20 with 'ideX=ata66' where X is the
> > number of the channel where you wish to use transfer modes above UDMA2.
> > For instance, "ide0=ata66 ide1=ata66" will do the trick for the first two
> 
> hdparm -X69 /dev/hda will put it into UDMA5/ata100 mode as well
> (69 == 64 + UDMA mode). No need to specify it at boot time.
> 
> (this discussion reminded me of my own TX2 adapter and 100GB disk:
>  adjusting its setting improved sequential disk reads: now 36MB/sec
>  instead of 24MB/sec)

I can only set UDMA3,4,5 if I pass the ide{1,2}=ata66 kernel boot
parameter. Actually I don't really care that much about the speed for
now, I would rather like the thing to work at all :)

The PDC20268 sporadically gives me DMA errors when doing the first
parity sync of my software RAID5. The last few times it has always been
the same disk, but that is no requirement (sometimes hde 02:00, hdg
03:00, not so often one of the slave disks on the channel).

But the only system seems to be that It either always bails out at
30-36% percent of the parity sync or in case it does not bail out the
speed goes down to 60-80kB/sec, which will finish the sync after 16,000
or so minutes (definitely too long).

I thought of returning the IBM drives and getting MAXTOR instead, as I
have heard rumors about the bad quality of the IBM drives. Still this
seems to be a problem with the controller and/or in combination with MD.
The drives gives me NO problems when just writing and/or reading them
with dd if=/dev/zero of=/dev/hd[efgh]. Even running the bonnie++
benchmark on them with a 20GB file gives no errors (simultaneously).


Thank you for your help so far.

/Regards, Mikael

-- 
Mikael Olenfalk <mikael@netgineers.se>
Netgineers

