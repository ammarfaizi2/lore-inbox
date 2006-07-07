Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWGGBLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWGGBLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWGGBLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:11:46 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:32416 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751127AbWGGBLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:11:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pVrJYzOq3cJ91kpmpPPYqipCeuAXUkpzsSJNGC52xlINwioS4aJ5BolbIKmesMrbCS9e+fuRQBhBHXTiMXRNSztK1zcXMd0scmkPHvO9EkVghcfsxIeIGd4lrMKGTJc4yEAvYjWBksme1l/Vf9rH5LqFtjpn7XV8Y31rEdWRBg0=
Date: Thu, 6 Jul 2006 21:11:42 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060707011142.GA8900@phoenix>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Richard Purdie <rpurdie@rpsys.net>
References: <20060706193157.GC14043@phoenix> <1152225599.5544.202.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1152225599.5544.202.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 06 at 18:39 EDT, Richard Purdie hastily scribbled:
> On Thu, 2006-07-06 at 15:31 -0400, Thomas Tuttle wrote:
> > +#include <linux/config.h>
> Not needed.
Will be fixed.

> > +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> > +#include <linux/leds.h>
> > +#endif
> Doesn't need the ifdefs, the header should be harmless
Will be fixed.
>=20
> > +static struct led_classdev led_cdev_mled =3D
> > +        { .name =3D "asus:mail",     .brightness_set =3D led_set_mled =
};
> Not the formatting I'm used to but I'm not sure if it breaks the
> CodingStyle... :)
Will be fixed.

> > +/* These functions actually update the LED's, and are called from a
> > + * workqueue.  By doing this as separate work rather than when the
> > LED
> > + * subsystem asks, I avoid messing with the Asus ACPI stuff during a
> > + * potentially bad time, such as a timer interrupt. */
> More simply, "The led update functions can be called in interrupt
> context so we use a work queue to pass the updates to acpi" or similar.
Will be fixed.  I hope you don't mind being quoted.

> > +        hotk->status =3D (led_out) ? (hotk->status | MLED_ON) :
> > (hotk->status & ~MLED_ON);
> The lack of locking on hotk->status makes me nervous but since it
> appears to only contain LED data, its probably not too important and the
> write_led function already there is equally bad...
Agreed, if the other functions don't have problems, mine shouldn't.
Besides, the inconsistency wouldn't be life-threatening.  It's just
internal state, not hardware stuff.

> What happens if the first led_classdev_register succeeds and the
> subsequent calls fail? You need to think about all the different error
> cases here...
Will be fixed.

> Also, having looked at that ACPI driver, what happens to the existing
> LED access functions via proc and how do they coexist with the LED
> subsystem? Ultimately I guess they'd get removed but in the meantime
> they present a problem. The LED subsystem does not have a brightness_get
> function and assumes it has complete control of the LED. It therefore
> caches the brightness value internally to itself. If we have a lot of
> cases where this isn't going to work (like here), we could look at
> adding an optional brightness_get function but I'd prefer to keep
> complexity out of the class if possible. How common is that problem
> going to be I wonder...
/me figures, leave it to the user.  Just as it's unwise but possible to
run two userspace CPU governors, it's unwise to tell the LED subsystem
to control LEDs and then change them yourself.  I don't think it's an
issue, but if you really want, I can make it so the /proc functions are
disabled unless the trigger is set to "none".

I've already written an email in response to Andrew Morton's suggestions
(many of which you also made) and it will contain yet another revision
of the patch.

--Thomas Tuttle

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErbTO/UG6u69REsYRAtaNAJ45g/DW4VTbl9DG1IOyzpRjqZZWAgCZAbW1
hsxjjTq9yLPKCzA+W38sL8s=
=noe4
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
