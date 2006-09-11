Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWIKTDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWIKTDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWIKTDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:03:43 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:63627 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S964953AbWIKTDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:03:42 -0400
Date: Mon, 11 Sep 2006 15:03:39 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC] OLPC tablet input driver, take two.
Message-ID: <20060911190339.GT4181@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <20060910201036.GD4187@aehallh.com> <200609101819.32176.dtor@insightbb.com> <20060911182733.GR4181@aehallh.com> <d120d5000609111201x6d901d2do5d3c2eb934930e4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmVHo2jXx4bdYlgS"
Content-Disposition: inline
In-Reply-To: <d120d5000609111201x6d901d2do5d3c2eb934930e4f@mail.gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmVHo2jXx4bdYlgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2006 at 03:01:35PM -0400, Dmitry Torokhov wrote:
> On 9/11/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >On Sun, Sep 10, 2006 at 06:19:31PM -0400, Dmitry Torokhov wrote:
> >> >
> >> > @@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
> >> >   */
> >> >                     max_proto = PSMOUSE_IMEX;
> >> >             }
> >> > +           ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> >>
> >> Do we have to do 2nd reset here? Plus logic seems a bit fuzzy here -
> >> if ALPS is detected but initizliztion fails it will start OLPC detection
> >> which is probably not what you wanted...
> >
> >Reset is _probably_ not necessary, I'll verify.
> >
> >However the logic is the same as for all the others, if init succeeds,
> >it returns PSMOUSE_ALPS, if it doesn't then it continues on to the next,
> >which happens to be olpc, admittedly it would be more obvious that it's
> >doing the same thing if it was in its own if, but.
> 
> Not exactly. We have 2 types of protocols - some have only detect,
> others have both detect and init. For protocols that have both detect
> and init we expect detect to reliably identify whether the device is
> of given type or not and once detect succeeds we do not try to probe
> for other speciality protocols. For example if alps_detect succeeds
> but alps_init fails we won't try Genius detection (we will only try
> standard imex, exps and bare) and we should not try OLPC detection
> either.

Ah, I had misread the if.  Corrected in the patch that just went out.

Thank you.
Zephaniah E. Hull.
> 
> -- 
> Dmitry
> 

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"This system operates under martial law. The constitution is suspended. You
 have no rights except as declared by the area commander. Violators will be
  shot. Repeat violators will be repeatedly shot...."       -from "A_W_O_L"

--cmVHo2jXx4bdYlgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBbMLRFMAi+ZaeAERAopIAKCnZzNjPz1MnDPlWY9J07XMyImEfQCgozHo
s5WAienIctk82viHAxzMRew=
=BZ78
-----END PGP SIGNATURE-----

--cmVHo2jXx4bdYlgS--
