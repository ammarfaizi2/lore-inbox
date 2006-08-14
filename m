Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHNQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHNQJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHNQJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:09:33 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:19177 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1751134AbWHNQJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:09:32 -0400
Date: Mon, 14 Aug 2006 12:09:28 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Message-ID: <20060814160927.GB5255@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Torokhov <dtor@insightbb.com>,
	Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>
References: <200608121724.16119.wigge@bigfoot.com> <20060812165228.GA5255@aehallh.com> <200608122000.47904.dtor@insightbb.com> <20060813032821.GB5251@aehallh.com> <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com> <20060814142826.GD5251@aehallh.com> <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2006 at 11:00:55AM -0400, Dmitry Torokhov wrote:
> On 8/14/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >On Mon, Aug 14, 2006 at 10:20:09AM -0400, Dmitry Torokhov wrote:
> >>
> >> I've been thinking about all of this and all of it is very fragile and
> >> unwieldy and I am not sure that we really need another ioctl after
> >> all. The only issue we have right now is that mousedev delivers
> >> undesirable events through /dev/input/mice while there is better
> >> driver listening to /dev/input/eventX and they clash with each other.
> >> Still, /dev/input/mice is nice for dealing with hotplugging of simple
> >> USB mice. So can't we make mousedev only multiplex devices that are
> >> not opened directly (where directly is one of mouseX, jsX, tsX, or
> >> evdevX)? We could even control this behavior through a module
> >> parameter. Then noone (normally) would need to use EVIOCGRAB.
> >
> >Sadly, the case of using EVIOCGRAB for mice to stop the use of
> >/dev/input/mice is actually not the primary usage.
> >
> >xf86-input-evdev will more or less happily continue talking to a mouse
> >that it can't grab, however things become somewhat more problematic when
> >it comes to keyboards.
> >
> >X needs to keep the keyboard driver from receiving events while it has
> >it open
> 
> Keyboard... can't X just ignore data from old keyboard driver while
> evdev-based keyboard driver is used?

The problem is that without xf86-input-keyboard X ignores the keyboard
entirely, which means that the console driver gets it, so ctrl-C sends
signals, alt-F<n> switches consoles on you, etc.

Additional code to open the console, put the keyboard in raw mode, and
throw everything away would be problematic for a few reasons, one of
which being that people have managed, with grab, to keep X from being
attached to an actual console. (Used for multiple X sessions running at
once for instance.)

It also would mean that xf86-input-evdev would have to touch stuff that
otherwise it wouldn't have to come anywhere near.

Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I've always taken the position that if you can't find anything bad  to
say about a language or an operating system then you don't  understand
it. I also agree with you about the advocacy. AHS. ASS.
  -- Shmuel (Seymour J.) Metz in the Scary Devil Monastery.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE4KA3RFMAi+ZaeAERAhcoAKDejdfr8+10crvHPuhNOmTvUwzVOgCgxPla
3UbY8TSJwb9W0UhUr19L7m4=
=IMhB
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
