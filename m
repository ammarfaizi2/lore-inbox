Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132404AbRACRA6>; Wed, 3 Jan 2001 12:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRACRAt>; Wed, 3 Jan 2001 12:00:49 -0500
Received: from hermes.mixx.net ([212.84.196.2]:15632 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S132404AbRACRAj>;
	Wed, 3 Jan 2001 12:00:39 -0500
Message-ID: <3A5352ED.A263672D@innominate.de>
Date: Wed, 03 Jan 2001 17:27:25 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 3 Jan 2001, Dr. David Gilbert wrote:
> 
> >   I got wondering as to whether the various journaling file
> > system activities were designed to survive the occasional
> > unclean shutdown or were designed to allow the user to just pull
> > the plug as a regular means of shutting down.
> 
> 1. a journaling filesystem is designed to be "consistent"
>    (or rather, easily recoverable) all of the time
> 2. there's no difference between the "2 situations" you
>    describe above

Welllllll... crashes tend to produce different effects from sudden power
interruptions.  In the first case parts of the system keep running, and
bizarre results are possible.  An even bigger difference is the matter
of intent.

Tux2 is explicitly designed to legitimize pulling the plug as a valid
way of shutting down.  Metadata-only journalling filesystems are not
designed to be used this way, and even with full-data journalling you
should bear in mind that your on-disk filesystem image remains in an
invalid state until the journal recovery program has run successfully. 
You would not want to upgrade your OS with your filesystem in this
state, nor would you want to remove a disk drive that didn't have the
journal file on it.

Being able to shut down by hitting the power switch is a little luxury
for which I've been willing to invest more than a year of my life to
attain.  Clueless newbies don't know why it should be any other way, and
it's essential for embedded devices.

I don't doubt that if the 'power switch' method of shutdown becomes
popular we will discover some applications that have windows where they
can be hurt by sudden shutdown, even will full filesystem data state
being preserved.  Such applications are arguably broken because they
will behave badly in the event of accidental shutdown anyway, and we
should fix them.  Well-designed applications are explicitly 'serially
reuseable', in other words, you can interrupt at any point and start
again from the beginning with valid and expected results.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
