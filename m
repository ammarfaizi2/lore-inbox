Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbRETPSw>; Sun, 20 May 2001 11:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbRETPSl>; Sun, 20 May 2001 11:18:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18572 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262033AbRETPSY>;
	Sun, 20 May 2001 11:18:24 -0400
Date: Sun, 20 May 2001 11:18:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <3B07DC23.F905DE7B@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105201107110.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Abramo Bagnara wrote:

> > Face it, we _already_ have more than one side band.
> 
> This does not imply it's necessarily a good idea.
> We are comparing
> 
> echo "9600" > /proc/self/fd/0/speed (or /dev/ttyS0/speed)
> echo "8" > /proc/self/fd/0/bits (or /dev/ttyS0/bits)
> 
> with 
> 
> echo -e "speed 9600\nbits 8" > /proc/self/fd/0/ioctl (or
> /dev/ttyS0/ioctl).

How about reading from them? You are forcing restriction that may make
sense in some cases, but doesn't look good for everything.

> > Moreover, we have channels that are not tied to a particular device -
> > they are for a group of them. Example: setting timings for IDE controller.
> > Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> > are back to the "find related file" problem you tried to avoid.
> 
> It does not seems appropriate to permit to change IDE timings using an
> handle to a partition... nor it seems very safe under a permissions
> point of view.

However, we _do_ allow that. Right now. And yes, I agree that we should
go to separate file for that. And we are right back to finding a related
file.

It's not a function of descriptor. Sorry. Just as with /dev/tty1 -> /dev/vcs1
and its ilk.

