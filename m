Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSDCHHo>; Wed, 3 Apr 2002 02:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293218AbSDCHHe>; Wed, 3 Apr 2002 02:07:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4114 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293204AbSDCHHQ>;
	Wed, 3 Apr 2002 02:07:16 -0500
Date: Wed, 3 Apr 2002 09:07:03 +0200
From: Jens Axboe <axboe@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
Message-ID: <20020403070703.GF1465@suse.de>
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl> <871ye479sz.fsf@devron.myhome.or.jp> <3CA97B1A.13E6765D@aitel.hist.no> <87663acjs7.fsf@devron.myhome.or.jp> <20020402221325.GC961@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02 2002, Mike Fedyk wrote:
> On Tue, Apr 02, 2002 at 10:27:52PM +0900, OGAWA Hirofumi wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> writes:
> > 
> > > OGAWA Hirofumi wrote:
> > > > 
> > > > Jos Hulzink <josh@stack.nl> writes:
> > > > > Questions:
> > > > >
> > > > > 1) How do you think about the checking of the FAT tables ? It definitely
> > > > >    will slow down the mount.
> > > > 
> > > > Unfortunately if FAT table has bad sector, FAT tables may not be the
> > > > same.
> > > 
> > > And then you don't want to mount unless you know what you
> > > are doing.  And those knowing what they are doing can be bothered
> > > to use some kind of "force" option in this case.  Or perhaps an
> > > option that selects which FAT to trust.
> > 
> > I mean I/O error, not data damage.
> 
> It is the block layer's responsibility to retry such soft errors and recover.

No it's the low level driver

> Probably the best you can do, is retry the read a few times if there
> is an error reported, and then fail if it persists.

I/O error retrying from the fs is a bad idea, the low level driver
should already have exhausted the possibilities to recover the data. If
the fs receives an I/O error, that's the final result and retrying
would serve no sane purpose.

-- 
Jens Axboe

