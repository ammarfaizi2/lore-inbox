Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131771AbQKJWMM>; Fri, 10 Nov 2000 17:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131762AbQKJWMC>; Fri, 10 Nov 2000 17:12:02 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30468 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131749AbQKJWLu>; Fri, 10 Nov 2000 17:11:50 -0500
Message-ID: <3A0C71B5.A6644873@timpanogas.org>
Date: Fri, 10 Nov 2000 15:07:49 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <Pine.LNX.4.21.0011101450060.11307-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:
> 
> how many CPUs in these high loadave boxes? unless you have a very
> impressive machine (8+SMP) the defaults should be plenty high.
> 
> also I thought the QueueLA default was 8 and the RefuseLA was 12 or have
> they been bumped up since I last examined them (8.8/8.9 timeframes)

I think this may be related to VM activity.  I looked at /proc/meminfo
and the sendmail sickness seems directly related to heavy VM activity in
the box.  This may be one for Rik/Linus.  I'm just trying to get
Ute-NWFS out the door and want stuff to work.  

:-)

Jeff

> 
> David Lang
> 
> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> > Date: Fri, 10 Nov 2000 14:52:01 -0700
> > From: Jeff V. Merkey <jmerkey@timpanogas.org>
> > To: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
> > Subject: Re: sendmail fails to deliver mail with attachments in
> >     /var/spool/mqueue
> >
> >
> >
> > Hey guys,
> >
> > We got to the bottom of the sendmail problem.  The line:
> >
> >  -O QueueLA=20
> >
> > and
> >
> >  -O RefuseLA=18
> >
> > Need to be cranked up in sendmail.cf to something high since the
> > background VM on a very busy Linux box seems to exceed this which causes
> > large emails to get stuck in the /var/spool/mqueue directory for long
> > periods of time.  Since vger is getting hammered with FTP all the time,
> > and is rarely idle.  This also explains what Richard was seeing with VM
> > thrashing in a box with low memory.
> >
> > The problem of dropping connections on 2.4 was related to the O RefuseLA
> > settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> > clearly set too low for modern Linux kernels.  You may want them cranked
> > up to 100 or something if you want sendmail to always work.
> >
> > Jeff
> >
> > "Jeff V. Merkey" wrote:
> > >
> > > Claus,
> > >
> > > This is a bug.  emails should not get stuck in the mail queue because
> > > your load averaging routine doesn't work right.  If this is so, then why
> > > do some emails (small ones) get through and big ones do not,
> > > irreguardless of delivery order.  If it were a loading problem one would
> > > think emails would still get processed in the order they arrived, not
> > > some arbitrary "order from hell" which is what was happening.  This is
> > > severely broken IMHO and you need to fix it.
> > >
> > > Jeff
> > >
> > > Claus Assmann wrote:
> > > >
> > > > All of these entries have an 'X':
> > > >
> > > > >               Mail Queue (11 requests)
> > > > > --Q-ID-- --Size-- -Priority- ---Q-Time--- -----------Sender/Recipient-----------
> > > > > FAA15716X   31418     200564 Nov  9 05:01 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <linux-archive@timpanogas.org>
> > > > >                                         <jmerkey@timpanogas.org>
> > > > > FAA20318X   32693     201751 Nov 10 05:29 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <linux-archive@timpanogas.org>
> > > > >                                         <jmerkey@timpanogas.org>
> > > > > SAA01998X   34484     203865 Nov  6 18:20 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <linux-archive@timpanogas.org>
> > > > >                                         <jmerkey@timpanogas.org>
> > > > > QAA01341X   65091     204150 Nov  6 16:50 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <mharris@opensourceadvocate.org>
> > > > > SAA13390X   41368     210478 Nov  8 18:03 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <linux-archive@timpanogas.org>
> > > > >                                         <jmerkey@timpanogas.org>
> > > > > LAA03425X  158115     218595 Nov  6 11:27 <jmerkey@timpanogas.org>
> > > > >                                         <Mark.Coe@rrd.com>
> > > > >                                         <jmerkey@timpanogas.com>
> > > > > QAA01343X   65091     234150 Nov  6 16:50 <linux-kernel-owner@vger.kernel.org>
> > > > >           7BIT
> > > > >                                         <linux-archive@timpanogas.org>
> > > > >                                         <jmerkey@timpanogas.org>
> > > > > KAA21225X  205041     235799 Nov 10 10:26 <paperboy@g2news.com>
> > > > >       8BITMIME
> > > > >                                         <jmerkey@timpanogas.com>
> > > > > FAA20229X    1457     272283+Nov 10 05:01 <mharris@opensourceadvocate.org>
> > > > >                  (Warning: could not send message for past 1 hour)
> > > > >                                         <andre@linux-ide.org>
> > > > > QAA06681X  242511     272929 Nov  7 16:18 <jmerkey@timpanogas.org>
> > > > >       8BITMIME
> > > > >                                         <andre@timpanogas.org>
> > > > > PAA12261X  576306     606701 Nov  8 15:06 <langus@timpanogas.com>
> > > > >                                         <jmerkey@timpanogas.com>
> > > >
> > > > That is, the load on your machine is too high.
> > > >   3:27pm  up 29 min,  2 users,  load average: 10.00, 9.97, 8.50
> > > >
> > > > It seems as if this is broken, top shows 2 running processes
> > > > and 67 sleeping.
> > > >
> > > > If you run the queue with -O QueueLA=20 the entries are processed.
> > > > So you have to change your configuration to deal with the "high"
> > > > load, which I did right now by editing your .cf file.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
