Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261873AbSIYBQ0>; Tue, 24 Sep 2002 21:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSIYBQZ>; Tue, 24 Sep 2002 21:16:25 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:48885 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261873AbSIYBQY>; Tue, 24 Sep 2002 21:16:24 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tim Hockin <thockin@hockin.org>, greearb@candelatech.com (Ben Greear)
Subject: Re: alternate event logging proposal
Date: Wed, 25 Sep 2002 11:14:53 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org (linux-kernel mailing list),
       cgl_discussion@osdl.org (cgl_discussion mailing list),
       evlog-developers@lists.sourceforge.net (evlog mailing list)
References: <200209250047.g8P0lpr22153@www.hockin.org>
In-Reply-To: <200209250047.g8P0lpr22153@www.hockin.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209251114.53657.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 25 Sep 2002 10:47, Tim Hockin wrote:
> > > a single device_event file that a daemon reads and dispatches events (I
> > > like this one because the daemon is already written, just poorly named
> > > - acpid)
> >
> > Couldn't you just have the message sent to every process that has
> > opened the file (and have every interested process open the file and
> > read it in a non-blocking or blocking mode?)
>
> Sure, but then every process that is concerned with a single event has to
> not only receive every event, but parse every event.  And if this is to be
> truly generic, that could be a lot of events.
To what level would you see this going?
I'm currently doing some documentation work on the input subsystem, and it 
produces events (/dev/input/eventX) for every mouse movement, every key press 
(and release), etc. Now most of the application interested in those events 
will get them via X (we just need to interface the input subsystem event 
interface to the X event interface). I see this as a separate daemon or 
daemons. 
Basically you get eventd on every system, and inputd for each console (in a 
multiheaded, multiuser setup).

> > That seems to negate the need for something like acpid, but it does
> > not preclude it's use.
>
> True, and if a dev_event file were created, I'd consider doing it that way.
> But in that case it's easier for apps to talk to eventd (nee acpid) and get
> only the messages they want.
I think that the eventd advantage is that it is easy to do integration with 
non-event aware apps. Example: eventd re-writes the config file and SIGHUPs 
the application.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kQ4NW6pHgIdAuOMRAtEyAKC2t5lKponBvUHH14bONYfjbSWFxgCeMh1O
9pjS0UjK627edrI8WJDBXp0=
=V0sd
-----END PGP SIGNATURE-----

