Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWH2Ios@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWH2Ios (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWH2Ios
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:44:48 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:30129 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1750834AbWH2Ior (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:44:47 -0400
Date: Tue, 29 Aug 2006 04:44:43 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
Message-ID: <20060829084443.GA4187@aehallh.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <1156839019.2722.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <1156839019.2722.39.camel@laptopd505.fenrus.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2006 at 10:10:19AM +0200, Arjan van de Ven wrote:
> > +#undef DEBUG
> > +#ifdef DEBUG
> > +#define dbg(format, arg...) printk(KERN_INFO "olpc.c(%d): " format "\n", __LINE__, ## arg)
> > +#else
> > +#define dbg(format, arg...) do {} while (0)
> > +#endif
> 
> why not use pr_debug or even dev_debug() ?
> Those already have this ifdef included

I was not thinking of them at the time, however dev_dbg is not an option
because we do not have a struct device at hand when we want to print
some debugging lines.

pr_debug might work, but I would rather have file and line already
there.

Though, admittedly, that would be a better argument if it used __FILE__
there instead of hard coding it.

In any case, I don't think any of the debug prints will have to stick
around that much longer.
> 
> > +
> > +static struct olpc_model_info olpc_model_data[] = {
> > +	{ { 0x67, 0x00, 0x0a }, 0xeb, 0xff, OLPC_PTGS },	/* OLPC in PT+GS mode. */
> > +};
> 
> const?

Added.
(Along with associated changes so that it's kept const everywhere.)
> 
> also.. there's no locking visible anywhere in the driver... is this
> right?

It looks like psmouse handles it with a mutex lock around freeing stuff
and calling the callback function pointers we set on init, so we
_should_ be safe unless I've missed something.

Add to it that none of the other psmouse drivers are doing locking on
their own, and I'm fairly sure that this is correct. (But if someone
knows better, please correct me.)


Thank you.

Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Mike Sphar (Scary Devil Monastery):
>I am hired because I know what I am doing, not because I will do
>whatever I am told is a good idea.  This might cost me bonuses, raises,
>promotions, and may even label me as "undesirable" by places I don't
>want to work at anyway, but I don't care.  I will not compromise my own
>principles and judgement without putting up a fight.  Of course, I
>won't always win, and I will sometimes be forced to do things I don't
>agree with, but if I am my objections will be known, and if I am shown
>to be right and problems later develop, I will shout "I told you so!"
>repeatedly, laugh hysterically, and do a small dance or jig as
>appropriate to my heritage.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE8/57RFMAi+ZaeAERAuMNAJ92sEh65cI8SwDkHbVtVTc7Yeqs4ACfQ0jj
tjlmifvL4Swv0WsuxRpO4uY=
=DIfY
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
