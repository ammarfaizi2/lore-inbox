Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131069AbRCGN2M>; Wed, 7 Mar 2001 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131074AbRCGN2C>; Wed, 7 Mar 2001 08:28:02 -0500
Received: from mail2.panix.com ([166.84.0.213]:54265 "HELO mail2.panix.com")
	by vger.kernel.org with SMTP id <S131069AbRCGN1s>;
	Wed, 7 Mar 2001 08:27:48 -0500
Date: Wed, 7 Mar 2001 07:21:14 -0500 (EST)
From: Harvey Fishman <fishman@panix.com>
To: "J. Dow" <jdow@earthlink.net>
Cc: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <080d01c0a6c7$c2215140$0a25a8c0@wizardess.wiz>
Message-ID: <Pine.SUN.4.21.0103070713500.22298-100000@panix5.panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne, since a SCSI drive contains a processor (one of the small
computer systems that are interfacing) it requires that the local
personality data be stored in non-volatile storage someplace.
Most drives used a dedicated area of the drive surface, which was
SUPPOSED to be inaccessible to any outside process.  If you were
able to muck with that sector or sectors, then it was REAL EASY
to make the drive terminally unusable.  But as I say, you should
not be able to directly reach that area.

Since ATA drives are generally also small self-contained systems
who differ from SCSI drives mainly in the details of the interface
protocols, they probably suffer from the same problem.

But you ain't supposed to be able to get at that area...

Harvey

On Tue, 6 Mar 2001, J. Dow wrote:

> From: "Jens Axboe" <axboe@suse.de>
> To: "Andre Hedrick" <andre@linux-ide.org>
> Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Linus Torvalds"
> <torvalds@transmeta.com>; <linux-kernel@vger.kernel.org>
> 
> > > This is a LIE, it does not destroy the drive, only the partition table.
> > > Please recally the limited effects of "DiskDestroyer" and "SCSIkiller"
> > >
> > > This is why we had the flaming discussion about command filters.
> >
> > But I might want to do this (write sector 0), why would we want
> 
> Jens, and others, I have noted a very simple data killer technique that
> at LEAST works on Quantum SCSI drives as of a couple years ago and some
> other earlier drives I felt could be sacrificed to the test. You can write
> as many blocks at once as SCSI supports to the drive as long as you do
> *NOT* start at block zero. If you write more than 1 block to block zero
> the drive becomes unformatted. The only recovery is to reformat the
> drive. The data on the drive is lost for good. I found no recovery for
> this. I have, to my great chagrin, discovered this twice, the hard way.
> Once on a large Micropolis harddisk I was working with in the block zero
> area for partitioning purposes. And the other time when I was attempting
> to make a complete duplicate of a 2G Quantum SCSI disk to another identical
> 2G SCSI disk. I ended up writing a script for the process that wrote one
> block to block zero and then proceeded to use large blocks for the rest
> of the disk, using dd under 2.0.36 at the time.
> 
> If this problem still exists the lowest level drivers in the OS should
> offer protection for this problem so people working at any higher level
> do not see it and fall victim to it.
> 
> {^_^}    Joanne Dow, jdow@earthlink.net
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

----------------------------------------------------------------------------
 Harvey Fishman   |
fishman@panix.com |           A little heresy is good for the soul.
  718-258-7276    |

