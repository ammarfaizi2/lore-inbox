Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbRETPnN>; Sun, 20 May 2001 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbRETPnD>; Sun, 20 May 2001 11:43:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22701 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262052AbRETPmv> convert rfc822-to-8bit;
	Sun, 20 May 2001 11:42:51 -0400
Date: Sun, 20 May 2001 11:42:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <20010520172656.A20174@unthought.net>
Message-ID: <Pine.GSO.4.21.0105201129220.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, [iso-8859-1] Jakob Østergaard wrote:

> > Face it, we _already_ have more than one side band.
> 
> Wouldn't it be natural to
>   write(fd, <control type>)
>   write(fd, <control information)
>   read(fd, reply)
> 
> Only one control file for all controls a device understands

That's one of the ways to do it. However, it's less than ideal when
you want to mix access to such channels. Again, look at font and
screen contents of VC. You can force everything into that model.
It even makes sense for many cases. Not all of them, though and
any solution for the rest will handle the special case.

Example of such solution (_not_ for sockets - they are very different)
readlink() on /proc/self/fd/<n>, then replace everything past
the last /. BTW, that way you can bind a device into chroot jail, but
leave some subset of channels out of it. Or all of them. Just don't
bind the side channels there.

> > Moreover, we have channels that are not tied to a particular device -
> > they are for a group of them. Example: setting timings for IDE controller.
> > Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> > are back to the "find related file" problem you tried to avoid.
> 
> If the IDE controller is a device we can control, it should have a device
> file and a control device file.
> 
> Problem solved, AFAICS.

Sure, but the same logics applies to /proc/self/fd/<n>/ioctl. Yes, sometimes
you need to figure out the name of related file. Depends on situation.
Saying that we have one very special related file that corresponds to current
ioctls looks rather bogus.

