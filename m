Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268947AbTBZVJ6>; Wed, 26 Feb 2003 16:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268948AbTBZVJ6>; Wed, 26 Feb 2003 16:09:58 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:25293 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S268947AbTBZVJ5>;
	Wed, 26 Feb 2003 16:09:57 -0500
Message-ID: <6BD67FFB937FD411A04F00D0B74FE8780790C607@xrose06.rose.hp.com>
From: "LEE,SCOTT (HP-Roseville,ex1)" <scott_lee@hp.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] ide write barriers
Date: Wed, 26 Feb 2003 16:20:08 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 26 2003, Scott Lee wrote:
> > > The goal is to make the use of write
> > > back cache enabled ide drives safe with journalled file systems.
> > 
> > Does this mean that having write caching enabled is not safe if you
> > are using ext3 on an IDE drive?  Should "hdparm -W 0 
> /dev/hda" be used
> > for example.  (I see a 50% performance hit using "-W 0" 
> when my box is
> > under load.)  If this is the case, what is the root cause?  Do IDE
> > drives reorder writes when they are cached?
> 
> As it stands, it's not safe to use write back caching on IDE drives.
> When the write completes as seen from the fs, it's not on the platter
> yet. That's a problem. And as you mention, there's no guarentee that
> writes won't be reordered as well.
> 
> So yes, either use the barrier patch or disable write caching.

Unless I'm missing something the effect of write caching will be nil from a
safety standpoint *if* the drive does *not* reorder writes.  If cached
writes are written to the platter in order it seems that a loss of power
will simply mean that from the platter perspective the system will look like
the power was lost at "T-x" rather than "T" where "T" is actual time of the
outage and "x" is the age of the oldest piece of cached data.  The net
effect is that the filesystem should be in no worse shape than if there were
no caching the power actually went out at "T-x".  (Unless of course I am
missing something here.)

If the cached writes can be reordered then of course it stands that caching
would be unsafe.  Does anyone know if IDE drives do this?  I'm certainly no
expert in this area but I thought only SCSI drives reordered operations.

Also, do you happen to know if the barrier patch will apply cleanly to a RH
2.4.18-rc1-ac2 kernel and function properly?

Regards,
Scott Lee
