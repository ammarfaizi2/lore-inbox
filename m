Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbRESQBj>; Sat, 19 May 2001 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbRESQBa>; Sat, 19 May 2001 12:01:30 -0400
Received: from simba.xos.nl ([192.87.153.226]:50706 "EHLO simba.xos.nl")
	by vger.kernel.org with ESMTP id <S261843AbRESQBO>;
	Sat, 19 May 2001 12:01:14 -0400
Message-Id: <200105191601.SAA04009@rabbit.xos.nl>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup) 
In-Reply-To: Your message of "Sat, 19 May 2001 17:10:56 +0200."
             <3B068D00.95338099@alsa-project.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3997.990288066.1@rabbit.xos.nl>
Date: Sat, 19 May 2001 18:01:06 +0200
From: Willem Konynenberg <wfk@xos.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abramo Bagnara wrote:
> Alexander Viro wrote:
> >         Folks, before you get all excited about cramming side effects into
> > open(2), consider the following case:
> > 
> > 1) opening "/dev/zero/start_nuclear_war" has a certain side effect.
[...]
> Can't this easily avoided if the needed action is not
> 
> < /dev/zero/start_nuclear_war 
> or
> > /dev/zero/start_nuclear_war
> 
> but
> 
> echo "I'm evil" > /dev/zero/start_nuclear_war
> 
> ?

Yes, and that is exactly the difference between having a side effect
on the open(2), versus having the effect as a result of a write(2).

Unfortunately, there are already some cases where an open
on a device can have unexpected results.  If you don't want
to get blocked waiting for the carrier-detect signal from the
modem when opening a tty device, you had better specify the
O_NONBLOCK option on the open.  If you don't want this flag
to be active during the actual I/O operations, then you would
have to do an fcntl to clear the O_NONBLOCK again after the open.

So I guess things have already been a bit messy in this
area for many years, even before linux even existed, and
in some cases you can't really do anything about it because
the behaviour is mandated by the applicable standards, like
POSIX, SUS, or whatever.
(The blocking of the open on a tty device is explicitly
 documented in my copy of the X/Open specification.)

Fortunately, blocking the nightly backup program by making it
accidentally open a tty is not quite as catastrophic as having
it start a nuclear war, or format the disks, or something,
just because a user was playing games with symlinks.

-- 
     Willem Konynenberg <wfk@xos.nl>
I am not able rightly to apprehend the kind of confusion of ideas
that could provoke such a question  --  Charles Babbage
