Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316776AbSFZSlB>; Wed, 26 Jun 2002 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSFZSlB>; Wed, 26 Jun 2002 14:41:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316776AbSFZSlA>;
	Wed, 26 Jun 2002 14:41:00 -0400
Message-ID: <3D1A0A63.BB5F0C33@zip.com.au>
Date: Wed, 26 Jun 2002 11:39:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Tweedie <sct@redhat.com>
CC: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when 
 alaptop is powered by a battery?
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020626011340.A13410@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Tweedie wrote:
> 
> Hi,
> 
> On Tue, Jun 25, 2002 at 10:03:47AM -0700, Andrew Morton
> <akpm@zip.com.au> wrote:
> 
> > If it's because of the disk-spins-up-too-much problem then
> > that can be addressed by allowing the commit interval to be
> > set to larger values.
> 
> > +int jbd_commit_interval = 5; /* /proc/sys/fs/jbd_commit_interval */
> 
> I suspect you want this to be per-mount, not system-wide (although
> filesystems could easily just inherit the system default dynamically
> if there's no per-fs override.)  I could easily imagine a user wanting
> a different interval for a scratch disk, for example.
> 

Yes, that would be better.  We do want to be able to change it
on the fly.  So how about:

	mount /dev/what /mnt/where -o commit_interval=5
and
	mount /mnt/where -o remount,commit_interval=3000

?

-
