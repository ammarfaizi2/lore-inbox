Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbRETPmD>; Sun, 20 May 2001 11:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbRETPlo>; Sun, 20 May 2001 11:41:44 -0400
Received: from smtp1.libero.it ([193.70.192.51]:29144 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S262049AbRETPll>;
	Sun, 20 May 2001 11:41:41 -0400
Message-ID: <3B07E569.83639A19@alsa-project.org>
Date: Sun, 20 May 2001 17:40:25 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105201107110.8940-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Abramo Bagnara wrote:
> 
> > > Face it, we _already_ have more than one side band.
> >
> > This does not imply it's necessarily a good idea.
> > We are comparing
> >
> > echo "9600" > /proc/self/fd/0/speed (or /dev/ttyS0/speed)
> > echo "8" > /proc/self/fd/0/bits (or /dev/ttyS0/bits)
> >
> > with
> >
> > echo -e "speed 9600\nbits 8" > /proc/self/fd/0/ioctl (or
> > /dev/ttyS0/ioctl).
> 
> How about reading from them? You are forcing restriction that may make
> sense in some cases, but doesn't look good for everything.

exec 3>/dev/ttyS0/ioctl
exec 4<&3
echo "speed" >&3
cat <&4
exec 3>&-
exec 4<&-

Can you make a counter example where this doesn't look good?

> 
> > > Moreover, we have channels that are not tied to a particular device -
> > > they are for a group of them. Example: setting timings for IDE controller.
> > > Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> > > are back to the "find related file" problem you tried to avoid.
> >
> > It does not seems appropriate to permit to change IDE timings using an
> > handle to a partition... nor it seems very safe under a permissions
> > point of view.
> 
> However, we _do_ allow that. Right now. And yes, I agree that we should
> go to separate file for that. And we are right back to finding a related
> file.

I'd prefer to make what you often call a crapectomy: no IDE timing
change using a partition handle. It's something like to permit that on a
LVM handle, it's stupid...

About tty and vcs split: there the problem is more subtle and it's
related to a missing separation of keyboard and screen.
After to have done this choice (i.e. to have the some behaviour of
serial port) someone has realized that to read from console screen it's
a sensible action (to fetch current content).

This is the typical case where to have /dev/tty1/ioctl does not
substitute to have another device for console screen reading.

Note that it's a *different* device (different permission, etc.).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
