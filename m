Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWH2OfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWH2OfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWH2OfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:35:08 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:56258 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S964996AbWH2OfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:35:05 -0400
Date: Tue, 29 Aug 2006 10:35:02 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
Message-ID: <20060829143502.GC4187@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <d120d5000608290553t275b4acar925f66b3d0c7434b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <d120d5000608290553t275b4acar925f66b3d0c7434b@mail.gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2006 at 08:53:17AM -0400, Dmitry Torokhov wrote:
> Hi,
> 
> On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >The OLPC will ship with a somewhat unique input device made by ALPS,
> >connected via PS/2 and speaking a protocol only loosely based on that
> >spoken by other ALPS devices.
> >
> 
> Do you have a formal programming spec for it?

Not that I can currently distribute.

Converting to html, trimming out hardware detail, and feeding it through
channels for ALPS to say that they are comfortable with the amount of
data being released is on my todo list, but behind a few other things.
> 
> >This is required by the noticeable different between this device and
> >others made by alps, specificly that it is very wide, with the center
> >1/3rd usable with the GS sensor, and the entire area usable with the PT
> >sensor, with support for using both at once.
> >
> 
> Coudl youp please tell me what GS and PT stand for?

Glide Sensor, and PenTablet.
> 
> >The protocol differs enough that I split the driver for this off from
> >the ALPS driver.
> >
> >The patch is below, but there are a few things of note.
> >
> >1: Cosmetic: Some line lengths, and outputs with debugging enabled, are
> >over 80 columns wide.  Will be fixed in the next version of this patch.
> >
> 
> If going to 80 colums will require monstrocities like this:
> 
> ... do_bla(struct_b->
>               array_g[
>               index_i].
>               submember);
> 
> (and I seen quite a few such attempts to "improve" code) then please don't 
> ;)

Understood. :)
> 
> >2: Cosmetic: Input device IDs need to be decided on, some feedback on
> >the best values to use here would be appreciated.
> 
> I think what you've done is fine.
> 
> >
> >3: Patch stuff: Because the protocol uses 9 byte packets I had to
> >increase the size of the buffer in struct psmouse.  Should this be split
> >off into a separate patch?
> >
> 
> No.
> 
> >4: Technical/policy: Buttons are currently sent to both of the input
> >devices we generate, I don't see any way to avoid this that is not a
> >policy decision on which buttons belong to which device, but I'm open to
> >suggestions.
> >
> 
> Is it not known how actual hardware wired?

Hardware is wired with one device, which is quite wide.  The entire
width can be accessed via the PT sensor, and the middle 1/3rd with the
GS sensor.

I believe that the buttons will be one on each side, though I'm not
positive, and the PT data, the GS data, and the button data all arrive
in the same packet.

So really there is no 'right' way from the kernel driver's point of
view, the buttons belong equally to both.

The kernel driver that this will be matched with will probably leave it
as a user configuration setting as to which one it will throw button
presses away for.

> >+#define OLPC_PT                0x01
> >+#define OLPC_GS                0x02
> >+#define OLPC_PTGS      0x04
> >+
> 
> Do you need a separate #define? I'd expect it to be OLPC_PT | OLPC_GS?

Actually it's going away, as the driver is simply not going to try to
handle PT or GS mode separate from PT+GS, after more thought there was
little to gain from it.

> >+/*
> >+ * olpc_poll() - poll the touchpad for current motion packet.
> >+ * Used in resync.
> >+ */
> >+static int olpc_poll(struct psmouse *psmouse)
> >+{
> >+       /*
> >+        * FIXME: We can't poll, find a way to make resync work better.
> >+        */
> >+       return 0;
> >+}
> 
> I'd expect it to return -1. It's OK that it can't poll, it looks like
> it should resync fairly well on its own.

Alright, I'll give that a try.

> >+       dev2->name = "OLPC OLPC GlideSensor";
> 
> "OLPC OLPC"?

To match the first one, with a protocol name of OLPC and a vendor of
OLPC we end up with 'OLPC OLPC' for the first one, this is, IMHO, rather
suboptimal, but I'm not sure what else to do here.

Suggestions are most welcome. :)


Thanks a ton for the review.
Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I could imagine that there might be some GPL project out there that
_deserves_ getting sued(*) and it has nothing to do with Linux.

                Linus

(*) "GNU Emacs, the defendent, did inefariously conspire to play
towers-of-hanoy, while under the guise of a harmless editor".

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE9FCVRFMAi+ZaeAERAsaiAKDLly+US98Pp/Ta4IAV9etJ90cRUACfZqA4
+oGFlvtsXylcyC9s9fAEhNM=
=1f5i
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
