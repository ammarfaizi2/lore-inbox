Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbRETIbT>; Sun, 20 May 2001 04:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbRETIbK>; Sun, 20 May 2001 04:31:10 -0400
Received: from smtp2.libero.it ([193.70.192.52]:63126 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S261485AbRETIbD>;
	Sun, 20 May 2001 04:31:03 -0400
Message-ID: <3B0780B8.36FDA681@alsa-project.org>
Date: Sun, 20 May 2001 10:30:48 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@suse.cz>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending 
 DeviceNumberRegistrants]
In-Reply-To: <Pine.GSO.4.21.0105200329310.7162-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Abramo Bagnara wrote:
> 
> > I've just had a "so simple to risk to be stupid" idea.
> >
> > To have /proc/self/fd/N/ioctl would not have the potential to suppress
> > ioctl needs for *all* current uses?
> 
> No, it wouldn't. For one thing, it messes the only half-decent part of
> procfs. For another, the real issue is how to eliminate the bogus
> ioctls from userland programs and what to replace them with.

Linus wrote:

> The problem with ioctl is that not only are people passing ioctl's
> pointers to structures, but:
>  - they're not telling how big the structure is
>  - the structure can have pointers to other places
>  - sometimes it modifies the structure passed in

> None of which are "network-nice". Basically, ioctl() is historically used
> as a "pass any crap into driver xxxx, and the driver - and ONLY the driver
> - will know what to do with it".

> And when _only_ a driver knows what the arguments mean, upper layers can't
> encapsulate them. Upper layers cannot make a packet of the argument and
> send it over the network to another machine. Upper layers cannot do
> sanity-checking on things like "is this argument a valid pointer". Which
> means, for example, that not only can you not send the ioctl arguments
> anywhere, but ioctl's have also historically been a hot-bed of bugs.

Suppose now to have a convention that control stream are in the form:
"ACTION ARGUMENTS"

Then we have
echo "speed 19200" > /proc/self/fd/0/ioctl
instead of
stty 19200

It seems to me something different from a pile of shit ;-)

And it may works also via NFS (with some changes).

> Crappy API won't become better if you simply change the calling conventions.
> And problem with ioctls is that most of them are crappy APIs. Coming from
> authors' laziness and/or debility.
> 
> So there is no easy way to solve that stuff - we'll need to rethink tons
> of badly designed interfaces.

This is orthogonal wrt ioctl problems pointed by Linus.

I've simply proposed an *infrastructure* for better interfaces.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
