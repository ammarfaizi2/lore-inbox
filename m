Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWH2Kky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWH2Kky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWH2Kky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:40:54 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:25781 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S932254AbWH2Kkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:40:53 -0400
Date: Tue, 29 Aug 2006 06:40:49 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
Message-ID: <20060829104049.GB4181@aehallh.com>
Mail-Followup-To: Komal Shah <komal_shah802003@yahoo.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <20060829085537.22755.qmail@web37903.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20060829085537.22755.qmail@web37903.mail.mud.yahoo.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2006 at 01:55:37AM -0700, Komal Shah wrote:
> --- "Zephaniah E. Hull" <warp@aehallh.com> wrote:
> 
> > 
> > 
> > That said, here the patch is for comments.
> > (And possibly for the OLPC kernel tree for others with samples to
> > play
> > with.)
> > 
> > 
> > Signed-off-by: Zephaniah E. Hull <warp@aehallh.com>
> > 
> > diff --git a/drivers/input/mouse/Makefile
> > b/drivers/input/mouse/Makefile
> > index 21a1de6..6218e5a 100644
> > --- a/drivers/input/mouse/Makefile
> > +++ b/drivers/input/mouse/Makefile
> > @@ -14,4 +14,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
> >  obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
> >  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
> >  
> > -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> > lifebook.o trackpoint.o
> > +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> > lifebook.o trackpoint.o olpc.o
> 
> Where is KConfigurable entry ?

It is a component of psmouse.o, which is a few lines up.

Breaking out the components of psmouse.o into separate configuration
items might be interesting, but it is quite a bit beyond the scope of
this patch.
> 
> > diff --git a/drivers/input/mouse/olpc.c b/drivers/input/mouse/olpc.c
> > new file mode 100644
> > index 0000000..245f29e
> > --- /dev/null
> > +++ b/drivers/input/mouse/olpc.c
> > @@ -0,0 +1,327 @@
> 
> 
> > +/*
> > + * OLPC touchpad PS/2 mouse driver
> > + *
> > +int olpc_init(struct psmouse *psmouse)
> > +{
> > +	struct olpc_data *priv;
> > +	struct input_dev *dev = psmouse->dev;
> > +	struct input_dev *dev2;
> > +
> > +	psmouse->private = priv = kzalloc(sizeof(struct olpc_data),
> > GFP_KERNEL);
> 
> I think you should assign priv to private only if !NULL.

Fixed.

It should not actually matter, as a failure to get a !NULL value causes
us to return false, which will fall over to other psmouse drivers which
will either set it themselves, or not use it at all, however.

It should be noted that alps.c contains the same issue.

> > +	input_register_device(priv->dev2);
> 
> Please check the return value of input_register_device and its friends.

Alright, added to my todo, should have it done by the next patch
revision.


Thank you very much.
Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"And now, little kittens, we're going to run across red-hot
motherboards, with our bare feet." -- Buzh.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE9BmxRFMAi+ZaeAERAq1WAJ93EqSaqf4309qyO9PnKaUSFxxV0ACgvlbA
7xggqCPqzIcaj1dZEK13k6I=
=tBVo
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
