Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S161134AbQGaQVY>; Mon, 31 Jul 2000 12:21:24 -0400
Received: by vger.rutgers.edu id <S161101AbQGaQVL>; Mon, 31 Jul 2000 12:21:11 -0400
Received: from [195.71.101.13] ([195.71.101.13]:2445 "HELO lxMA.nowhere") by vger.rutgers.edu with SMTP id <S161058AbQGaQUn> convert rfc822-to-8bit; Mon, 31 Jul 2000 12:20:43 -0400
Date: Mon, 31 Jul 2000 18:40:48 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731184048.L2224@lxMA.mediaways.net>
Mail-Followup-To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net> <20000731171858.J2243@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20000731171858.J2243@cerebro.laendle>; from pcg@goof.com on Mon, Jul 31, 2000 at 17:18:59 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Marc Lehmann wrote:

> On Mon, Jul 31, 2000 at 04:53:00PM +0200, Matthias Andree <matthias.andree@gmx.de> wrote:
> > My point is: putting a drive to sleep rather than to standby will not
> > help much, it will only delay the spin-up and possibly leave you with a
> > slower drive.
> 
> Cool logic. How do you define "much"? Drive electronics can still use
> a lot of power, and most users (xuan and me excluded ;) want this for
> power-save.

How much you get, depends on how much the actual drive saves. Still, you
lose performance, you possibly lose the settings, that's on the negative
side. I'm aware of these implications, a good friend of mine has written
his diploma thesis in electrical engineering on exactly this topic,
namely "Algorithmen für den leistungsarmen Betrieb mobiler Festplatten"
(German-language, translates to 'algorithms for the low-power operation of
mobile hard disk drives'). Contact me in private mail if you need
more information. 

He collected some information from manufacturers that I'm working up
here: (quoting from 

manuf.+model  IBM DARA Hitachi    Fujitsu  Seagate Ma-  Maxtor
cont'd        225000   DK22AA     2064AT   rathon 2250  251010A 

power (W)
active          2.6    2.22        2.15    2.50         1.83
idle    2.0/1.3/0.85   1.7/0.8     0.95    1.20         0.90
standby         0.25   0.25        0.35    0.30         0.20
sleep           0.1    0.125       0.13    0.10         0.10

So, effectively, you gain about 100..200 mW by putting a drive from
standby to sleep, while you gain roughly 1000 mW from idle to standby
after gaining 0.5 .. 1.5 W from active to idle. (depends on the usage
pattern). OTOH, if you're talking about power, the more interesting
thing is the energy (integral t0...t1 P(t) dt), and waking up
electronics and spinning up the drive costs additional energy, even if
it's only for the delay until the request is satisfied. If waking up
from sleep costs additional seconds, that's going to cost battery life,
to put it popularly.

> In practise, of course, there is a clear trade-off between ugly error (!)
> messages from the kernel drawing for your attention and not putting the
> drive to sleep.

The error message is natural, a drive put to sleep is put there
permanently, since the drive is supposed to power down its interface
electronics as well. 

> In general, the kernel support is lacking much with respect to
> power-savings (just spin down your scsi-drive to get some nice hang (and
> yes, I know the scsi-idle patch)).

Since SCSI drives are only manually powered down, the Kernel is fine in
this respect, although it leaves room for feature requests, admittedly
:-)

-- 
Matthias Andree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
