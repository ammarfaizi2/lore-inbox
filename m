Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUHMXxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUHMXxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUHMXx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:53:29 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:36276 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S267776AbUHMXu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:50:27 -0400
Date: Sat, 14 Aug 2004 01:50:23 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Jens Axboe <axboe@suse.de>
cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <20040813134855.GQ2663@suse.de>
Message-ID: <Pine.LNX.4.44.0408140123350.5637-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, Jens Axboe wrote:

> On Fri, Aug 13 2004, Robert M. Stockmann wrote:
> > On Fri, 13 Aug 2004, Frank Steiner wrote:
> > 
> > > Robert M. Stockmann wrote:
> > > 
> > > > Now listen up Jens, i don't do default, i like to know what went
> > > > wrong.
> > > 
> > > So instead of using the default which works you choose to select your
> > > own method which does not work. And then you complain, and you don't
> > > do that in alt.os.linux.suse or similar, but in comp.os.linux.advocacy
> > > just telling how you disappointed you are and how much better Mandrake ist.
> > > Sorry man, but this sound very much like a troll trying to start another
> > > "this distribution is better than that one" flame war and not someone
> > > asking for help or technical background information.
> > > 
> > > > grundliche engineerung
> > > 
> > > Wow wow, now you better be careful what you say next.
> > > 
> > care to explain to me why on Mandrake 10.0 i have none of these problems?
> 
> Well, you are the UNIX/Linux Specialist, you should be able to figure it
> out :-)
> 
> I asked for your dmesg wrt your dma problem, you never sent it to me. I
> cannot help you.
> 

Maybe you didn't fully understand my problem. What i did was the 
following. I downloaded cdrtools-2.01a27.tar.bz2 from 

ftp://ftp.berlios.de/pub/cdrecord/alpha/

and only applied this patch cdrtools-2.01a27-ossdvd.patch.bz2 from

ftp://ftp.crashrecovery.org/pub/linux/cdrtools/

The binary results runs rather poor after building it on SuSE 9.1. while
the same exercise on mandrake 10.0 gives good results :

================================================================
From: Robert M. Stockmann (stock@stokkie.net)
Subject: SuSE 9.1 : i'm not impressed, its a drama 
View: Complete Thread (2 articles) 
Newsgroups: comp.os.linux.advocacy
Date: 2004-07-02 22:05:53 PST

Hi,

Well here's my findings of facts :

the machine : a compaq proliant 800 2x PIII 500MHz/512kb (Katmai)
              128 Mb RAM, 2x 9.1Gb U2W SCSI
              _NEC DVD_RW ND-2510A Dual Layer burner

i installed a vanilla suse9.1, and tried to read a 4.5Gb dvd isoimage
to disk using the command :

# readcd -v dev=ATAPI:0,0,0 f=dvdimage.iso

and afterwards try to  burn it to a dvd-r recordable using this command:

# cdrecord -v dev=ATAPI:0,0,0 driveropts=burnfree -dao dvdimage.iso

Not only did the suse9.1 kernel 2.4.5 _NOT_ switch on DMA on that burner
,it was terrible SLOW, i got only 2Mbytes/sec. On a different machine a
dual xeon machine with 1024Mb RAM, suse91 even failed to read the dvd
iso image, always failing at the moment 1024Mb physical was getting 100%
into use. The readcd process then locks hard , and one cannot kill it.
When the readcd command was running, one was not able to operate the
SuSE91 machine interactively in a normal fashion. Apparently the reiserfs
root filesystem doesn't like a single huge file of 4.5Gb being written
onto. 

This behaviour reminds me closely of SCO OpenServer 5.0.x where making a
backup on tape, renders the application software not usable.

Apparently the virtual memory management behaviour of SuSE9.1 was
seriously lacking. Actually so bad, that my only conclusion is that
the SuSE 9.1 kernel is seriously broken. 

To put this to the test i installed on the same proliant 800, Mandrake
10.0. And not only does the Mandrake kernel switch on DMA on the NEC 2510A
Dual Layer burner, it reads the 4.5 Gb dvd iso image at a speed of 7.7
Mbytes/sec. That is on the same machine but only installing mandrake 10.0
instead of suse91. I used these RPMS for Mandrake 10.0 :

http://crashrecovery.org/oss-dvd/RPMS/mdk100/

Burning went at normal speed hovering between 6x to 8x .

I am so bitterly disappointed at SuSE9.1 , that for some time I was
thinking if Novell uses this SuSE disaster edition (9.1) as a way to
discredit Linux. This of course can not be the case.. Anyway, as of now i
dropped all SuSE related stuff and papertrail attached, as i simply cannot
take such a drama seriously. 

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net
================================================================

As to the DMA settings right after booting SuSE9.1 : Either DMA is 
switched on or not. No single userland application like cdrecord or
readcd is going to change that.

So my conclusion : vanilla cdrtools-2.01a27.tar.bz2 with my OSS DVD
Extensions patch cdrtools-2.01a27-ossdvd.patch.bz2 applied does not
work ok on SuSE9.1. That shouldn't imply that the cdrecord RPM from 
which comes with SuSE9.1 does _not_ work. However unfortunately i'm 
a hard headed asshole which only uses his own "moonshine" goodies, 
which of course are Open Source, and hopefully well documented for
other people to share with. 

What strikes me here however, is that Jörg Schilling also had his share
of unexpected unusual problems with the SuSE developers :

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0408.1/0736.html

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

