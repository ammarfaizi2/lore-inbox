Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTIDM6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTIDM6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:58:48 -0400
Received: from ns.alcom.aland.fi ([194.112.0.1]:13772 "EHLO
	aragon.alcom.aland.fi") by vger.kernel.org with ESMTP
	id S264974AbTIDM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:58:40 -0400
From: "K. Hampf" <khampf@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Verified IDE performance issues in kernels newer than 2.4.20
Date: Thu, 4 Sep 2003 15:58:35 +0300
User-Agent: KMail/1.5.3
References: <200309040231.10040.khampf@users.sourceforge.net> <20030903234932.GA15327@DUK2.13thfloor.at>
In-Reply-To: <20030903234932.GA15327@DUK2.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309041558.35393.khampf@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FALSE ALARM 

I am terribly sorry! I was tired last night when I discovered this issue but 
as you guys (Herbert Poetzl, Samuel Flory) made me realize I do need to make 
a good report available I realized that the problem was a simple one.

The chipset-specific IDE module didn't load! Even if I probed it it had no 
effect, the common IDE driver already narrowed down the bandwidth of the IDE 
bus. I just made a test building the IDE chipset drivers non-modular and it 
gives full performance again. I do not know exactly what mistake I've made 
when selecting all drivers to be modular but they block each other, I have to 
investigate that further, due to it still being an issue but I can work on 
the newer kernels again.

Thanks for looking at it, I guess I was too tired last night to do a thorough 
analysis of it all, won't happen again, next time I'll sleep first, then 
report any errors ;)

Best Regards,
K. Hampf

P.S. If anyone knows exactly what has to be modularized along with the 
chipset-specific drivers to make them run, please tell ....

On Thursday 04 September 2003 02:49, you wrote:
> On Thu, Sep 04, 2003 at 02:31:10AM +0300, K. Hampf wrote:
> > BRIEF:
> > I discovered the 2.4.21 and  2.4.22 kernels give me roughly 15% of the
> > troughput compared to 2.4.20. Anyone working on this?
>
> out of the blue, the following info could be very useful ...
> (for 2.4.20 and 2.4.22 on your systems)
>
> cat /proc/ide/*
> hdparm -i /dev/hd?
> hdparm /dev/hd?
>
> and try to make it available on a webpage
>
> best,
> Herbert
>
> > Dear Sirs!
> >
> > I could not find any info about this issue that indicated you were aware
> > of this issue. So I decided to send you a report. I've confirmed the
> > issue on different i386 chipsets so I think it's a valid issue. Tried to
> > mail the maintaners bug-report e-mail (bugs@linux-ide.org) but failed on
> > delivery, "User unknown".
> >
> > I'm a bit into tweaking kernels and I've made a discovery explaining
> > getting poor performance in ATA transfers. Both experienced by using apps
> > and with "hdparm -t -T" runs.
> >
> > I verified this under my VIA KT333 and a SiS 735 (SiS 5513IDE) chipsets.
> > The first on my Debian testing/unstable workstation, the latter on a
> > Debian/stable. It's not debian-kernel specific as I use both "vanilla"
> > stable kernel sources and debian sources, I know that I'm on to
> > something.
> >
> > I have no time to push the 2.4.20 IDE driver tree into 2.4.22 (tried
> > quickly but the include headers break and it would take some time for me
> > to make it work), I could however, if you take this bugreport seriously
> > and make it meaningful, do some runs on vanilla 2.4.20 and 2.4.22 kernels
> > with hdparm and send all results. All you need is to tell me. I will be
> > able to test it on a newer P4 SATA system too if that's supported when I
> > get to it.
> >
> > I know this is not a proper nor well formatted bugreport but I could find
> > no info on wether you knew of this performance issue already and are
> > working on it, I'll throw you some extra info just to make you happy:
> >
> > Both test systems are Athlon architectures (T-bird 1.2GHz and an
> > XP2100+). I've confirmed the issue on different IDE chipsets and on both
> > ATA66, ATA100 and ATA133 drives. I'm experienced with linux and hardware
> > and know I'm not ranting about some "might be" issue. I'm preparing my
> > local LUG to test this out a bit more, hopefully on other architectures
> > than i386 also (SPARC and Alpha I hope).
> >
> > If this is relevant to your work on the IDE driver (as I can't get in
> > touch with you guys directly) or you might think it's about some PCI
> > issues or other things, do not hesitate to contact me, I can include
> > statistics and do better testruns if you tell me it would be of any value
> > to you and that you are the ones to handle it.

