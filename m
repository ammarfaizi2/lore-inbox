Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284282AbRLMPs7>; Thu, 13 Dec 2001 10:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284289AbRLMPst>; Thu, 13 Dec 2001 10:48:49 -0500
Received: from neuron.com ([209.61.186.37]:25865 "EHLO server1.neuron.com")
	by vger.kernel.org with ESMTP id <S284282AbRLMPsf>;
	Thu, 13 Dec 2001 10:48:35 -0500
Date: Thu, 13 Dec 2001 09:56:53 -0600 (CST)
From: <stewart@neuron.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: <bodnar42@phalynx.dhs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: passing params to boot readonly
In-Reply-To: <200112131501.JAA41764@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.30.0112130953280.12809-100000@server1.neuron.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Jesse Pollard wrote:

> ---------  Received message begins Here  ---------
>
> >
> > On December 12, 2001 21:50, Stewart Allen wrote:
> > > I'm in a bit of a pickle and need to find a way to pass boot params to a
> > > reiserfs rootfs to *prevent* it from replaying the journal on single-user
> > > boot. This may seem like a strange request, but I've got a degraded RAID
> > > array that I need to poke around in before deciding whether or not to send
> > > a disk off to a rehab lab. If the replay occurs, it will potentially
> > > destroy the fs since I'm using a degraded snapshot of the failed disk in
> > > hopes of reclaiming *some* of my data. The system is running 2.2.x (can't
> > > remember and can't find out w/out booting).
> > >
> > > Do I have a snowball's chance of pulling this off?
> >
> > Well, kinda. The only thing that can deter ReiserFS from replaying the
> > journal is convincing it that the physical media it's on is actually read
> > only. Some quick less/grep work revealed that there is no option that makes
> > the SCSI subsystem claim its devices are readonly (although it'd be extremely
> > useful for situations such as this).
> >
> > It'd probably be pretty easy to make a boot disk using a hacked version of
> > ReiserFS that refuses to replay the journal, by adding a "return 0;" near the
> > top of journal_read(struct super_block *) in journal.c. However, you might
> > feel more comfortable sending it off for data recovery than testing kernel
> > hacks on it ;)
>
> Wouldn't it be better to make a backup (dd copy) of the disk volume to another
> drive? The raid would not be mounted, so the fs would not be updated.
>
> I would recommend that be done even before sending the disk out.
>
> ALTERNATIVE TO READ-ONLY and this might not be possible.
>
> If the raid is SCSI based, then there is (should be) a read-only switch
> in the disk configuration. Most disks do not have a jumper there, and since
> they are usually internal only, the option is not used. Putting the jumper
> on (or removing one if it is there - depends on the drive) will make the
> disk read-only.
>
> Even some IDE drives may have this option, though finding documentation on
> it may be difficult to locate.
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
>
> Any opinions expressed are solely my own.


 The RAID array uses 3ware's Escalade switch so all the drives are EIDE.
I've used read-only jumpers on SCSI drives in the past and hoped that these
supported it as well, but when I took the array apart, my hopes were dashed.

The drive that crashed will not spin up so I cannot dd back it up. I will be
doing this with two of the other disks, which should comprise a complete (if
degraded) image set.

stewart

