Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317501AbSFDXpQ>; Tue, 4 Jun 2002 19:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317502AbSFDXpP>; Tue, 4 Jun 2002 19:45:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35595 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317501AbSFDXpO>;
	Tue, 4 Jun 2002 19:45:14 -0400
Message-ID: <3CFD50B9.259366F4@zip.com.au>
Date: Tue, 04 Jun 2002 16:43:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jun 04, 2002  15:54 -0700, Andrew Morton wrote:
> > laptop_writeback_centisecs
> > --------------------------
> >
> > This tunable determines the maximum age of dirty data when the machine
> > is operating in Laptop mode.  The default value is 30000 - five
> > minutes.  This means that if applications are generating a small amount
> > of write traffic, the disk will spin up once per five minutes.
> 
> Just FYI, this is probably an optimally bad choice for the default disk
> spinup interval, as many laptops spindown timers in the same ballpark.
> I would say 15-20 minutes or more, unless there is a huge amount of
> VM pressure or something.  Otherwise, you will quickly have a dead
> laptop harddrive from the overly-frequent spinup/down cycles.
> 

Twenty it is, thanks.

BTW, the "use a gigabyte of readahead" idea would cause VM hysteria
if you access a 600 megabyte file, so I've wound that back to
twenty megs.

Also, it has been suggested that the feature become more fully-fleshed,
to support desktops with one disk spun down, etc.  It's not really
rocket science to do that - the `struct backing_dev_info' gives
a specific communication channel between the high-level VFS code and
the request queue.  But that would require significantly more surgery
against the writeback code, so I'm fishing for requirements here.  If
the current (simple) patch is sufficient then, well, it is sufficient.

-
