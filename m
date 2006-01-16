Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWAPO6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWAPO6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWAPO6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:58:35 -0500
Received: from sipsolutions.net ([66.160.135.76]:53768 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750845AbWAPO6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:58:34 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Benc <jbenc@suse.cz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <20060116152312.6b9ddfd0@griffin.suse.cz>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
	 <20060116152312.6b9ddfd0@griffin.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7iMWWHwt7HsYxnd7U9+v"
Date: Mon, 16 Jan 2006 15:55:55 +0100
Message-Id: <1137423355.2520.112.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7iMWWHwt7HsYxnd7U9+v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-01-16 at 15:23 +0100, Jiri Benc wrote:

> You are right. But it breaks compatibility with iwconfig unless we
> emulate 'iwconfig mode' command by deleting and adding interface. This
> means some events are generated, hotplug/udev gets involved etc.  In the
> worst case it can mean that we end up with interface with a different
> name.

Eh, right. In that case, I guess that dropping compatibility here would
be the only solution. Other iwconfig could still work though. I don't
know where to draw the line.

> I'm not sure about your concept of softmac modules. I wrote an e-mail
> some time ago explaining why I don't think it is useful and I haven't
> got any reply. Please, could you answer that e-mail first? (See
> http://marc.theaimsgroup.com/?l=3Dlinux-netdev&m=3D113404158202233&w=3D2)

I didn't really participate much in that thread. Maybe softmac was a bad
example for being a module -- it just seemed to fit the current model
that the in-kernel ieee80211 module follows.

> Could you also explain how would you implement separate module for AP
> mode? How would you bind that module to the rest of ieee80211,
> especially in the rx path?

Well, if you look at p80211 that davem wrote there are functions for
handling each type of the different receive frames. These could easily
be multiplexed into function pointers the module provides.

I really don't see why a plain STA mode card should be required to carry
around all the code required for AP operation -- handling associations
of clients, powersave management wrt. buffering, ... Sure, fragmentation
is needed for all, so it needs to be in the common code, and it might
make a lot of sense to unify WDS and STA modes, but AP mode requires
fundamentally different things and a lot of code that will never be
called in STA operation.
Putting it into the same modules and then probably into the same
structures just encourages bloat and interdependencies that I don't
think should be there.

johannes

--=-7iMWWHwt7HsYxnd7U9+v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8uz+aVg1VMiehFYAQJJAxAAxQAtQL+7CuRRmlTJ8mCmyaaf3teJrRVE
fSnS0HBrqckgfMIHHDzz4ZGF4qWUVbaR/ED4juW/16Uaf73jLllGZkVhC3IV0K3D
gbrIq2w0fufAEeKt1JYCMH9hTLbHsvcXBYt31s1pIlRd8d9rqZ2A8KiOaK8WlxD7
VKxgWzbqfVRhNKNxvTs3dKAZ6tMyTClxC0OTCDUZCNoTw5lOMSpNbudXFdwqNTPz
EZb/cfd9GrjJHh0a3gHqRRMwg12JnAR4dmv2YhA0TEVX/fvGQAltAhlaBtDwiBDB
4FUOUOdhrehYbeuMitd6m6uk7Wm8G4uYYVzz8YjUoFjQ3dhiym3bVI4SkdaBXYd4
TsDALen9bX/PY/eiwsC9qdRuUp9SsCjFmPl+U+FESmcrvneoUW8HIbaiUIHMyI6C
3HE3mhYLGcP7bl/Lh6dyg50hAOGTxh33nfVw/pr6Hnp0/Em8nUKtJtzDaaC+Cs8X
Br+FKawzgnxroZXJJUzltIhpIX/1sMkCkSY1slH4sfqiVbe4esAkhTZX8szlwZPm
xCrHK4IYXk5PMVIFA+YprkQtrNt4NLYh1q3zN0kfjxj9rHVuXJBnsRlBdvPZ5i/7
A4Pa61Ctg72ww/zKKa3u6YAkt86E2bw9TuO/bQBsn9Q9MesJLkIw9dFlLREL0Xem
uwrzxdyBfgE=
=ktyh
-----END PGP SIGNATURE-----

--=-7iMWWHwt7HsYxnd7U9+v--

