Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbRCGFcP>; Wed, 7 Mar 2001 00:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbRCGFb4>; Wed, 7 Mar 2001 00:31:56 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:28137 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130138AbRCGFbx>; Wed, 7 Mar 2001 00:31:53 -0500
Message-ID: <080d01c0a6c7$c2215140$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: "Jens Axboe" <axboe@suse.de>, "Andre Hedrick" <andre@linux-ide.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Linus Torvalds" <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10103061206270.13719-100000@master.linux-ide.org> <20010306214838.V2803@suse.de>
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Date: Tue, 6 Mar 2001 21:30:40 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jens Axboe" <axboe@suse.de>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Linus Torvalds"
<torvalds@transmeta.com>; <linux-kernel@vger.kernel.org>

> > This is a LIE, it does not destroy the drive, only the partition table.
> > Please recally the limited effects of "DiskDestroyer" and "SCSIkiller"
> >
> > This is why we had the flaming discussion about command filters.
>
> But I might want to do this (write sector 0), why would we want

Jens, and others, I have noted a very simple data killer technique that
at LEAST works on Quantum SCSI drives as of a couple years ago and some
other earlier drives I felt could be sacrificed to the test. You can write
as many blocks at once as SCSI supports to the drive as long as you do
*NOT* start at block zero. If you write more than 1 block to block zero
the drive becomes unformatted. The only recovery is to reformat the
drive. The data on the drive is lost for good. I found no recovery for
this. I have, to my great chagrin, discovered this twice, the hard way.
Once on a large Micropolis harddisk I was working with in the block zero
area for partitioning purposes. And the other time when I was attempting
to make a complete duplicate of a 2G Quantum SCSI disk to another identical
2G SCSI disk. I ended up writing a script for the process that wrote one
block to block zero and then proceeded to use large blocks for the rest
of the disk, using dd under 2.0.36 at the time.

If this problem still exists the lowest level drivers in the OS should
offer protection for this problem so people working at any higher level
do not see it and fall victim to it.

{^_^}    Joanne Dow, jdow@earthlink.net


